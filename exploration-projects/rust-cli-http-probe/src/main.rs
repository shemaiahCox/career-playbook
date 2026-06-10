//! Command http-probe performs a single HTTP GET with a deadline and prints a short summary.
//!
//! Learning goals (mirrors go-cli-http-probe):
//!   - Read flags from the shell (`clap` derive).
//!   - Call the network with a bounded wait (`ureq` agent timeout).
//!   - Handle errors explicitly with `Result` and `?` — no exceptions.

use clap::Parser;
use std::io::Read;
use std::process;

/// CLI arguments — `clap` fills these from `std::env::args` when you run the binary.
#[derive(Parser, Debug)]
#[command(about = "HTTP GET probe with timeout (Rust sandbox for career-playbook)")]
struct Args {
    /// Full URL to request (scheme required, e.g. https://...)
    #[arg(long, default_value = "https://example.com")]
    url: String,

    /// Give up waiting for the server after this many seconds
    #[arg(long, default_value_t = 10)]
    timeout_secs: u64,

    /// Maximum response body bytes to read (truncates larger responses)
    #[arg(long, default_value_t = 2048)]
    max_body: usize,
}

fn main() {
    let args = Args::parse();

    // Agent holds connection settings (timeout) reused across requests.
    let agent = ureq::AgentBuilder::new()
        .timeout(std::time::Duration::from_secs(args.timeout_secs))
        .build();

    if let Err(e) = probe(&agent, &args) {
        eprintln!("error: {e}");
        process::exit(1);
    }
}

/// probe runs one GET and prints a concise summary to stdout.
fn probe(agent: &ureq::Agent, args: &Args) -> Result<(), Box<dyn std::error::Error>> {
    // `?` returns early on transport errors (DNS, timeout, connection refused).
    let response = agent.get(&args.url).call()?;

    let status = response.status();
    let content_type = response
        .header("Content-Type")
        .unwrap_or("-")
        .to_string();

    // LimitReader pattern: read at most max_body bytes into memory.
    let mut reader = response.into_reader().take(args.max_body as u64);
    let mut body_bytes = Vec::new();
    reader.read_to_end(&mut body_bytes)?;

    let body_preview = String::from_utf8_lossy(&body_bytes);

    println!("url: {}", args.url);
    println!("status: {status} {}", status_phrase(status));
    println!("content-type: {content_type}");
    println!(
        "body (first {} bytes, trimmed):\n{}",
        args.max_body,
        body_preview.trim()
    );

    // Mirror curl / Go probe: HTTP 4xx/5xx is a failed run even if TCP succeeded.
    if status >= 400 {
        process::exit(1);
    }

    Ok(())
}

fn status_phrase(code: u16) -> &'static str {
    match code {
        200 => "OK",
        404 => "Not Found",
        _ => "",
    }
}
