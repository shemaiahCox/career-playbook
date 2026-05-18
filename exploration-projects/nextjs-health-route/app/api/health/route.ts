import { NextResponse } from "next/server";

/**
 * Route Handler: a function that responds to HTTP verbs for this path segment.
 * Lives next to `page.tsx` concepts but executes only for /api/health requests.
 *
 * Compare: a small Express `app.get('/api/health', ...)` — different file wiring, same shape.
 */
export async function GET() {
  const body = {
    ok: true,
    service: "nextjs-health-route",
    at: new Date().toISOString(),
  };
  return NextResponse.json(body);
}
