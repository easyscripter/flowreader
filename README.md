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

## License and third-party notices

FlowReader is licensed under the [GPL-3.0-only](LICENSE). Contributions are
subject to the [CLA](CLA.md).

Third-party components:

- **Literata** font (`assets/fonts/literata/`): SIL Open Font License 1.1,
  see `assets/fonts/literata/OFL.txt`.
- **Hyphenation dictionaries** (`rust/flow-core/dictionaries/`, see `NOTICE.md`
  there):
  - en-us: (C) Gerard D.C. Kuiken; copying and distribution permitted in any
    medium without royalty provided the copyright notice and permission notice
    are preserved.
  - ru: (C) 1999-2003 Alexander I. Lebedev; LaTeX Project Public License 1.2 or
    later. The licensing of the Russian hyphenation patterns in this GPL-3.0
    project is under review (see `docs/spikes/stage0-report.md`, R10).
- **cargokit** (`rust_builder/`): MIT / Apache-2.0.
- **flutter_rust_bridge**: MIT / Apache-2.0.

The PDF converter used in release builds is proprietary and is not part of this
repository. Open builds read EPUB/FB2 only (once implemented).

## Contributing

External contributors must agree to the [CLA](CLA.md), which allows the
project owner to relicense contributions (including in proprietary builds).
