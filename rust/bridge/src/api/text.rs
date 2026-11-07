use std::sync::OnceLock;

use flow_core::text::Hyphenator;

/// The shared hyphenator, or `None` if the bundled dictionaries failed to load.
fn hyphenator() -> Option<&'static Hyphenator> {
    static H: OnceLock<Option<Hyphenator>> = OnceLock::new();
    H.get_or_init(|| Hyphenator::new().ok()).as_ref()
}

/// Inserts soft hyphens (U+00AD) at allowed break points of ru/en words.
/// Returns the text unchanged if the dictionaries are unavailable.
#[flutter_rust_bridge::frb(sync)]
pub fn hyphenate(text: String) -> String {
    match hyphenator() {
        Some(h) => h.hyphenate(&text),
        None => text,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn inserts_soft_hyphens() {
        let out = hyphenate("Программирование".to_string());
        assert!(out.contains('\u{00AD}'));
    }

    /// Prints the spike paragraph with U+00AD escaped as `­` (run with --nocapture).
    #[test]
    fn print_spike_paragraph() {
        let src = "Современные технологии обработки документов позволяют переформатировать страницы так, чтобы они удобно читались на небольшом экране телефона. Для этого необходимо правильно переносить длинные слова, например «электроэнцефалография» или «взаимодействие». Качественная вёрстка выравнивает текст по ширине без заметных разрывов между словами.";
        println!(
            "SPIKE:{}",
            hyphenate(src.to_string()).replace('\u{00AD}', "\\u00AD")
        );
    }
}
