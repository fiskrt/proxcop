# ProxCop - Clipboard Protection Against LLM Fingerprinting

ProxCop is a lightweight macOS app that protects against LLM fingerprinting by automatically removing invisible characters from your clipboard. With recent discussions about invisible character exploits for tracking and fingerprinting, ProxCop provides real-time protection against these privacy threats.

## Features

- **Real-time clipboard monitoring** - Watches for copied text automatically
- **Invisible character removal** - Strips zero-width spaces, directional marks, and other hidden characters
- **Native notifications** - Alerts you when threats are detected and cleaned
- **Privacy-focused** - No data collection, local processing only
- **Lightweight** - Runs silently in the background

## Installation

1. Clone this repository
2. Run `swift build -c release`
3. Execute `.build/release/proxcop`

The app runs as a background service and will notify you when it cleans your clipboard.

## How It Works

ProxCop monitors your clipboard and removes these invisible characters:
- Zero Width Space (`\u{200B}`)
- Zero Width Non-Joiner (`\u{200C}`)
- Zero Width Joiner (`\u{200D}`)
- Directional formatting characters (`\u{202A}` - `\u{202E}`)
- Isolate characters (`\u{2066}` - `\u{2069}`)
- Word Joiner (`\u{2060}`)
- And more...

## Configuration

Modify the `charactersToTrim` set in `Sources/main.swift` to customize which characters are filtered.

## Contributing

Contributions welcome! Report issues, suggest new character patterns, or submit code improvements.