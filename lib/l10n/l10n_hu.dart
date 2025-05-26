// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class L10nHu extends L10n {
  L10nHu([String locale = 'hu']) : super(locale);

  @override
  String get languageName => 'Magyar';

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

  @override
  String get inputworkout => 'Írd be az edzés nevét...';

  @override
  String get date => 'Időpont';

  @override
  String get duration => 'Időtartam';

  @override
  String get location => 'Helyszín';

  @override
  String get location_l => 'helyszín';

  @override
  String get year => 'év';

  @override
  String get month => 'hó';

  @override
  String get day => 'nap';

  @override
  String get yes_uppercase => 'IGEN';

  @override
  String get no_uppercase => 'NEM';

  @override
  String get deleteTitle => 'Biztosan törölni akarod?';

  @override
  String get cantBeUndone => 'Ez a művelet nem vonható vissza.';

  @override
  String get cantBeUndoneAccount =>
      'A fiókodról van szó. Ha törlöd, minden alkalmazásbeli tevékenységed elveszik a fiókoddal együtt!\nEz a művelet nem vonható vissza.';

  @override
  String get recordnewactivity => 'Új aktivitás rögzítése...';

  @override
  String get dateofworkout => 'Az edzés időpontja';

  @override
  String get durationofworkout => 'Az edzés időtartama';

  @override
  String get locationofworkout => 'Az edzés helyszíne';

  @override
  String get locationinput => 'Helyszín beírása';

  @override
  String get save => 'Mentés';

  @override
  String get editactivity => 'Aktivitás szerkesztése';

  @override
  String get settings => 'Beállítások';

  @override
  String get language => 'Nyelv';

  @override
  String get changetheme => 'Téma módosítása';

  @override
  String get useracc => 'Felhasználói fiók';

  @override
  String get reporterror => 'Hiba bejelentése';

  @override
  String get impressum =>
      'Az alkalmazást Taschner Olivér készítette a\nBME VIAUAV45 tantárgy keretében.\nAz ikonok az icons8.com-ról származnak.';

  @override
  String get helptranslate =>
      'Nem elérhető a nyelveden?\nSegíts a fordításban!';

  @override
  String get theme => 'Téma';

  @override
  String get helptheme =>
      'Szeretnéd más külsőben látni az appot?\nAdj hozzá új témát!';

  @override
  String get failcritique => 'Hiba, kritika';

  @override
  String get foundabugline => 'Hibát találtál?\nMűködhetne valami jobban is?';

  @override
  String get reportbughere => 'Jelentsd be a recout@toliver.hu e-mail címen!';

  @override
  String get youraccount => 'Fiókod';

  @override
  String get editdatas => 'Adatok módosítása';

  @override
  String get deleteacc => 'Fiók törlése';

  @override
  String get modify => 'Módosítás';

  @override
  String get allright => 'Így már rendben van!';

  @override
  String get username_s => '[felhasználónév]';

  @override
  String get name_s => '[vezetéknév][keresztnév]';

  @override
  String get dateofbirth_s => '[születési idő]';

  @override
  String get email_s => '[e-mail cím]';

  @override
  String get emailAlreadyInUse => 'Ez az email cím már használatban van.';

  @override
  String get invalidEmail => 'Hibás e-mail formátum.';

  @override
  String get weakPassword =>
      'A jelszavad olyan, mintha tárva nyitva hagynád a bejárati ajtódat!';

  @override
  String get unknownError => 'Ismeretlen hiba';

  @override
  String get successfulRegister => 'Sikeres regisztráció!';

  @override
  String get userNotFound => 'A felhasználónév nem létezik!';

  @override
  String get invalidEmailLogin =>
      'A felhasználónévhez tartozó email nem érvényes.';

  @override
  String get wrongPassword => 'Hibás jelszó!';

  @override
  String get errorOccurred => 'Hiba történt';

  @override
  String get logout => 'Kijelentkezés';

  @override
  String get noListElement =>
      'Még üres a listád.\\nPróbálj felvenni egy edzést itt feljebb!';

  @override
  String get deleteError => 'Hiba történt a fiók törlésekor';

  @override
  String get sucessfullDelete => 'Sikeresen törölve!';

  @override
  String get light => 'Világos';

  @override
  String get dark => 'Sötét';

  @override
  String get noad => 'Nincs hirdetés, helyette itt egy kutyás kép';

  @override
  String get workoutNotFound => 'Edzés nem található!';
}
