# Spike 0a: soft hyphens and justified Russian text in Flutter

Setup: Literata 18 (variable TTF, default axes), height 1.4, `TextAlign.justify`, 3-sentence Russian paragraph hyphenated by `flow-core::Hyphenator` (U+00AD at break points). Flutter stable (SDK ^3.12.2), Pixel 7, `store` flavor debug build, live `hyphenate` bridge call.

Evidence (`docs/spikes/0a/`): `golden_280.png`, `golden_360.png` (widget test), `device_justify_280.png`, `device_justify_360.png`, `device_left_280.png` (Pixel 7).

## Answers

1. **Does a line end at a U+00AD position?** Yes. Test `breaks_at_soft_hyphen` (280 px) finds lines whose `getLineBoundary` end is right after a U+00AD. Device shows the same breaks: "об|работки", "позволя|ют", "стра|ницы", "пере|носить", "электроэнцефало|графия", "взаимодей|ствие", "ши|рине".
2. **Is a visible hyphen drawn at the break?** **No**, in both goldens and on the device. The soft hyphen is a zero-width, invisible character and Flutter's (libtxt/Skia and Impeller paragraph) line breaker does not render a hyphen glyph when it breaks there. Wrapped lines look like "стра" / "ницы": unreadable as a hyphenation for a reader.
3. **Justify quality.** Breaking itself works, but quality is mediocre at narrow widths:
   - 280 px: noticeably loose lines: "читались на небольшом" (very wide gaps), "пример «электроэнцефало", "по ши". Mild rivers around the lines 1, 5 and 9 to 11.
   - 360 px: better, mostly even; "пример «электроэнцефалография»" and "по ши" still have wide gaps.
   Part of the looseness is because the missing hyphen is not accounted for in width and because the engine is greedy (first-fit), with no whole-paragraph optimisation (Knuth-Plass).
4. **U+00AD in the middle of lines.** Not rendered: no stray glyphs or gaps in words in any screenshot (goldens and device).
5. **Recommendation: workaround first, own line breaker later if quality demands.** The engine as is is not acceptable (no visible hyphen). Concretely:
   - *Workaround (about 2 to 3 days):* lay out with `TextPainter`, read lines via `computeLineMetrics` + `getLineBoundary`; for each line whose last character is U+00AD, replace that U+00AD by a real `-` (U+2010) and relayout; since adding a hyphen can overflow a line, iterate (re-measure, at worst drop that break point) until stable. Works per page/paragraph, cost is repeated layout of a few paragraphs. Untested here; the soft-hyphen break detection it relies on is proven by this spike.
   - *Own line breaker (about 2 to 3 weeks in plan 2):* Knuth-Plass over word/hyphen-point boxes measured with `TextPainter`/Rust font metrics, own drawing of lines. Needed only if justify looseness at 280 px is judged too poor (that is the real gain: even gaps, penalties for consecutive hyphens, minimum 2-letter fragments).

## Notes
- Hyphenator also produces fragments like "об|работки" and "ши|рине" (2-letter pieces); a minimum left/right fragment rule is advisable.
- Literata variable font is rendered at default axes (no optical-size tuning).
