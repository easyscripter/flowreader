use flow_core::text::Hyphenator;

const SHY: char = '\u{AD}';

fn letters_before_after(word: &str) -> Vec<(usize, usize)> {
    let total = word.chars().filter(|&c| c != SHY).count();
    let mut seen = 0;
    let mut out = Vec::new();
    for c in word.chars() {
        if c == SHY {
            out.push((seen, total - seen));
        } else {
            seen += 1;
        }
    }
    out
}

#[test]
fn inserts_soft_hyphens() {
    let h = Hyphenator::new().unwrap();
    let src = "программирование";
    let out = h.hyphenate(src);
    assert!(out.contains(SHY), "{out:?}");
    assert_eq!(out.replace(SHY, ""), src);
    for (l, r) in letters_before_after(&out) {
        assert!(l >= 2 && r >= 2);
    }
}

#[test]
fn keeps_short_and_hyphenated_words() {
    let h = Hyphenator::new().unwrap();
    for w in ["кот", "кое-что", "ООН", "API"] {
        assert_eq!(h.hyphenate(w), w);
    }
    let long = h.hyphenate("программирование");
    for (l, r) in letters_before_after(&long) {
        assert!(l >= 2 && r >= 2);
    }
}

/// Only the hyphen-joiner rule protects these (all are >= 5 letters per part).
#[test]
fn keeps_long_hyphenated_words() {
    let h = Hyphenator::new().unwrap();
    for w in [
        "научно-исследовательский",
        "северо-западный",
        "state-of-the-art-technology",
    ] {
        assert_eq!(h.hyphenate(w), w);
    }
}

/// Only the all-caps rule protects these.
#[test]
fn keeps_long_all_caps_words() {
    let h = Hyphenator::new().unwrap();
    for w in ["ПРОГРАММИРОВАНИЕ", "HYPHENATION"] {
        assert_eq!(h.hyphenate(w), w);
    }
}

#[test]
fn mixed_text() {
    let h = Hyphenator::new().unwrap();
    let src = "Метод hyphenation работает";
    let out = h.hyphenate(src);
    assert_eq!(out.replace(SHY, ""), src);
    let words: Vec<&str> = out.split(' ').collect();
    assert_eq!(words.len(), 3);
    assert!(words[0].contains(SHY), "{out:?}");
    assert!(words[1].contains(SHY), "{out:?}");
    assert!(words[2].contains(SHY), "{out:?}");
    let p = h.hyphenate("Программирование, hyphenation!");
    assert!(p.ends_with('!') && p.contains(", "));
    assert_eq!(p.replace(SHY, ""), "Программирование, hyphenation!");
}

#[test]
fn idempotent() {
    let h = Hyphenator::new().unwrap();
    let once = h.hyphenate("Программирование и hyphenation, кое-что ООН");
    assert_eq!(h.hyphenate(&once), once);
}

#[test]
fn leaves_words_with_existing_soft_hyphens() {
    let h = Hyphenator::new().unwrap();
    let src = "программи\u{AD}рование";
    assert_eq!(h.hyphenate(src), src);
}

#[test]
fn margins_hold_for_long_ru_and_en_words() {
    let h = Hyphenator::new().unwrap();
    for w in ["программирование", "interoperability", "international"] {
        let out = h.hyphenate(w);
        assert!(out.contains(SHY), "{out:?}");
        assert_eq!(out.replace(SHY, ""), w);
        for (l, r) in letters_before_after(&out) {
            assert!(l >= 2 && r >= 2, "{out:?}");
        }
    }
}

#[test]
fn uppercase_initial_word_is_hyphenated() {
    let h = Hyphenator::new().unwrap();
    let out = h.hyphenate("Программирование");
    assert!(out.contains(SHY), "{out:?}");
    assert_eq!(out.replace(SHY, ""), "Программирование");
    let out = h.hyphenate("Interoperability");
    assert!(out.contains(SHY), "{out:?}");
}
