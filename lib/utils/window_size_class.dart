/// Классы окна по ширине в dp (сетка из дизайна).
enum WindowSizeClass { compact, medium, expanded }

/// Нижняя граница класса `medium`, dp.
const double mediumMinWidth = 600;

/// Нижняя граница класса `expanded`, dp.
const double expandedMinWidth = 840;

/// compact < 600 ≤ medium < 840 ≤ expanded. Не конечная или отрицательная
/// ширина → `compact`.
WindowSizeClass windowSizeClassOf(double width) {
  if (!width.isFinite || width < mediumMinWidth) return WindowSizeClass.compact;
  if (width < expandedMinWidth) return WindowSizeClass.medium;
  return WindowSizeClass.expanded;
}
