import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_hu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hu')
  ];

  /// A nyelv neve, amire a fordítás történik, első betű nagybetű
  ///
  /// In hu, this message translates to:
  /// **'Magyar'**
  String get languageName;

  /// Első üdvözlési szöveg
  ///
  /// In hu, this message translates to:
  /// **'Üdvözöllek!\nSzia!'**
  String get firstGreet;

  /// Szöveg a nyelv beállísásának kiválasztására.
  ///
  /// In hu, this message translates to:
  /// **'Nyelv beállítása'**
  String get setLanguage;

  /// Bejelentkezés szövege
  ///
  /// In hu, this message translates to:
  /// **'Bejelentkezés'**
  String get login;

  /// Regisztráció szövege.
  ///
  /// In hu, this message translates to:
  /// **'Regisztráció'**
  String get register;

  /// Felhasználónév szöveg helyekre
  ///
  /// In hu, this message translates to:
  /// **'Felhasználónév'**
  String get username;

  /// Jelszó szöveg helyekre
  ///
  /// In hu, this message translates to:
  /// **'Jelszó'**
  String get password;

  /// Vidám üzenet, O.K.
  ///
  /// In hu, this message translates to:
  /// **'Indulás'**
  String get letsgo;

  /// E-mail cím szövege
  ///
  /// In hu, this message translates to:
  /// **'E-mail cím'**
  String get emailaddr;

  /// Vidám üzenet, O.K.
  ///
  /// In hu, this message translates to:
  /// **'Mehet a menet!'**
  String get goalright;

  /// Egyszerű üdvözlés
  ///
  /// In hu, this message translates to:
  /// **'Szia'**
  String get hello;

  /// Fejléc üzenet, ami új edzés felvételére bátorít
  ///
  /// In hu, this message translates to:
  /// **'Mit edzettél mostanában?'**
  String get homemsg;

  /// Edzés rögzítése gomb felirat
  ///
  /// In hu, this message translates to:
  /// **'Edzés rögzítése'**
  String get recworkout;

  /// Vicces példa szöveg
  ///
  /// In hu, this message translates to:
  /// **'pl. mario cart'**
  String get explworkout;

  /// Korábbi edzések szövege
  ///
  /// In hu, this message translates to:
  /// **'Korábbi edzéseid'**
  String get prevworkouts;

  /// óra szöveg kisbetűvel
  ///
  /// In hu, this message translates to:
  /// **'óra'**
  String get hour;

  /// perc szöveg kisbetűvel
  ///
  /// In hu, this message translates to:
  /// **'perc'**
  String get minute;

  /// No description provided for @noads.
  ///
  /// In hu, this message translates to:
  /// **'Nincs hirdetés, helyette itt egy kutyás kép'**
  String get noads;

  /// A főképernyőn lévő kis kártyának a tipp felirata
  ///
  /// In hu, this message translates to:
  /// **'Írd be az edzés nevét...'**
  String get inputworkout;

  /// Időpont szöveg
  ///
  /// In hu, this message translates to:
  /// **'Időpont'**
  String get date;

  /// Időtartam szöveg
  ///
  /// In hu, this message translates to:
  /// **'Időtartam'**
  String get duration;

  /// Helyszín szöveg
  ///
  /// In hu, this message translates to:
  /// **'Helyszín'**
  String get location;

  /// helyszín szöveg kisbetűsen
  ///
  /// In hu, this message translates to:
  /// **'helyszín'**
  String get location_l;

  /// év szöveg kisbetűsen
  ///
  /// In hu, this message translates to:
  /// **'év'**
  String get year;

  /// hó  szöveg kisbetűsen
  ///
  /// In hu, this message translates to:
  /// **'hó'**
  String get month;

  /// nap szöveg kisbetűsen
  ///
  /// In hu, this message translates to:
  /// **'nap'**
  String get day;

  /// igen csupa nagybetűkkel
  ///
  /// In hu, this message translates to:
  /// **'IGEN'**
  String get yes_uppercase;

  /// nem csupa nagybetűkkel
  ///
  /// In hu, this message translates to:
  /// **'NEM'**
  String get no_uppercase;

  /// Törlés megerősítése dialógus cím
  ///
  /// In hu, this message translates to:
  /// **'Biztosan törölni akarod?'**
  String get deleteTitle;

  /// Figyelmeztetés a törlés műveletről.
  ///
  /// In hu, this message translates to:
  /// **'Ez a művelet nem vonható vissza.'**
  String get cantBeUndone;

  /// Figyelmeztetés a fiók törlés műveletének visszavonhatatlanságáról.
  ///
  /// In hu, this message translates to:
  /// **'A fiókodról van szó. Ha törlöd, minden alkalmazásbeli tevékenységed elveszik a fiókoddal együtt!\nEz a művelet nem vonható vissza.'**
  String get cantBeUndoneAccount;

  /// Új aktivitás rögzítésének szövege.
  ///
  /// In hu, this message translates to:
  /// **'Új aktivitás rögzítése...'**
  String get recordnewactivity;

  /// Edzés időpontja szöveg
  ///
  /// In hu, this message translates to:
  /// **'Az edzés időpontja'**
  String get dateofworkout;

  /// Edzés időtartama szöveg
  ///
  /// In hu, this message translates to:
  /// **'Az edzés időtartama'**
  String get durationofworkout;

  /// Edzés helyszíne szöveg
  ///
  /// In hu, this message translates to:
  /// **'Az edzés helyszíne'**
  String get locationofworkout;

  /// Helyszín beírása beviteli mező
  ///
  /// In hu, this message translates to:
  /// **'Helyszín beírása'**
  String get locationinput;

  /// Mentés szöveg nagybetűvel
  ///
  /// In hu, this message translates to:
  /// **'Mentés'**
  String get save;

  /// Aktivitás szerkesztése szöveg
  ///
  /// In hu, this message translates to:
  /// **'Aktivitás szerkesztése'**
  String get editactivity;

  /// Beállítások szöveg
  ///
  /// In hu, this message translates to:
  /// **'Beállítások'**
  String get settings;

  /// Nyelv szöveg
  ///
  /// In hu, this message translates to:
  /// **'Nyelv'**
  String get language;

  /// Téma módosítása szöveg
  ///
  /// In hu, this message translates to:
  /// **'Téma módosítása'**
  String get changetheme;

  /// Felhasználói fiók szöveg
  ///
  /// In hu, this message translates to:
  /// **'Felhasználói fiók'**
  String get useracc;

  /// Hiba bejelentése szöveg
  ///
  /// In hu, this message translates to:
  /// **'Hiba bejelentése'**
  String get reporterror;

  /// Impresszum szövege, ikonok forrása szöveg beállítások alján.
  ///
  /// In hu, this message translates to:
  /// **'Az alkalmazást Taschner Olivér készítette a\nBME VIAUAV45 tantárgy keretében.\nAz ikonok az icons8.com-ról származnak.'**
  String get impressum;

  /// Közreműködés a fordításban szöveg.
  ///
  /// In hu, this message translates to:
  /// **'Nem elérhető a nyelveden?\nSegíts a fordításban!'**
  String get helptranslate;

  /// Téma szöveg
  ///
  /// In hu, this message translates to:
  /// **'Téma'**
  String get theme;

  /// Közreműködés a témákban szöveg.
  ///
  /// In hu, this message translates to:
  /// **'Szeretnéd más külsőben látni az appot?\nAdj hozzá új témát!'**
  String get helptheme;

  /// Hiba, kritika oldal címe.
  ///
  /// In hu, this message translates to:
  /// **'Hiba, kritika'**
  String get failcritique;

  /// Hibát találtás felhívó szöveg.
  ///
  /// In hu, this message translates to:
  /// **'Hibát találtál?\nMűködhetne valami jobban is?'**
  String get foundabugline;

  /// Bejelentés menete szöveg.
  ///
  /// In hu, this message translates to:
  /// **'Jelentsd be a recout@toliver.hu e-mail címen!'**
  String get reportbughere;

  /// A te fiókod szöveg.
  ///
  /// In hu, this message translates to:
  /// **'Fiókod'**
  String get youraccount;

  /// Adatok módosítása gomb szövege.
  ///
  /// In hu, this message translates to:
  /// **'Adatok módosítása'**
  String get editdatas;

  /// Fiók törlése gomb szövege.
  ///
  /// In hu, this message translates to:
  /// **'Fiók törlése'**
  String get deleteacc;

  /// Módosítá szöveg.
  ///
  /// In hu, this message translates to:
  /// **'Módosítás'**
  String get modify;

  /// O.K., vicces szöveg.
  ///
  /// In hu, this message translates to:
  /// **'Így már rendben van!'**
  String get allright;

  /// Felhasználónév szögeltes zárójelek között
  ///
  /// In hu, this message translates to:
  /// **'[felhasználónév]'**
  String get username_s;

  /// Név szögeltes zárójelek között
  ///
  /// In hu, this message translates to:
  /// **'[vezetéknév][keresztnév]'**
  String get name_s;

  /// Születési idő szögeltes zárójelek között
  ///
  /// In hu, this message translates to:
  /// **'[születési idő]'**
  String get dateofbirth_s;

  /// E-mail cím szögeltes zárójelek között
  ///
  /// In hu, this message translates to:
  /// **'[e-mail cím]'**
  String get email_s;

  /// Hiba üzenet, ha regisztrációkor az email címet már más regisztrálta.
  ///
  /// In hu, this message translates to:
  /// **'Ez az email cím már használatban van.'**
  String get emailAlreadyInUse;

  /// Hiba üzenet, ha regisztrációkor az e-mail cím nem megfelelő formátumu.
  ///
  /// In hu, this message translates to:
  /// **'Hibás e-mail formátum.'**
  String get invalidEmail;

  /// Hiba üzenet, ha regisztrációkor a jelszó túl gyenge.
  ///
  /// In hu, this message translates to:
  /// **'A jelszavad olyan, mintha tárva nyitva hagynád a bejárati ajtódat!'**
  String get weakPassword;

  /// Olyan hiba, ami egy nem taglalt esetben történik meg.
  ///
  /// In hu, this message translates to:
  /// **'Ismeretlen hiba'**
  String get unknownError;

  /// Ha sikerült a regisztráció.
  ///
  /// In hu, this message translates to:
  /// **'Sikeres regisztráció!'**
  String get successfulRegister;

  /// Hiba, ha bejelentkezésnél nem létező felhasználónévvel próbálkoznak.
  ///
  /// In hu, this message translates to:
  /// **'A felhasználónév nem létezik!'**
  String get userNotFound;

  /// Hiba, ha bejelentkezéskor a felhasználónévhez tartozó email nem érvényes.
  ///
  /// In hu, this message translates to:
  /// **'A felhasználónévhez tartozó email nem érvényes.'**
  String get invalidEmailLogin;

  /// Hiba, ha bejelentkezéskor hibás jelszóval próbálkoznak.
  ///
  /// In hu, this message translates to:
  /// **'Hibás jelszó!'**
  String get wrongPassword;

  /// Egy hiba állt be.
  ///
  /// In hu, this message translates to:
  /// **'Hiba történt'**
  String get errorOccurred;

  /// A kijelentkezés szövege.
  ///
  /// In hu, this message translates to:
  /// **'Kijelentkezés'**
  String get logout;

  /// Visszajelzés a listánál, hogyha a felhasználó még nem vett fel edzést.
  ///
  /// In hu, this message translates to:
  /// **'Még üres a listád.\\nPróbálj felvenni egy edzést itt feljebb!'**
  String get noListElement;

  /// Üzenet, ha hiba történt a fiók törlése folyamán.
  ///
  /// In hu, this message translates to:
  /// **'Hiba történt a fiók törlésekor'**
  String get deleteError;

  /// Visszajelzés a sikeres törlésről.
  ///
  /// In hu, this message translates to:
  /// **'Sikeresen törölve!'**
  String get sucessfullDelete;

  /// Világos téma.
  ///
  /// In hu, this message translates to:
  /// **'Világos'**
  String get light;

  /// Sötét téma.
  ///
  /// In hu, this message translates to:
  /// **'Sötét'**
  String get dark;

  /// The funny text for the false advertisement.
  ///
  /// In hu, this message translates to:
  /// **'Nincs hirdetés, helyette itt egy kutyás kép'**
  String get noad;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hu'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return L10nEn();
    case 'hu': return L10nHu();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
