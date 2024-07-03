import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @homepage.
  ///
  /// In en, this message translates to:
  /// **'HomePage'**
  String get homepage;

  /// No description provided for @srcPage.
  ///
  /// In en, this message translates to:
  /// **'Search Results Page'**
  String get srcPage;

  /// No description provided for @bookPage.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment Page'**
  String get bookPage;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @forProviders.
  ///
  /// In en, this message translates to:
  /// **'For Service Providers'**
  String get forProviders;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @slogan.
  ///
  /// In en, this message translates to:
  /// **'Clinic, Lab, Radiology & Pharmacy.'**
  String get slogan;

  /// No description provided for @subSlogan.
  ///
  /// In en, this message translates to:
  /// **'Book Online Or Call Us'**
  String get subSlogan;

  /// No description provided for @hotline.
  ///
  /// In en, this message translates to:
  /// **'18888'**
  String get hotline;

  /// No description provided for @clinic.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get clinic;

  /// No description provided for @lab.
  ///
  /// In en, this message translates to:
  /// **'Request Lab'**
  String get lab;

  /// No description provided for @rad.
  ///
  /// In en, this message translates to:
  /// **'Book Radiology'**
  String get rad;

  /// No description provided for @pharma.
  ///
  /// In en, this message translates to:
  /// **'Request Drugs'**
  String get pharma;

  /// No description provided for @selectSpecValidator.
  ///
  /// In en, this message translates to:
  /// **'Kindly Select Speciality.'**
  String get selectSpecValidator;

  /// No description provided for @selectGovValidator.
  ///
  /// In en, this message translates to:
  /// **'Kindly Select Governorate.'**
  String get selectGovValidator;

  /// No description provided for @selectAreaValidator.
  ///
  /// In en, this message translates to:
  /// **'Kindly Select Area.'**
  String get selectAreaValidator;

  /// No description provided for @pickSpec.
  ///
  /// In en, this message translates to:
  /// **'Select Speciality.'**
  String get pickSpec;

  /// No description provided for @pickGov.
  ///
  /// In en, this message translates to:
  /// **'Select Governorate.'**
  String get pickGov;

  /// No description provided for @pickArea.
  ///
  /// In en, this message translates to:
  /// **'Select Area.'**
  String get pickArea;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @bookBySpeciality.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment By Speciality'**
  String get bookBySpeciality;

  /// No description provided for @allOffers.
  ///
  /// In en, this message translates to:
  /// **'All Offers'**
  String get allOffers;

  /// No description provided for @pickFromOffers.
  ///
  /// In en, this message translates to:
  /// **'Pick from top offers'**
  String get pickFromOffers;

  /// No description provided for @pound.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get pound;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @ourTeam.
  ///
  /// In en, this message translates to:
  /// **'Our Team'**
  String get ourTeam;

  /// No description provided for @careers.
  ///
  /// In en, this message translates to:
  /// **'Careers'**
  String get careers;

  /// No description provided for @press.
  ///
  /// In en, this message translates to:
  /// **'Press'**
  String get press;

  /// No description provided for @ourServices.
  ///
  /// In en, this message translates to:
  /// **'Our Services'**
  String get ourServices;

  /// No description provided for @joinNetwork.
  ///
  /// In en, this message translates to:
  /// **'Join ProKliniK Network'**
  String get joinNetwork;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need Help ?'**
  String get needHelp;

  /// No description provided for @medicalLibrary.
  ///
  /// In en, this message translates to:
  /// **'Medical Library'**
  String get medicalLibrary;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms Of Use'**
  String get termsOfUse;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicyDoctors.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy For Doctors'**
  String get privacyPolicyDoctors;

  /// No description provided for @weHappySuggestions.
  ///
  /// In en, this message translates to:
  /// **'We will be happy to receive your inquiries and suggestions.'**
  String get weHappySuggestions;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get yourName;

  /// No description provided for @validateName.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter Your Name.'**
  String get validateName;

  /// No description provided for @firstLastName.
  ///
  /// In en, this message translates to:
  /// **'First And Last Name.'**
  String get firstLastName;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @validateNumber.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter Your Mobile Number.'**
  String get validateNumber;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @validateEmail.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter Your Email.'**
  String get validateEmail;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @validateMessage.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter Your Message.'**
  String get validateMessage;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @costRegular.
  ///
  /// In en, this message translates to:
  /// **'18888 Cost Of Regular Call'**
  String get costRegular;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressString.
  ///
  /// In en, this message translates to:
  /// **'Zahraa El Maadi - El Nada Tower - First Floor'**
  String get addressString;

  /// No description provided for @mailUs.
  ///
  /// In en, this message translates to:
  /// **'Mail Us'**
  String get mailUs;

  /// No description provided for @social.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get social;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
