import Foundation

/**
 Small HTTP GET probe — Swift concurrency edition.

 Mirrors sibling sandboxes (`go-cli-http-probe`, `java-http-cli`) so you can compare:
 - CLI parsing (`CommandLine.arguments`)
 - deadlines (`URLRequest.timeoutInterval`)
 - bounded reads (`Data.prefix`)

 Companion vocabulary: ../../docs/stacks/swift-ios.md

 Note: SwiftPM executable — **no Xcode UI project required** for this lane.
 */

enum ProbeExitCode: Int32 {
    case ok = 0
    case transportOrHttpFailure = 1
    case badArgs = 2
}

struct Cli {
    var url: String = "https://example.com"
    var timeoutRaw: String = "10s"
    var maxBody: Int = 2048

    static func parse(_ args: [String]) throws -> Cli {
        var cli = Cli()
        var i = 0
        while i < args.count {
            let flag = args[i]
            switch flag {
            case "--url":
                i += 1
                let value = try Cli.requireValue(args, index: i, flag: "--url")
                cli.url = value
                i += 1
            case "--timeout":
                i += 1
                let value = try Cli.requireValue(args, index: i, flag: "--timeout")
                cli.timeoutRaw = value
                i += 1
            case "--max-body":
                i += 1
                let value = try Cli.requireValue(args, index: i, flag: "--max-body")
                guard let n = Int(value), n >= 1 else {
                    throw ProbeError.invalidMaxBody(value)
                }
                cli.maxBody = n
                i += 1
            default:
                throw ProbeError.unknownArgument(flag)
            }
        }
        return cli
    }

    static func requireValue(_ args: [String], index: Int, flag: String) throws -> String {
        guard index < args.count else {
            throw ProbeError.missingValue(flag)
        }
        let value = args[index]
        guard !value.hasPrefix("--") else {
            throw ProbeError.missingValue(flag)
        }
        return value
    }
}

enum ProbeError: Error, CustomStringConvertible {
    case unknownArgument(String)
    case missingValue(String)
    case invalidTimeout(String)
    case invalidMaxBody(String)

    var description: String {
        switch self {
        case let .unknownArgument(flag):
            return "unknown argument: \(flag)"
        case let .missingValue(flag):
            return "\(flag) requires a value"
        case let .invalidTimeout(raw):
            return "invalid --timeout \"\(raw)\" (use e.g. 10s, 500ms, 2m)"
        case let .invalidMaxBody(raw):
            return "invalid --max-body \"\(raw)\""
        }
    }
}

/// Match tiny duration inputs used across siblings: `500ms`, `10s`, `2m`.
func parseDurationSeconds(_ raw: String) throws -> TimeInterval {
    let s = raw.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    if s.hasSuffix("ms") {
        let head = String(s.dropLast(2))
        guard let n = Double(head) else { throw ProbeError.invalidTimeout(raw) }
        return n / 1000.0
    }
    if s.hasSuffix("s"), !s.hasSuffix("ms") {
        let head = String(s.dropLast(1))
        guard let n = Double(head) else { throw ProbeError.invalidTimeout(raw) }
        return n
    }
    if s.hasSuffix("m") {
        let head = String(s.dropLast(1))
        guard let n = Double(head) else { throw ProbeError.invalidTimeout(raw) }
        return n * 60.0
    }
    throw ProbeError.invalidTimeout(raw)
}

@main
enum HttpProbeApp {
    static func main() async {
        var rawArgs = Array(CommandLine.arguments.dropFirst())
        // `swift run … -- --flag value` forwards this `--` separator; tolerate it for README ergonomics.
        if rawArgs.first == "--" {
            rawArgs.removeFirst()
        }

        let cli: Cli
        do {
            cli = try Cli.parse(rawArgs)
        } catch {
            fputs("\(error)\n", stderr)
            exit(ProbeExitCode.badArgs.rawValue)
        }

        let timeoutSeconds: TimeInterval
        do {
            timeoutSeconds = try parseDurationSeconds(cli.timeoutRaw)
        } catch {
            fputs("\(error)\n", stderr)
            exit(ProbeExitCode.badArgs.rawValue)
        }

        guard let endpoint = URL(string: cli.url) else {
            fputs("invalid --url\n", stderr)
            exit(ProbeExitCode.badArgs.rawValue)
        }

        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        request.timeoutInterval = timeoutSeconds

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            fputs("request failed: \(error.localizedDescription)\n", stderr)
            exit(ProbeExitCode.transportOrHttpFailure.rawValue)
        }

        let http = response as? HTTPURLResponse
        let statusCode = http?.statusCode ?? -1

        let slice = data.prefix(cli.maxBody)
        let preview =
            String(decoding: slice, as: UTF8.self)
                .trimmingCharacters(in: .whitespacesAndNewlines)

        let contentType =
            http?.value(forHTTPHeaderField: "Content-Type") ?? "-"

        print("url: \(cli.url)")
        print("status: \(statusCode)")
        print("content-type: \(contentType)")
        print("body (first \(cli.maxBody) bytes, trimmed):\n\(preview)")

        if statusCode >= 400 {
            exit(ProbeExitCode.transportOrHttpFailure.rawValue)
        }
    }
}
