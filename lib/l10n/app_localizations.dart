import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_he.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('en'),
    Locale('es'),
    Locale('he')
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'DIKLA SPIRIT'**
  String get title;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @shopNow.
  ///
  /// In en, this message translates to:
  /// **'Shop Now'**
  String get shopNow;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @fastResults.
  ///
  /// In en, this message translates to:
  /// **'Because You like\nfast results.'**
  String get fastResults;

  /// No description provided for @elevateExperience.
  ///
  /// In en, this message translates to:
  /// **'Elevate your\nExperience'**
  String get elevateExperience;

  /// No description provided for @moreFromDikla.
  ///
  /// In en, this message translates to:
  /// **'More From Dikla Spirit'**
  String get moreFromDikla;

  /// No description provided for @bestSellingService.
  ///
  /// In en, this message translates to:
  /// **'Bestselling Services'**
  String get bestSellingService;

  /// No description provided for @homeReviewHeader.
  ///
  /// In en, this message translates to:
  /// **'JOIN THOUSANDS OF HAPPY CUSTOMERS \nWITH OVER 2000 FIVE-STAR REVIEWS!'**
  String get homeReviewHeader;

  /// No description provided for @checkMoreReviews.
  ///
  /// In en, this message translates to:
  /// **'See More Reviews'**
  String get checkMoreReviews;

  /// No description provided for @quickSolutions.
  ///
  /// In en, this message translates to:
  /// **'Quick Solutions\nRight Here'**
  String get quickSolutions;

  /// No description provided for @homeGuidance.
  ///
  /// In en, this message translates to:
  /// **'Need a little Guidance\nWhat is best for you?'**
  String get homeGuidance;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @filterBy.
  ///
  /// In en, this message translates to:
  /// **'Filter By'**
  String get filterBy;

  /// No description provided for @relevance.
  ///
  /// In en, this message translates to:
  /// **'Relevance (Default)'**
  String get relevance;

  /// No description provided for @bestselling.
  ///
  /// In en, this message translates to:
  /// **'Bestselling'**
  String get bestselling;

  /// No description provided for @top_rated.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get top_rated;

  /// No description provided for @price_low_to_high.
  ///
  /// In en, this message translates to:
  /// **'Price Low to High'**
  String get price_low_to_high;

  /// No description provided for @price_high_to_low.
  ///
  /// In en, this message translates to:
  /// **'Price High to Low'**
  String get price_high_to_low;

  /// No description provided for @sortBynew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get sortBynew;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @showResults.
  ///
  /// In en, this message translates to:
  /// **'Show Results'**
  String get showResults;

  /// No description provided for @suitable_for_all.
  ///
  /// In en, this message translates to:
  /// **'Suitable for all couples and genders'**
  String get suitable_for_all;

  /// No description provided for @with_a_click_its_yours.
  ///
  /// In en, this message translates to:
  /// **'With a Click it’s Yours'**
  String get with_a_click_its_yours;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability: '**
  String get availability;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description: '**
  String get description;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @personalize_your_experience.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get personalize_your_experience;

  /// No description provided for @confirm_preferences.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your preferences below'**
  String get confirm_preferences;

  /// No description provided for @choose_language.
  ///
  /// In en, this message translates to:
  /// **'Choose your language to get started'**
  String get choose_language;

  /// No description provided for @select_currency.
  ///
  /// In en, this message translates to:
  /// **'Select your currency'**
  String get select_currency;

  /// No description provided for @save_preferences.
  ///
  /// In en, this message translates to:
  /// **'Save Preferences'**
  String get save_preferences;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save_changes;

  /// No description provided for @howStrongDoYouWantYourSpell.
  ///
  /// In en, this message translates to:
  /// **'How Strong Do You Want Your Spell?'**
  String get howStrongDoYouWantYourSpell;

  /// No description provided for @forMoreQuestions.
  ///
  /// In en, this message translates to:
  /// **'For More Questions'**
  String get forMoreQuestions;

  /// No description provided for @ratingAndReviews.
  ///
  /// In en, this message translates to:
  /// **'Rating & Reviews'**
  String get ratingAndReviews;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @questionsAndAnswers.
  ///
  /// In en, this message translates to:
  /// **'Question & Answers'**
  String get questionsAndAnswers;

  /// No description provided for @youMayAlsoLikeThis.
  ///
  /// In en, this message translates to:
  /// **'You May Also Like This'**
  String get youMayAlsoLikeThis;

  /// No description provided for @writeAReview.
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get writeAReview;

  /// No description provided for @sortByRating.
  ///
  /// In en, this message translates to:
  /// **'Sort By Rating'**
  String get sortByRating;

  /// No description provided for @myBag.
  ///
  /// In en, this message translates to:
  /// **'My Bag'**
  String get myBag;

  /// No description provided for @go_to_checkout.
  ///
  /// In en, this message translates to:
  /// **'Go To Checkout'**
  String get go_to_checkout;

  /// No description provided for @fastResultsProductDetail.
  ///
  /// In en, this message translates to:
  /// **'For Faster Results \nWill Help You Too'**
  String get fastResultsProductDetail;

  /// No description provided for @moveFromBag.
  ///
  /// In en, this message translates to:
  /// **'Move from Bag'**
  String get moveFromBag;

  /// No description provided for @my_orders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get my_orders;

  /// No description provided for @order_details.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get order_details;

  /// No description provided for @help_center.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get help_center;

  /// No description provided for @submit_request.
  ///
  /// In en, this message translates to:
  /// **'Submit a Request'**
  String get submit_request;

  /// No description provided for @profile_details.
  ///
  /// In en, this message translates to:
  /// **'Set Profile Details'**
  String get profile_details;

  /// No description provided for @contact_informatiom.
  ///
  /// In en, this message translates to:
  /// **'Contact Informatiom'**
  String get contact_informatiom;

  /// No description provided for @personal_informatiom.
  ///
  /// In en, this message translates to:
  /// **'Personal Informatiom'**
  String get personal_informatiom;

  /// No description provided for @my_profile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get my_profile;

  /// No description provided for @my_review.
  ///
  /// In en, this message translates to:
  /// **'My Review'**
  String get my_review;

  /// No description provided for @language_and_region.
  ///
  /// In en, this message translates to:
  /// **'Language and Region'**
  String get language_and_region;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @support_and_information.
  ///
  /// In en, this message translates to:
  /// **'Support and Information'**
  String get support_and_information;

  /// No description provided for @quick_qa_with_dikla.
  ///
  /// In en, this message translates to:
  /// **'Quick Q&A With Dikla'**
  String get quick_qa_with_dikla;

  /// No description provided for @dikla_support_team.
  ///
  /// In en, this message translates to:
  /// **'Dikla’s Support Team'**
  String get dikla_support_team;

  /// No description provided for @dikla_promise_of_privacy.
  ///
  /// In en, this message translates to:
  /// **'Dikla’s Promise Of Privacy'**
  String get dikla_promise_of_privacy;

  /// No description provided for @terms_and_condition.
  ///
  /// In en, this message translates to:
  /// **'Terms & Condition'**
  String get terms_and_condition;

  /// No description provided for @dikla_my_story.
  ///
  /// In en, this message translates to:
  /// **'Dikla - My Story'**
  String get dikla_my_story;

  /// No description provided for @dikla_happy_clients.
  ///
  /// In en, this message translates to:
  /// **'Dikla - Happy Clients'**
  String get dikla_happy_clients;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get log_out;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @select_country.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get select_country;

  /// No description provided for @hey.
  ///
  /// In en, this message translates to:
  /// **'Hey'**
  String get hey;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @shipping_address.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shipping_address;

  /// No description provided for @zodiac_sign.
  ///
  /// In en, this message translates to:
  /// **'Zodiac Sign'**
  String get zodiac_sign;

  /// No description provided for @select_your_zodiac_sign.
  ///
  /// In en, this message translates to:
  /// **'Select Your Zodiac Sign'**
  String get select_your_zodiac_sign;

  /// No description provided for @pageSettingsInputLanguage.
  ///
  /// In en, this message translates to:
  /// **'{locale, select, he {עברית} en {English} es {Español} other {-}}'**
  String pageSettingsInputLanguage(String locale);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'he'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'he': return AppLocalizationsHe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
