//! Soft hyphenation (U+00AD) for Russian and English text.
//!
//! Words are maximal runs of alphabetic characters. Words attached to a
//! hyphen, shorter than [`MIN_WORD_LETTERS`] letters, fully uppercase, written
//! in mixed scripts or already containing a soft hyphen are left untouched.

use hyphenation::{Hyphenator as _, Language, Load, Standard};

const SHY: char = '\u{AD}';
const MIN_WORD_LETTERS: usize = 5;
const MIN_BEFORE: usize = 2;
const MIN_AFTER: usize = 2;

/// Inserts soft hyphens into Russian (Cyrillic) and English (Latin) words.
pub struct Hyphenator {
    ru: Standard,
    en: Standard,
}

impl Default for Hyphenator {
    fn default() -> Self {
        Self::new()
    }
}

#[derive(Clone, Copy, PartialEq)]
enum Script {
    Cyrillic,
    Latin,
}

fn script_of(c: char) -> Option<Script> {
    match c {
        '\u{0400}'..='\u{052F}' | '\u{1C80}'..='\u{1C8F}' | '\u{2DE0}'..='\u{2DFF}'
        | '\u{A640}'..='\u{A69F}' => Some(Script::Cyrillic),
        'A'..='Z' | 'a'..='z' => Some(Script::Latin),
        _ => None,
    }
}

fn is_joiner(c: char) -> bool {
    c == '-' || c == '\u{2010}' || c == SHY
}

impl Hyphenator {
    /// Loads the embedded `ru` and `en-us` dictionaries.
    pub fn new() -> Self {
        Hyphenator {
            ru: Standard::from_embedded(Language::Russian).expect("embedded ru dictionary"),
            en: Standard::from_embedded(Language::EnglishUS).expect("embedded en-us dictionary"),
        }
    }

    /// Returns `text` with U+00AD inserted at permitted break points.
    pub fn hyphenate(&self, text: &str) -> String {
        let mut out = String::with_capacity(text.len() + text.len() / 4);
        let mut prev: Option<char> = None;
        let mut iter = text.char_indices().peekable();
        while let Some(&(start, c)) = iter.peek() {
            if !c.is_alphabetic() {
                out.push(c);
                prev = Some(c);
                iter.next();
                continue;
            }
            let mut end = start;
            while let Some(&(i, ch)) = iter.peek() {
                if ch.is_alphabetic() {
                    end = i + ch.len_utf8();
                    iter.next();
                } else {
                    break;
                }
            }
            let word = &text[start..end];
            let next = text[end..].chars().next();
            let attached = prev.is_some_and(is_joiner) || next.is_some_and(is_joiner);
            if attached {
                out.push_str(word);
            } else {
                self.hyphenate_word(word, &mut out);
            }
            prev = word.chars().last();
        }
        out
    }

    fn hyphenate_word(&self, word: &str, out: &mut String) {
        let letters = word.chars().count();
        if letters < MIN_WORD_LETTERS || letters < MIN_BEFORE + MIN_AFTER {
            out.push_str(word);
            return;
        }
        let mut script = None;
        for c in word.chars() {
            match (script, script_of(c)) {
                (_, None) => return out.push_str(word),
                (None, s) => script = s,
                (Some(a), Some(b)) if a != b => return out.push_str(word),
                _ => {}
            }
        }
        if word.chars().all(char::is_uppercase) {
            return out.push_str(word);
        }
        let dict = match script {
            Some(Script::Cyrillic) => &self.ru,
            _ => &self.en,
        };
        let lower = word.to_lowercase();
        if lower.chars().count() != letters {
            return out.push_str(word);
        }
        let breaks = dict.hyphenate(&lower).breaks;
        if breaks.is_empty() {
            return out.push_str(word);
        }
        let mut last = 0;
        for b in breaks {
            if !word.is_char_boundary(b) || lower.len() != word.len() {
                continue;
            }
            let before = word[..b].chars().count();
            if before < MIN_BEFORE || letters - before < MIN_AFTER {
                continue;
            }
            out.push_str(&word[last..b]);
            out.push(SHY);
            last = b;
        }
        out.push_str(&word[last..]);
    }
}
