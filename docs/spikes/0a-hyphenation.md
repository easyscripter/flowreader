# Spike 0a: soft hyphens and justified Russian text in Flutter

Setup: Literata 18 (variable TTF, default axes), height 1.4, `TextAlign.justify`, 3-sentence Russian paragraph hyphenated by `flow-core::Hyphenator` (U+00AD at break points). Flutter stable (SDK ^3.12.2), Pixel 7, `store` flavor debug build, live `hyphenate` bridge call.

Evidence (`docs/spikes/0a/`): `golden_280.png`, `golden_360.png` (widget test), `device_justify_280.png`, `device_justify_360.png`, `device_left_280.png` (Pixel 7).

## Answers

1. **Does a line end at a U+00AD position?** Yes. Test `breaks_at_soft_hyphen` (280 px) finds lines whose `getLineBoundary` end is right after a U+00AD. Device shows the same breaks: "об|работки", "позволя|ют", "стра|ницы", "пере|носить", "электроэнцефало|графия", "взаимодей|ствие", "ши|рине".
2. **Is a visible hyphen drawn at the break?** **No**, in both goldens and on the device. The soft hyphen is a zero-width, invisible character and Flutter's line breaker did not draw a hyphen glyph when it broke there. Observed on one device only (Pixel 7, Android 17, whatever renderer that debug build used; not checked on other devices or renderers) and in the host `flutter test` goldens. Wrapped lines look like "стра" / "ницы": unreadable as a hyphenation for a reader.
3. **Justify quality.** Breaking itself works, but quality is mediocre at narrow widths:
   - 280 px: noticeably loose lines: "читались на небольшом" (very wide gaps), "пример «электроэнцефало", "по ши". Mild rivers around the lines 1, 5 and 9 to 11.
   - 360 px: better, mostly even; "пример «электроэнцефалография»" and "по ши" still have wide gaps.
   Hypothesis (not tested): the looseness comes from the engine being greedy (first-fit) with no whole-paragraph optimisation, so a few lines get few break options at this width.
4. **U+00AD in the middle of lines.** Not rendered: no stray glyphs or gaps in words in any screenshot (goldens and device).
5. **Recommendation: our own line breaker that uses Flutter only to measure.**
   - *"Flutter engine as is" is rejected:* no hyphen glyph was drawn at U+00AD breaks, on the device and in goldens, so hyphenated text would read as split words.
   - *Rejected workaround:* substituting a real `-` for the trailing U+00AD and re-laying out through the engine is unsound. The hyphen widens the line, so the break moves, later lines reflow, earlier substituted hyphens can land mid-line, U+2010 is itself a break opportunity, there is no convergence argument, and text offsets shift.
   - *Approach:* split the paragraph into break candidates (spaces and U+00AD positions). Measure candidate line widths with `TextPainter`/`Paragraph` (for a U+00AD break, measure the fragment plus `-`). Choose breaks explicitly: greedy first, Knuth-Plass-style total-fit later on the same infrastructure (also allows a minimum 2-letter fragment rule and limits on consecutive hyphens). Render each line ourselves (one paragraph per line, or a line with an explicit hyphen glyph) and justify by distributing the extra space between words ourselves. No feedback loop with the engine, so it is deterministic. Text offsets map 1:1 to the source, because the drawn `-` is a render-only glyph and is not inserted into the text model.
   - *Costs:* inline styles that span lines, measuring runs with mixed styles, and caching measurements.
   - *Effort (rough):* greedy breaker + justify about 1 week; total-fit upgrade about +1 week. Pagination (plan 2) already needs per-line layout, so this aligns with planned work.

## Notes
- Hyphenator also produces fragments like "об|работки" and "ши|рине" (2-letter pieces); a minimum left/right fragment rule is advisable.
- Literata variable font is rendered at default axes (no optical-size tuning).
