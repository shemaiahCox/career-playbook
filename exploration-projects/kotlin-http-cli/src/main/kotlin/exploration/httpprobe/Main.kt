package exploration.httpprobe

import kotlin.system.exitProcess

import java.io.IOException
import java.net.URI
import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse
import java.nio.charset.StandardCharsets
import java.time.Duration
import java.util.Locale

/**
 * HTTP GET probe with deadline — Kotlin JVM edition.
 *
 * Mirrors exploration-projects/java-http-cli for apples-to-apples syntax comparison:
 * - Nullable returns (`firstOrNull`) vs Java `Optional`.
 * - String templates vs concatenation.
 * - Same HttpClient mechanics underneath (still JVM bytecode).
 *
 * Companion vocabulary (Kotlin ecosystem map): ../../docs/stacks/kotlin-android.md
 *
 * Note: This sandbox is intentionally **CLI-shaped on the JVM** — no Android SDK required.
 */
fun main(args: Array<String>) {
    val cli = Cli.parse(args)

    val deadline = Duration.ofMillis(cli.timeoutMs)

    val client =
        HttpClient.newBuilder()
            .connectTimeout(deadline)
            .followRedirects(HttpClient.Redirect.NORMAL)
            .build()

    val request =
        HttpRequest.newBuilder()
            .uri(URI.create(cli.url))
            .timeout(deadline)
            .GET()
            .build()

    val response: HttpResponse<java.io.InputStream> =
        try {
            client.send(request, HttpResponse.BodyHandlers.ofInputStream())
        } catch (e: IOException) {
            System.err.println("request failed: ${e.message}")
            exitProcess(1)
            error("unreachable")
        } catch (e: InterruptedException) {
            Thread.currentThread().interrupt()
            System.err.println("request failed: ${e.message}")
            exitProcess(1)
            error("unreachable")
        }

    val snippet: ByteArray =
        try {
            response.body().use { it.readNBytes(cli.maxBody) }
        } catch (e: IOException) {
            System.err.println("read body failed: ${e.message}")
            exitProcess(1)
            error("unreachable")
        }

    val preview = String(snippet, StandardCharsets.UTF_8).trim()

    println("url: ${cli.url}")
    println("status: ${response.statusCode()}")
    println("content-type: ${response.headers().firstValue("Content-Type").orElse("-")}")
    println("body (first ${cli.maxBody} bytes, trimmed):\n$preview")

    if (response.statusCode() >= 400) {
        exitProcess(1)
    }
}

private data class Cli(val url: String, val timeoutMs: Long, val maxBody: Int) {
    companion object {
        fun parse(args: Array<String>): Cli {
            var url = "https://example.com"
            var timeoutRaw = "10s"
            var maxBody = 2048

            var i = 0
            while (i < args.size) {
                when (val flag = args[i]) {
                    "--url" -> {
                        val value = requireValue(args, ++i, "--url")
                        url = value
                    }
                    "--timeout" -> {
                        val value = requireValue(args, ++i, "--timeout")
                        timeoutRaw = value
                    }
                    "--max-body" -> {
                        val value = requireValue(args, ++i, "--max-body")
                        maxBody = value.toInt()
                    }
                    else -> {
                        System.err.println("unknown argument: $flag")
                        exitProcess(2)
                    }
                }
                i++
            }

            val timeoutMs =
                try {
                    parseDurationMs(timeoutRaw)
                } catch (e: IllegalArgumentException) {
                    System.err.println(e.message)
                    exitProcess(2)
                    error("unreachable")
                }

            if (maxBody < 1) {
                System.err.println("invalid --max-body \"$maxBody\"")
                exitProcess(2)
            }

            return Cli(url, timeoutMs, maxBody)
        }

        private fun requireValue(args: Array<String>, idx: Int, flagName: String): String {
            if (idx >= args.size || args[idx].startsWith("--")) {
                System.err.println("$flagName requires a value")
                exitProcess(2)
            }
            return args[idx]
        }

        /** Match tiny duration inputs used across siblings: `500ms`, `10s`, `2m`. */
        private fun parseDurationMs(raw: String): Long {
            val s = raw.trim().lowercase(Locale.ROOT)
            return when {
                s.endsWith("ms") -> s.removeSuffix("ms").toLong()
                s.endsWith("m") -> {
                    val n = s.removeSuffix("m").toLong()
                    n * 60_000L
                }
                s.endsWith("s") -> {
                    val n = s.removeSuffix("s").toLong()
                    n * 1000L
                }
                else ->
                    throw IllegalArgumentException(
                        "invalid --timeout \"$raw\" (use e.g. 10s, 500ms, 2m)",
                    )
            }
        }
    }
}
