import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Exploration — Next health route",
  description: "career-playbook exploration sandbox",
};

/**
 * Root layout wraps every page. Think of it as the HTML shell Next injects around your routes.
 */
export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
