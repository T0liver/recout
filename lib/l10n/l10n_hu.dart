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
}
