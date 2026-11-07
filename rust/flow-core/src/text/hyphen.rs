//! Soft hyphenation (U+00AD) for Russian and English text.
//!
//! Words are maximal runs of alphabetic characters. Words attached to a
//! hyphen, shorter than [`MIN_WORD_LETTERS`] letters, fully uppercase, written
//! in mixed scripts or already containing a soft hyphen are left untouched.

use std::io::Cursor;

use hyphenation::{Hyphenator as _, Language, Load, Standard};

static RU_DICT: &[u8] = include_bytes!("../../dictionaries/ru.standard.bincode");
static EN_US_DICT: &[u8] = include_bytes!("../../dictionaries/en-us.standard.bincode");

/// Soft hyphen.
const SHY: char = '\u{AD}';
/// Words shorter than this are never hyphenated.
pub const MIN_WORD_LETTERS: usize = 5;
/// Minimum letters before the first break.
const MIN_BEFORE: usize = 2;
/// Minimum letters after the last break.
const MIN_AFTER: usize = 2;

/// Why the hyphenator could not be created.
#[derive(Debug, Clone, PartialEq, Eq, thiserror::Error)]
pub enum HyphenError {
    /// A bundled dictionary could not be parsed.
    #[error("cannot load {lang} hyphenation dictionary: {reason}")]
    Dictionary {
        /// Language code of the dictionary.
        lang: &'static str,
        /// Parser error.
        reason: String,
    },
}

/// Inserts soft hyphens into Russian (Cyrillic) and English (Latin) words.
pub struct Hyphenator {
    ru: Standard,
    en: Standard,
}

#[derive(Clone, Copy, PartialEq)]
enum Script {
    Cyrillic,
    Latin,
}

fn script_of(c: char) -> Option<Script> {
    match c {
        '\u{0400}'..='\u{052F}'
        | '\u{1C80}'..='\u{1C8F}'
        | '\u{2DE0}'..='\u{2DFF}'
        | '\u{A640}'..='\u{A69F}' => Some(Script::Cyrillic),
        'A'..='Z' | 'a'..='z' => Some(Script::Latin),
        _ => None,
    }
}

fn load(lang: Language, code: &'static str, bytes: &'static [u8]) -> Result<Standard, HyphenError> {
    Standard::from_reader(lang, &mut Cursor::new(bytes)).map_err(|e| HyphenError::Dictionary {
        lang: code,
        reason: e.to_string(),
    })
}

fn is_joiner(c: char) -> bool {
    c == '-' || c == '\u{2010}' || c == SHY
}

impl Hyphenator {
    /// Loads the bundled `ru` and `en-us` dictionaries.
    ///
    /// This parses the dictionaries, so it is relatively expensive: create
    /// one `Hyphenator` and reuse it.
    ///
    /// # Errors
    /// Returns [`HyphenError::Dictionary`] if a bundled dictionary is damaged.
    pub fn new() -> Result<Self, HyphenError> {
        Ok(Hyphenator {
            ru: load(Language::Russian, "ru", RU_DICT)?,
            en: load(Language::EnglishUS, "en-us", EN_US_DICT)?,
        })
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
                if !ch.is_alphabetic() {
                    break;
                }
                end = i + ch.len_utf8();
                iter.next();
            }
            // `start..end` come from `char_indices`, so the slice is always valid.
            let Some(word) = text.get(start..end) else {
                continue;
            };
            let next = text.get(end..).and_then(|rest| rest.chars().next());
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
        if letters < MIN_WORD_LETTERS {
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
        // Break offsets are byte positions in `lower`; they only map onto `word`
        // when lowercasing kept every character's byte length.
        if lower.len() != word.len() || lower.chars().count() != letters {
            return out.push_str(word);
        }
        let mut last = 0;
        for b in dict.hyphenate(&lower).breaks {
            let (Some(head), Some(piece)) = (word.get(..b), word.get(last..b)) else {
                continue;
            };
            let before = head.chars().count();
            if before < MIN_BEFORE || letters.saturating_sub(before) < MIN_AFTER {
                continue;
            }
            out.push_str(piece);
            out.push(SHY);
            last = b;
        }
        out.push_str(word.get(last..).unwrap_or_default());
    }
}
