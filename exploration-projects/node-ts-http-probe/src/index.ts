/**
 * HTTP GET probe with deadline — TypeScript + Node edition.
 *
 * Mirrors exploration-projects/go-cli-http-probe for apples-to-apples learning:
 *   - Parse CLI flags (Node built-in parseArgs instead of Go flag package).
 *   - Bounded wait on network I/O (AbortSignal.timeout).
 *   - Prefer explicit branches over swallowed errors (prints to stderr, process.exit).
 *
 * Companion vocabulary: ../../docs/stacks/node-typescript-backend.md
 */
import { parseArgs } from "node:util";
import process from "node:process";

/** Parse tiny duration strings like Go's flag.Duration: "500ms", "10s", "2m". */
function parseDurationMs(raw: string): number {
  const m = /^(\d+)(ms|s|m)$/u.exec(raw.trim());
  if (!m || !m[1] || !m[2]) {
    throw new Error(`invalid --timeout "${raw}" (use e.g. 10s, 500ms, 2m)`);
  }
  const n = Number(m[1]);
  const unit = m[2];
  switch (unit) {
    case "ms":
      return n;
    case "s":
      return n * 1000;
    case "m":
      return n * 60_000;
    default:
      throw new Error(`unsupported unit in "${raw}"`);
  }
}

function headerOrDash(headers: Headers, name: string): string {
  const v = headers.get(name);
  return v ?? "-";
}

async function main(): Promise<void> {
  const { values } = parseArgs({
    args: process.argv.slice(2),
    options: {
      url: { type: "string", default: "https://example.com" },
      timeout: { type: "string", default: "10s" },
      "max-body": { type: "string", default: "2048" },
    },
    strict: true,
    allowPositionals: false,
  });

  const url = values.url ?? "https://example.com";
  const timeoutMs = parseDurationMs(values.timeout ?? "10s");
  const maxBody = Number(values["max-body"] ?? "2048");
  if (!Number.isFinite(maxBody) || maxBody < 1) {
    console.error(`invalid --max-body "${values["max-body"]}"`);
    process.exit(1);
  }

  // AbortSignal.timeout integrates with fetch — cooperative cancellation at the HTTP layer.
  const signal = AbortSignal.timeout(timeoutMs);

  let response: Response;
  try {
    response = await fetch(url, { method: "GET", signal });
  } catch (err) {
    console.error(`request failed: ${err instanceof Error ? err.message : String(err)}`);
    process.exit(1);
  }

  const buf = await response.arrayBuffer();
  const slice = buf.byteLength > maxBody ? buf.slice(0, maxBody) : buf;
  const bodyPreview = new TextDecoder("utf-8", { fatal: false }).decode(slice).trim();

  const statusText =
    typeof response.statusText === "string" && response.statusText.length > 0
      ? response.statusText
      : ""; // fetch leaves statusText empty sometimes

  console.log(`url: ${url}`);
  console.log(`status: ${response.status}${statusText ? ` ${statusText}` : ""}`);
  console.log(`content-type: ${headerOrDash(response.headers, "content-type")}`);
  console.log(`body (first ${maxBody} bytes, trimmed):\n${bodyPreview}`);

  if (response.status >= 400) {
    process.exit(1);
  }
}

main().catch((err: unknown) => {
  console.error(`fatal: ${err instanceof Error ? err.message : String(err)}`);
  process.exit(1);
});
