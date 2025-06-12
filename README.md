# ProxCop - Clipboard Protection Against LLM Fingerprinting

## Overview

With recent discussions about LLM fingerprinting and invisible character exploits, we designed ProxCop as a lightweight macOS application to protect users against these emerging security threats. ProxCop continuously monitors your clipboard and automatically removes potentially malicious characters that could be used for tracking, fingerprinting, or other privacy violations.

## What is LLM Fingerprinting?

LLM fingerprinting is a technique where invisible or hidden characters are embedded in text to track how that text is used, shared, or processed by language models. These characters can:

- Track the origin and distribution of text content
- Identify specific users or sessions
- Monitor how content flows through different systems
- Potentially compromise privacy in AI interactions

## How ProxCop Protects You

ProxCop runs silently in the background and:

1. **Real-time Monitoring**: Watches your clipboard for any copied text
2. **Character Filtering**: Automatically removes specified suspicious characters
3. **Instant Notifications**: Alerts you when potentially malicious content is detected and cleaned
4. **Seamless Operation**: Works transparently without disrupting your workflow

## Features

- ✅ Real-time clipboard monitoring
- ✅ Configurable character filtering (currently removes 'a' and 'p' as examples)
- ✅ macOS native notifications when threats are detected
- ✅ Lightweight background operation
- ✅ No network connections or data collection
- ✅ Open source and auditable

## Technical Details

ProxCop is built in Swift using:
- `NSPasteboard` for clipboard monitoring
- `UserNotifications` for system alerts
- `NSApplication` with accessory policy for background operation

The application checks clipboard changes every 0.5 seconds and processes any text content to remove potentially harmful characters.

## Installation & Usage

### Building from Source

1. Clone this repository
2. Open Terminal and navigate to the project directory
3. Run `swift build -c release`
4. The executable will be available in `.build/release/proxcop`

### Running

Execute the built binary:
```bash
./proxcop
```

The app will run in the background and notify you of any clipboard cleaning activities.

## Configuration

Currently, the app filters specific characters defined in the `charactersToTrim` set. You can modify this in `Sources/main.swift`:

```swift
let charactersToTrim: Set<Character> = ["a", "p"] // Add your suspicious characters here
```

## Privacy & Security

- **No Data Collection**: ProxCop does not collect, store, or transmit any of your data
- **Local Processing**: All clipboard analysis happens locally on your device
- **Open Source**: Full source code is available for audit and review
- **Minimal Permissions**: Only requires clipboard access and notification permissions

## Contributing

We welcome contributions to improve ProxCop's security features and detection capabilities. Please feel free to:

- Report issues or suspected vulnerabilities
- Suggest additional character patterns to filter
- Contribute code improvements
- Share research on new fingerprinting techniques

## License

This project is open source. See LICENSE file for details.

## Disclaimer

ProxCop is designed to protect against known clipboard-based fingerprinting techniques. As new methods emerge, the filtering rules may need updates. This tool is provided as-is and users should stay informed about evolving security threats.