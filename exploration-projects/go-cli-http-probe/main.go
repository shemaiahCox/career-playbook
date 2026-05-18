// Command http-probe performs a single HTTP GET with a deadline and prints a short summary.
// Learning goals:
//   - Read flags from the shell (os.Args alternative: the "flag" package).
//   - Call the network with a bounded wait (context.WithTimeout).
//   - Handle errors explicitly: Go returns (result, error) instead of throwing.
package main

import (
	"context"
	"flag"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
	"time"
)

// main is the program entry point. There is no "main" class—just a function.
func main() {
	// ---- Parse command-line flags ------------------------------------------
	// flag.String returns a *pointer* to a string that the flag package fills in
	// during flag.Parse(). Using pointers lets the library update your variable.
	urlStr := flag.String(
		"url",
		"https://example.com",
		"Full URL to request (scheme required, e.g. https://...)",
	)

	// time.Duration parses human inputs like "3s", "500ms".
	timeout := flag.Duration(
		"timeout",
		10*time.Second,
		"Give up waiting for the server after this duration",
	)

	// Limit how many bytes of the body we read into memory—good habit for probes.
	maxBody := flag.Int64(
		"max-body",
		2048,
		"Maximum response body bytes to read (truncates larger responses)",
	)

	// Actually read os.Args and populate the pointers above.
	flag.Parse()

	// ---- Build HTTP client ---------------------------------------------------
	// Default client is reusable; timeouts belong on each request via context,
	// or you could set http.Client.Timeout (another valid style lesson).
	client := &http.Client{}

	// Parent context.Background() means "no automatic cancel unless we add one".
	ctx, cancel := context.WithTimeout(context.Background(), *timeout)
	// defer runs cancel() when main returns—releases timer resources promptly.
	defer cancel()

	// NewRequestWithContext ties our deadline to network operations below.
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, *urlStr, nil)
	if err != nil {
		// %v is default formatting; println to stderr preserves stdout for piping.
		fmt.Fprintf(os.Stderr, "cannot build request: %v\n", err)
		os.Exit(1)
	}

	// ---- Execute request ----------------------------------------------------
	resp, err := client.Do(req)
	if err != nil {
		fmt.Fprintf(os.Stderr, "request failed: %v\n", err)
		os.Exit(1)
	}
	// Bodies must be closed to reuse TCP connections (connection pooling).
	defer resp.Body.Close()

	// io.LimitReader prevents huge downloads from consuming RAM.
	limited := io.LimitReader(resp.Body, *maxBody)
	bodySnippet, err := io.ReadAll(limited)
	if err != nil {
		fmt.Fprintf(os.Stderr, "read body failed: %v\n", err)
		os.Exit(1)
	}

	// ---- Print concise, human-readable output -------------------------------
	statusLine := fmt.Sprintf("%d %s", resp.StatusCode, http.StatusText(resp.StatusCode))

	// Show the first non-empty lines of HTML/text so you recognize content.
	bodyPreview := strings.TrimSpace(string(bodySnippet))

	fmt.Printf("url: %s\n", *urlStr)
	fmt.Printf("status: %s\n", statusLine)
	fmt.Printf("content-type: %s\n", headerOrDash(resp.Header, "Content-Type"))
	fmt.Printf("body (first %d bytes, trimmed):\n%s\n", *maxBody, bodyPreview)

	if resp.StatusCode >= 400 {
		// Mirror curl: HTTP errors stay visible even though the TCP call "worked".
		os.Exit(1)
	}
}

// headerOrDash returns the first HTTP header value, or "-" if absent.
func headerOrDash(h http.Header, key string) string {
	// CanonicalMIMEHeaderKey ensures "content-type" and "Content-Type" match.
	canonicalKey := http.CanonicalHeaderKey(key)
	values := h[canonicalKey]
	if len(values) == 0 {
		return "-"
	}
	return values[0]
}
