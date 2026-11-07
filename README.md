# FlowReader

FlowReader is an Android reader app that reflows documents (PDF, EPUB, FB2)
into comfortable, re-flowable text. The UI is built with Flutter; the core
(block format, hyphenation, import) is written in Rust and connected through
[flutter_rust_bridge](https://github.com/fzyzcjy/flutter_rust_bridge).

The app is available in Russian and English.

## Layout

- `lib/`, `android/`, `test/` - Flutter app (flavors: `github`, `store`)
- `rust/` - Rust workspace: `flow-core` (core logic) and `bridge` (FFI bridge)

## Build

```
flutter build apk --flavor github --debug
cd rust && cargo test --workspace
```

## License

FlowReader is licensed under the [GNU GPL v3](LICENSE).

## Contributing

External contributors must agree to the [CLA](CLA.md), which allows the
project owner to relicense contributions (including in proprietary builds).
