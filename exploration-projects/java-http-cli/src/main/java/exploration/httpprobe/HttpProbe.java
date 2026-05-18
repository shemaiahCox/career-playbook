package exploration.httpprobe;

import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Locale;

/**
 * HTTP GET probe with deadline — Java edition.
 *
 * <p>Mirrors exploration-projects/go-cli-http-probe for apples-to-apples learning:
 *
 * <ul>
 *   <li>Parse CLI flags manually (simple loop — swap later for Picocli / commons-cli).
 *   <li>Bounded wait via {@link HttpRequest.Builder#timeout(Duration)} on Java 11+ {@link HttpClient}.
 *   <li>Prefer explicit stderr messages + exit codes instead of swallowed exceptions.
 * </ul>
 *
 * <p>Companion vocabulary: ../../docs/stacks/java-jvm.md
 */
public final class HttpProbe {

    private HttpProbe() {}

    public static void main(String[] args) {
        Cli cli = Cli.parse(args);

        Duration deadline = Duration.ofMillis(cli.timeoutMs);

        HttpClient client =
                HttpClient.newBuilder().connectTimeout(deadline).followRedirects(HttpClient.Redirect.NORMAL).build();

        HttpRequest request =
                HttpRequest.newBuilder()
                        .uri(URI.create(cli.url))
                        .timeout(deadline)
                        .GET()
                        .build();

        HttpResponse<InputStream> response;
        try {
            response = client.send(request, HttpResponse.BodyHandlers.ofInputStream());
        } catch (IOException | InterruptedException e) {
            // InterruptedException clears interrupt flag — restore thread interrupt status.
            if (e instanceof InterruptedException) {
                Thread.currentThread().interrupt();
            }
            System.err.println("request failed: " + e.getMessage());
            System.exit(1);
            return;
        }

        byte[] snippet;
        try (InputStream in = response.body()) {
            snippet = in.readNBytes(cli.maxBody);
        } catch (IOException e) {
            System.err.println("read body failed: " + e.getMessage());
            System.exit(1);
            return;
        }

        String preview = new String(snippet, StandardCharsets.UTF_8).trim();

        System.out.println("url: " + cli.url);
        // HttpClient exposes numeric status only — unlike okhttp/curl status phrases.
        System.out.println("status: " + response.statusCode());
        System.out.println(
                "content-type: "
                        + response.headers().firstValue("Content-Type").orElse("-"));
        System.out.println("body (first " + cli.maxBody + " bytes, trimmed):\n" + preview);

        if (response.statusCode() >= 400) {
            System.exit(1);
        }
    }

    /** Parsed CLI equivalent to Go flags in go-cli-http-probe. */
    private static final class Cli {
        final String url;
        final long timeoutMs;
        final int maxBody;

        Cli(String url, long timeoutMs, int maxBody) {
            this.url = url;
            this.timeoutMs = timeoutMs;
            this.maxBody = maxBody;
        }

        static Cli parse(String[] args) {
            String url = "https://example.com";
            String timeoutRaw = "10s";
            int maxBody = 2048;

            for (int i = 0; i < args.length; i++) {
                String a = args[i];
                switch (a) {
                    case "--url":
                        requireValue(args, ++i, "--url");
                        url = args[i];
                        break;
                    case "--timeout":
                        requireValue(args, ++i, "--timeout");
                        timeoutRaw = args[i];
                        break;
                    case "--max-body":
                        requireValue(args, ++i, "--max-body");
                        maxBody = Integer.parseInt(args[i]);
                        break;
                    default:
                        System.err.println("unknown argument: " + a);
                        System.exit(2);
                }
            }

            long timeoutMs;
            try {
                timeoutMs = parseDurationMs(timeoutRaw);
            } catch (IllegalArgumentException ex) {
                System.err.println(ex.getMessage());
                System.exit(2);
                throw new AssertionError();
            }

            if (maxBody < 1) {
                System.err.println("invalid --max-body \"" + maxBody + "\"");
                System.exit(2);
                throw new AssertionError();
            }

            return new Cli(url, timeoutMs, maxBody);
        }

        static void requireValue(String[] args, int idx, String flagName) {
            if (idx >= args.length || args[idx].startsWith("--")) {
                System.err.println(flagName + " requires a value");
                System.exit(2);
            }
        }

        /** Match tiny duration inputs used across siblings: {@code 500ms}, {@code 10s}, {@code 2m}. */
        static long parseDurationMs(String raw) {
            String s = raw.trim().toLowerCase(Locale.ROOT);
            if (s.endsWith("ms")) {
                long n = Long.parseLong(s.substring(0, s.length() - 2));
                return n;
            }
            if (s.endsWith("s") && !s.endsWith("ms")) {
                long n = Long.parseLong(s.substring(0, s.length() - 1));
                return n * 1000L;
            }
            if (s.endsWith("m")) {
                long n = Long.parseLong(s.substring(0, s.length() - 1));
                return n * 60_000L;
            }
            throw new IllegalArgumentException(
                    "invalid --timeout \"" + raw + "\" (use e.g. 10s, 500ms, 2m)");
        }
    }
}
