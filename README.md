# roomrental_app

## Build the iOS app from Windows

This project includes a GitHub Actions workflow that uses a macOS runner to
build the Flutter iOS app. From GitHub, open **Actions → Build iOS app →
Run workflow**. When the run finishes, download the
`roomrental-ios-unsigned` artifact.

The downloaded `roomrental-ios-unsigned.zip` contains `Payload/Runner.app`.
It is unsigned, so it cannot be installed directly on an iPhone. App Store,
TestFlight, or device installation requires Apple Developer signing
certificates and provisioning profiles.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
