import 'dart:ui';

/// WCAG-контраст двух цветов: `(L1 + 0.05) / (L2 + 0.05)`, L1 ≥ L2.
double contrastRatio(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final hi = la > lb ? la : lb;
  final lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}
