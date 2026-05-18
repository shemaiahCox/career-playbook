//! A tiny file-line pipeline for learning Rust's ownership and error types.
//!
//! Run:
//!     cargo run -- path/to/file.txt
//!
//! The program reads every line from the file and prints it with a line prefix.

// std::env = process environment (similar to getenv in C, args in Python's sys.argv).
use std::env;
// Buffered I/O: fewer syscalls than reading byte-by-byte from disk.
use std::fs::File;
use std::io::{self, BufRead, BufReader};
// OsString is UTF-8 *most* of the time; Paths exist because filenames can be weird.
use std::path::PathBuf;

fn main() {
    // main can return (); here we unwrap errors with expect for teaching clarity,
    // and show how to convert io::Result<()> into exit codes explicitly.
    if let Err(e) = run() {
        eprintln!("error: {e}");
        std::process::exit(1);
    }
}

// run separates "real logic" from process exit bookkeeping—a common Rust pattern.
fn run() -> io::Result<()> {
    // Collect CLI args; skip argv[0] which is the program name on most OSes.
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!(
            "usage: rust-text-pipeline <path/to/file.txt>\n\
             \n\
             Prints each source line prefixed with \"| \" (ownership + Result lab)."
        );
        // Invalid usage is treated as OS error kind Other for exit code consistency.
        return Err(io::Error::new(io::ErrorKind::Other, "missing file argument"));
    }

    // Clone the path fragment from args[1] into an owned PathBuf that we can pass on.
    // (We could also use PathBuf::from(args.swap_remove(1))—either way we end up owning the path.)
    let path_argument: PathBuf = PathBuf::from(args[1].clone());
    process_file(path_argument)
}

// process_file OWNS path: callers cannot use path afterward without borrowing rules.
fn process_file(path: PathBuf) -> io::Result<()> {
    // File::open returns Result<File>—the OS might deny access or missing file.
    let file: File = File::open(&path)?;

    // BufReader wraps the file for efficient line-oriented reads.
    let reader = BufReader::new(file);

    // lines() yields io::Result<String> because bytes might not be UTF-8.
    for maybe_line in reader.lines() {
        // The ? propagates Err up to main's run().
        let line: String = maybe_line?;

        // demonstrate_borrow receives &String (borrow) — we keep ownership of line later.
        let decorated: String = demonstrate_borrow(&line);

        println!("{decorated}");
    }

    // Ok(()) is an empty OK branch for Result<()>.
    Ok(())
}

// demonstrate_borrow takes a shared reference (&String) → does not steal ownership.
fn demonstrate_borrow(original: &String) -> String {
    // Prefix with | and re-use the borrowed text without copying twice.
    // format! allocates a NEW owned String—it does not mutate `original`.
    format!("| {original}")
}

// ---- Pedagogical appendix (not compiled as separate executable) -------------
//
// Ownership cheat sheet while you edit:
//
// ```text
//   let s = String::from("hi"); // s owns heap text
//   takes_ownership(s);         // s moved; cannot use s afterward
//
//   let mut s = String::from("x");
//   borrow_twice_ok(&mut s);     // exclusive borrow for mutation window
//
// References:
//     &T   immutable borrow — many readers okay
//     &mut T unique borrow — one writer
// ```
