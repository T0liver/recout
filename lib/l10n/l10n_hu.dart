// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class L10nHu extends L10n {
  L10nHu([String locale = 'hu']) : super(locale);

  @override
  String get firstGreet => 'Üdvözöllek!\nSzia!';

  @override
  String get setLanguage => 'Nyelv beállítása';

  @override
  String get login => 'Bejelentkezés';

  @override
  String get register => 'Regisztráció';

  @override
  String get username => 'Felhasználónév';

  @override
  String get password => 'Jelszó';

  @override
  String get letsgo => 'Indulás';

  @override
  String get emailaddr => 'E-mail cím';

  @override
  String get goalright => 'Mehet a menet!';

  @override
  String get hello => 'Szia';

  @override
  String get homemsg => 'Mit edzettél mostanában?';

  @override
  String get recworkout => 'Edzés rögzítése';

  @override
  String get explworkout => 'pl. mario cart';

  @override
  String get prevworkouts => 'Korábbi edzéseid';

  @override
  String get hour => 'óra';

  @override
  String get minute => 'perc';

  @override
  String get noads => 'Nincs hirdetés, helyette itt egy kutyás kép';
}
