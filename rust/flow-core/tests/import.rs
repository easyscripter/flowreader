use flow_core::import::{
    CancelToken, Converter, ImportError, Progress, SourceKind, Stage, StubConverter,
};
use std::io::Cursor;

#[test]
fn stub_reports_progress_then_unsupported() {
    let mut src = Cursor::new(Vec::<u8>::new());
    let mut events = Vec::new();
    let r = StubConverter.convert(
        &mut src,
        SourceKind::Pdf,
        &mut |p| events.push(p),
        &CancelToken::new(),
    );
    assert_eq!(
        events,
        (1..=3)
            .map(|d| Progress {
                stage: Stage::Pages,
                done: d,
                total: 3
            })
            .collect::<Vec<_>>()
    );
    assert!(matches!(r, Err(ImportError::Unsupported(SourceKind::Pdf))));
}

#[test]
fn cancel_stops_events() {
    let mut src = Cursor::new(Vec::<u8>::new());
    let token = CancelToken::new();
    let t2 = token.clone();
    let mut events = Vec::new();
    let r = StubConverter.convert(
        &mut src,
        SourceKind::Epub,
        &mut |p| {
            events.push(p);
            t2.cancel();
        },
        &token,
    );
    assert_eq!(events.len(), 1);
    assert!(matches!(r, Err(ImportError::Cancelled)));
    assert!(token.is_cancelled());
}
