import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'DIKLA SPIRIT';

  @override
  String get home => 'Home';

  @override
  String get shop => 'Shop';

  @override
  String get cart => 'Cart';

  @override
  String get myAccount => 'My Account';

  @override
  String get chat => 'Chat';

  @override
  String get shopNow => 'Shop Now';

  @override
  String get viewAll => 'View All';

  @override
  String get fastResults => 'Because You like\nfast results.';

  @override
  String get elevateExperience => 'Elevate your\nExperience';

  @override
  String get moreFromDikla => 'More From Dikla Spirit';

  @override
  String get bestSellingService => 'Bestselling Services';

  @override
  String get homeReviewHeader => 'JOIN THOUSANDS OF HAPPY CUSTOMERS \nWITH OVER 2000 FIVE-STAR REVIEWS!';

  @override
  String get checkMoreReviews => 'See More Reviews';

  @override
  String get quickSolutions => 'Quick Solutions\nRight Here';

  @override
  String get homeGuidance => 'Need a little Guidance\nWhat is best for you?';

  @override
  String get sortBy => 'Sort By';

  @override
  String get filterBy => 'Filter By';

  @override
  String get relevance => 'Relevance (Default)';

  @override
  String get bestselling => 'Bestselling';

  @override
  String get top_rated => 'Top Rated';

  @override
  String get price_low_to_high => 'Price Low to High';

  @override
  String get price_high_to_low => 'Price High to Low';

  @override
  String get sortBynew => 'New';

  @override
  String get clearAll => 'Clear All';

  @override
  String get showResults => 'Show Results';

  @override
  String get suitable_for_all => 'Suitable for all couples and genders';

  @override
  String get with_a_click_its_yours => 'With a Click it’s Yours';

  @override
  String get color => 'Color';

  @override
  String get availability => 'Availability: ';

  @override
  String get description => 'Description: ';

  @override
  String get get_started => 'Get Started';

  @override
  String get personalize_your_experience => 'Personalize Your Experience';

  @override
  String get confirm_preferences => 'Please confirm your preferences below';

  @override
  String get choose_language => 'Choose your language to get started';

  @override
  String get select_currency => 'Select your currency';

  @override
  String get save_preferences => 'Save Preferences';

  @override
  String get save_changes => 'Save Changes';

  @override
  String get howStrongDoYouWantYourSpell => 'How Strong Do You Want Your Spell?';

  @override
  String get forMoreQuestions => 'For More Questions';

  @override
  String get ratingAndReviews => 'Rating & Reviews';

  @override
  String get rating => 'Rating';

  @override
  String get questionsAndAnswers => 'Question & Answers';

  @override
  String get youMayAlsoLikeThis => 'You May Also Like This';

  @override
  String get writeAReview => 'Write a Review';

  @override
  String get sortByRating => 'Sort By Rating';

  @override
  String get myBag => 'My Bag';

  @override
  String get go_to_checkout => 'Go To Checkout';

  @override
  String get fastResultsProductDetail => 'For Faster Results \nWill Help You Too';

  @override
  String get moveFromBag => 'Move from Bag';

  @override
  String get my_orders => 'My Orders';

  @override
  String get order_details => 'Order Details';

  @override
  String get help_center => 'Help Center';

  @override
  String get submit_request => 'Submit a Request';

  @override
  String get profile_details => 'Set Profile Details';

  @override
  String get contact_informatiom => 'Contact Informatiom';

  @override
  String get personal_informatiom => 'Personal Informatiom';

  @override
  String get my_profile => 'My Profile';

  @override
  String get my_review => 'My Review';

  @override
  String get language_and_region => 'Language and Region';

  @override
  String get language => 'Language';

  @override
  String get currency => 'Currency';

  @override
  String get country => 'Country';

  @override
  String get support_and_information => 'Support and Information';

  @override
  String get quick_qa_with_dikla => 'Quick Q&A With Dikla';

  @override
  String get dikla_support_team => 'Dikla’s Support Team';

  @override
  String get dikla_promise_of_privacy => 'Dikla’s Promise Of Privacy';

  @override
  String get terms_and_condition => 'Terms & Condition';

  @override
  String get dikla_my_story => 'Dikla - My Story';

  @override
  String get dikla_happy_clients => 'Dikla - Happy Clients';

  @override
  String get log_out => 'Log Out';

  @override
  String get version => 'Version';

  @override
  String get select_country => 'Select Country';

  @override
  String get hey => 'Hey';

  @override
  String get welcome => 'Welcome';

  @override
  String get shipping_address => 'Shipping Address';

  @override
  String get zodiac_sign => 'Zodiac Sign';

  @override
  String get select_your_zodiac_sign => 'Select Your Zodiac Sign';

  @override
  String pageSettingsInputLanguage(String locale) {
    String _temp0 = intl.Intl.selectLogic(
      locale,
      {
        'he': 'עברית',
        'en': 'English',
        'es': 'Español',
        'other': '-',
      },
    );
    return '$_temp0';
  }
}
