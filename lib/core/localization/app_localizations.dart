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

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @specTitle.
  ///
  /// In en, this message translates to:
  /// **'Speciality : '**
  String get specTitle;

  /// No description provided for @feesTitle.
  ///
  /// In en, this message translates to:
  /// **'Fees : '**
  String get feesTitle;

  /// No description provided for @waitingTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Waiting Time : '**
  String get waitingTimeTitle;

  /// No description provided for @ourHotlineTitle.
  ///
  /// In en, this message translates to:
  /// **'18888 : '**
  String get ourHotlineTitle;

  /// No description provided for @costRegularSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Cost Of Regular Call'**
  String get costRegularSubtitle;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @sorting.
  ///
  /// In en, this message translates to:
  /// **'Sorting : '**
  String get sorting;

  /// No description provided for @bestMatch.
  ///
  /// In en, this message translates to:
  /// **'Best Match'**
  String get bestMatch;

  /// No description provided for @priceL.
  ///
  /// In en, this message translates to:
  /// **'Price : Low To High'**
  String get priceL;

  /// No description provided for @priceH.
  ///
  /// In en, this message translates to:
  /// **'Price : High To Low'**
  String get priceH;

  /// No description provided for @waitingTime.
  ///
  /// In en, this message translates to:
  /// **'Waiting Time'**
  String get waitingTime;

  /// No description provided for @topRated.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get topRated;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @avalability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get avalability;

  /// No description provided for @anyDate.
  ///
  /// In en, this message translates to:
  /// **'Any Date'**
  String get anyDate;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @fees.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get fees;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @lessThan300.
  ///
  /// In en, this message translates to:
  /// **'Less Than 300 EGP'**
  String get lessThan300;

  /// No description provided for @moreThan300.
  ///
  /// In en, this message translates to:
  /// **'More Than 300 EGP'**
  String get moreThan300;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @any.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get any;

  /// No description provided for @nearestFirst.
  ///
  /// In en, this message translates to:
  /// **'From Near To Far'**
  String get nearestFirst;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No Results Found Matching Search Criteria, Kindly Refine Your Search And Try Again.'**
  String get noResults;

  /// No description provided for @overallRating.
  ///
  /// In en, this message translates to:
  /// **'Overall Rating'**
  String get overallRating;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @visitors.
  ///
  /// In en, this message translates to:
  /// **'Visitors'**
  String get visitors;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @am.
  ///
  /// In en, this message translates to:
  /// **'A.M.'**
  String get am;

  /// No description provided for @pm.
  ///
  /// In en, this message translates to:
  /// **'P.M.'**
  String get pm;

  /// No description provided for @noAppointments.
  ///
  /// In en, this message translates to:
  /// **'No Available Appointments.'**
  String get noAppointments;

  /// No description provided for @chooseYourApp.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Appointment'**
  String get chooseYourApp;

  /// No description provided for @bookAndPay.
  ///
  /// In en, this message translates to:
  /// **'Book online, Pay at the clinic!'**
  String get bookAndPay;

  /// No description provided for @doctorRequiresReservation.
  ///
  /// In en, this message translates to:
  /// **'Doctor requires reservation!'**
  String get doctorRequiresReservation;

  /// No description provided for @doctorBookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Doctor Booking Details'**
  String get doctorBookingDetails;

  /// No description provided for @doctorRating.
  ///
  /// In en, this message translates to:
  /// **'Doctor Rating'**
  String get doctorRating;

  /// No description provided for @views.
  ///
  /// In en, this message translates to:
  /// **'Views'**
  String get views;

  /// No description provided for @showAllReviews.
  ///
  /// In en, this message translates to:
  /// **'Show All Reviews'**
  String get showAllReviews;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get loadMore;

  /// No description provided for @aboutTheDoctor.
  ///
  /// In en, this message translates to:
  /// **'About The Doctor'**
  String get aboutTheDoctor;

  /// No description provided for @patientReviews.
  ///
  /// In en, this message translates to:
  /// **'Patient Reviews'**
  String get patientReviews;

  /// No description provided for @bookingInformation.
  ///
  /// In en, this message translates to:
  /// **'Booking Information'**
  String get bookingInformation;

  /// No description provided for @examination.
  ///
  /// In en, this message translates to:
  /// **'Examination'**
  String get examination;

  /// No description provided for @bookToRecieveInfo.
  ///
  /// In en, this message translates to:
  /// **'Book now to receive the clinic’s address details and phone number.'**
  String get bookToRecieveInfo;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @enterYourInfo.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Info'**
  String get enterYourInfo;

  /// No description provided for @ptNameForm.
  ///
  /// In en, this message translates to:
  /// **'Patient Name (Going To The Doctor)'**
  String get ptNameForm;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something Went Wrong'**
  String get somethingWentWrong;

  /// No description provided for @errorText.
  ///
  /// In en, this message translates to:
  /// **'This Page Seems To Be Moved Or Not Available At The Moment, Kindly Try Again Later.'**
  String get errorText;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Availabile'**
  String get available;

  /// No description provided for @validateEmailOrLeaveEmpty.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter A Valid Email Address Or Leave The Email Field Empty.'**
  String get validateEmailOrLeaveEmpty;

  /// No description provided for @validateMobileDigits.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter A Valid Mobile Number Consisting of 11 Digits.'**
  String get validateMobileDigits;

  /// No description provided for @thankYouForBooking.
  ///
  /// In en, this message translates to:
  /// **'Thank You For Using ProKliniK.'**
  String get thankYouForBooking;

  /// No description provided for @appConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Your Appointment Has Been Confirmed.'**
  String get appConfirmed;

  /// No description provided for @willBeNotified.
  ///
  /// In en, this message translates to:
  /// **'You Will Be Notified Via SMS By The Booking Details, Clinic Address & Location.'**
  String get willBeNotified;

  /// No description provided for @pageUnderConst.
  ///
  /// In en, this message translates to:
  /// **'This Page is Under Construction.'**
  String get pageUnderConst;

  /// No description provided for @sryMsg.
  ///
  /// In en, this message translates to:
  /// **'Sorry For Any Inconvenience, But This Page is Still Being Built And Tested. In The Mean Time, You Can Still Browse Other Pages.'**
  String get sryMsg;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon...'**
  String get comingSoon;

  /// No description provided for @joinedRecently.
  ///
  /// In en, this message translates to:
  /// **'Joined Recently.'**
  String get joinedRecently;

  /// No description provided for @degree.
  ///
  /// In en, this message translates to:
  /// **'Degree'**
  String get degree;

  /// No description provided for @specialist.
  ///
  /// In en, this message translates to:
  /// **'Specialist'**
  String get specialist;

  /// No description provided for @consultant.
  ///
  /// In en, this message translates to:
  /// **'Consultant'**
  String get consultant;

  /// No description provided for @bookingDate.
  ///
  /// In en, this message translates to:
  /// **'Booking Date'**
  String get bookingDate;

  /// No description provided for @updateBooking.
  ///
  /// In en, this message translates to:
  /// **'Change Booking Date'**
  String get updateBooking;

  /// No description provided for @deleteBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get deleteBooking;

  /// No description provided for @bookingAlreadyCanceled.
  ///
  /// In en, this message translates to:
  /// **'Booking Already Canceled.'**
  String get bookingAlreadyCanceled;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirmDeleteBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking ?'**
  String get confirmDeleteBookingTitle;

  /// No description provided for @confirmDeleteBookingMessage.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure ?'**
  String get confirmDeleteBookingMessage;

  /// No description provided for @thankYouForUsingProklinik.
  ///
  /// In en, this message translates to:
  /// **'Thank You For Using ProKliniK.'**
  String get thankYouForUsingProklinik;

  /// No description provided for @visitNotFound.
  ///
  /// In en, this message translates to:
  /// **'Visit Not Found.'**
  String get visitNotFound;

  /// No description provided for @unknownErrorHasOccured.
  ///
  /// In en, this message translates to:
  /// **'Unknown Error Has Occured.'**
  String get unknownErrorHasOccured;

  /// No description provided for @writeAReview.
  ///
  /// In en, this message translates to:
  /// **'Write Your Review.'**
  String get writeAReview;

  /// No description provided for @postWithNoName.
  ///
  /// In en, this message translates to:
  /// **'Post With No Name.'**
  String get postWithNoName;

  /// No description provided for @writeYourReview.
  ///
  /// In en, this message translates to:
  /// **'Write Your Review.'**
  String get writeYourReview;

  /// No description provided for @writeYourWaitingTime.
  ///
  /// In en, this message translates to:
  /// **'Write Your Waiting Time in Minutes.'**
  String get writeYourWaitingTime;

  /// No description provided for @submitReview.
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get submitReview;

  /// No description provided for @enterWaitingTime.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter Waiting Time.'**
  String get enterWaitingTime;

  /// No description provided for @yourReviewHasBeenSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Your Review Has Been Submitted.'**
  String get yourReviewHasBeenSubmitted;

  /// No description provided for @formSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Your Message Got Through.'**
  String get formSubmitted;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;
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
