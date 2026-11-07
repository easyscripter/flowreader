//! Placeholder converter used by open builds and by Flutter-side tests.

use std::time::Duration;

use super::api::{CancelToken, Converter, ImportError, Progress, ReadSeek, SourceKind, Stage};
use crate::model::Book;

/// Number of progress events the stub emits.
const STUB_STEPS: u32 = 3;
/// Pause between events so callers can cancel deterministically mid-run.
const STUB_STEP_PAUSE: Duration = Duration::from_millis(50);

/// Emits three `Pages` progress events, then `Err(Unsupported(kind))`.
/// Cancellation is checked before each event.
pub struct StubConverter;

impl Converter for StubConverter {
    fn convert(
        &self,
        _src: &mut dyn ReadSeek,
        kind: SourceKind,
        progress: &mut dyn FnMut(Progress),
        cancel: &CancelToken,
    ) -> Result<Book, ImportError> {
        for done in 1..=STUB_STEPS {
            if cancel.is_cancelled() {
                return Err(ImportError::Cancelled);
            }
            progress(Progress {
                stage: Stage::Pages,
                done,
                total: STUB_STEPS,
            });
            std::thread::sleep(STUB_STEP_PAUSE);
        }
        if cancel.is_cancelled() {
            return Err(ImportError::Cancelled);
        }
        Err(ImportError::Unsupported(kind))
    }
}
