/**
 * Default page ("/") — a **Server Component** by default (no `"use client"`).
 * It does not call our API to avoid localhost self-fetch quirks while you learn;
 * use curl or the browser address bar for /api/health (see README).
 */
export default function HomePage() {
  return (
    <main>
      <h1>Next.js exploration</h1>
      <p>
        This sandbox exists to teach <strong>App Router</strong> file layout and a{" "}
        <strong>Route Handler</strong> at <code>/api/health</code>.
      </p>
      <p>
        After <code>npm run dev</code>, open{" "}
        <a href="/api/health">
          <code>/api/health</code>
        </a>{" "}
        or run the curl in the README.
      </p>
    </main>
  );
}
