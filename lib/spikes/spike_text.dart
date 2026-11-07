import 'package:flutter/painting.dart';

/// Font family used by the spike paragraph.
const kSpikeFontFamily = 'Literata';

/// Spike paragraph style: Literata 18.
const kSpikeTextStyle = TextStyle(
  fontFamily: kSpikeFontFamily,
  fontSize: 18,
  height: 1.4,
  color: Color(0xFF000000),
);

/// Source paragraph (no soft hyphens); the device screen hyphenates it live
/// through the Rust bridge.
const kSpikeSource =
    'Современные технологии обработки документов позволяют переформатировать страницы так, чтобы они удобно читались на небольшом экране телефона. Для этого необходимо правильно переносить длинные слова, например «электроэнцефалография» или «взаимодействие». Качественная вёрстка выравнивает текст по ширине без заметных разрывов между словами.';

/// [kSpikeSource] after `Hyphenator::hyphenate` (flow-core), generated once with
/// `cargo test -p rust_lib_flowreader print_spike -- --nocapture`. Contains
/// U+00AD (written as \u00AD) at the Russian break points.
/// Regenerated with (from `rust/`): `cargo test -p rust_lib_flowreader
/// print_spike -- --nocapture`; take the `SPIKE:` output line (U+00AD printed as
/// a backslash-u00AD escape) and paste it below.
const kSpikeHyphenated =
    'Со\u00ADвре\u00ADмен\u00ADные тех\u00ADно\u00ADло\u00ADгии об\u00ADра\u00ADбот\u00ADки до\u00ADку\u00ADмен\u00ADтов поз\u00ADво\u00ADля\u00ADют пе\u00ADре\u00ADфор\u00ADма\u00ADти\u00ADро\u00ADвать стра\u00ADни\u00ADцы так, что\u00ADбы они удоб\u00ADно чи\u00ADта\u00ADлись на неболь\u00ADшом экране те\u00ADле\u00ADфо\u00ADна. Для это\u00ADго необ\u00ADхо\u00ADди\u00ADмо пра\u00ADвиль\u00ADно пе\u00ADре\u00ADно\u00ADсить длин\u00ADные сло\u00ADва, на\u00ADпри\u00ADмер «элек\u00ADтро\u00ADэн\u00ADце\u00ADфа\u00ADло\u00ADгра\u00ADфия» или «вза\u00ADи\u00ADмо\u00ADдей\u00ADствие». Ка\u00ADче\u00ADствен\u00ADная вёрст\u00ADка вы\u00ADрав\u00ADни\u00ADва\u00ADет текст по ши\u00ADрине без за\u00ADмет\u00ADных раз\u00ADры\u00ADвов меж\u00ADду сло\u00ADва\u00ADми.';
