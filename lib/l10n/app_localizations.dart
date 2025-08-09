import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'En'**
  String get appLanguage;

  /// No description provided for @statisticsTitle.
  ///
  /// In en, this message translates to:
  /// **'STATISTICS'**
  String get statisticsTitle;

  /// No description provided for @activityCalendarTitle.
  ///
  /// In en, this message translates to:
  /// **'ACTIVITY CALENDAR'**
  String get activityCalendarTitle;

  /// No description provided for @calculatorTitle.
  ///
  /// In en, this message translates to:
  /// **'CALCULATOR'**
  String get calculatorTitle;

  /// No description provided for @otherActivitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'OTHER ACTIVITIES'**
  String get otherActivitiesTitle;

  /// No description provided for @addIncomeExpensesTitle.
  ///
  /// In en, this message translates to:
  /// **'ADD INCOME / EXPENSES'**
  String get addIncomeExpensesTitle;

  /// No description provided for @editTitle.
  ///
  /// In en, this message translates to:
  /// **'EDIT'**
  String get editTitle;

  /// No description provided for @addAgainTitle.
  ///
  /// In en, this message translates to:
  /// **'ADD AGAIN'**
  String get addAgainTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settingsTitle;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'HELP'**
  String get helpTitle;

  /// No description provided for @helpTitle2.
  ///
  /// In en, this message translates to:
  /// **'HELP<'**
  String get helpTitle2;

  /// No description provided for @loginPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'LOGIN PASSWORD'**
  String get loginPasswordTitle;

  /// No description provided for @backupTitle.
  ///
  /// In en, this message translates to:
  /// **'BACKUP'**
  String get backupTitle;

  /// No description provided for @contactUsTitle.
  ///
  /// In en, this message translates to:
  /// **'CONTACT US'**
  String get contactUsTitle;

  /// No description provided for @myAssets.
  ///
  /// In en, this message translates to:
  /// **'MY ASSETS'**
  String get myAssets;

  /// No description provided for @myAssetsSmall.
  ///
  /// In en, this message translates to:
  /// **'My Assets'**
  String get myAssetsSmall;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Please select a language'**
  String get selectLanguage;

  /// No description provided for @languageSelection.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languageSelection;

  /// No description provided for @betterExperience.
  ///
  /// In en, this message translates to:
  /// **'For a better experience, complete the installation before starting'**
  String get betterExperience;

  /// No description provided for @startInstallation.
  ///
  /// In en, this message translates to:
  /// **'Start Installation'**
  String get startInstallation;

  /// No description provided for @skipInstallation.
  ///
  /// In en, this message translates to:
  /// **'Skip installation'**
  String get skipInstallation;

  /// No description provided for @continueInstallation.
  ///
  /// In en, this message translates to:
  /// **'Continue Installation'**
  String get continueInstallation;

  /// No description provided for @skipInstallationWarning.
  ///
  /// In en, this message translates to:
  /// **'If you skip the installation, the default settings will be selected automatically.'**
  String get skipInstallationWarning;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @selectCurrencyForApplication.
  ///
  /// In en, this message translates to:
  /// **'Select the currency you will use in the application'**
  String get selectCurrencyForApplication;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @appNotifications.
  ///
  /// In en, this message translates to:
  /// **'App Notifications'**
  String get appNotifications;

  /// No description provided for @setNotification.
  ///
  /// In en, this message translates to:
  /// **'Adjust'**
  String get setNotification;

  /// No description provided for @turnOnNotifications.
  ///
  /// In en, this message translates to:
  /// **''**
  String get turnOnNotifications;

  /// No description provided for @backupPreference.
  ///
  /// In en, this message translates to:
  /// **'Backup Data'**
  String get backupPreference;

  /// No description provided for @backupYourDataSecurely.
  ///
  /// In en, this message translates to:
  /// **'Back up your data securely with Google Drive'**
  String get backupYourDataSecurely;

  /// No description provided for @backupYourDataSecurelyViaGoogleAccount.
  ///
  /// In en, this message translates to:
  /// **'Back up your data securely with Google account'**
  String get backupYourDataSecurelyViaGoogleAccount;

  /// No description provided for @signInGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign In With Google Account'**
  String get signInGoogle;

  /// No description provided for @skipBackup.
  ///
  /// In en, this message translates to:
  /// **'Skip Backup'**
  String get skipBackup;

  /// No description provided for @accountSelection.
  ///
  /// In en, this message translates to:
  /// **'Account Selection'**
  String get accountSelection;

  /// No description provided for @yourAssetStatus.
  ///
  /// In en, this message translates to:
  /// **'Your Asset Status'**
  String get yourAssetStatus;

  /// No description provided for @trackAssets.
  ///
  /// In en, this message translates to:
  /// **'You can easily track your income and expenses by entering your assets.'**
  String get trackAssets;

  /// No description provided for @startFromZero.
  ///
  /// In en, this message translates to:
  /// **'You can add your assets later if you want.'**
  String get startFromZero;

  /// No description provided for @enterBankAssets.
  ///
  /// In en, this message translates to:
  /// **'Enter your bank assets'**
  String get enterBankAssets;

  /// No description provided for @enterCashAssets.
  ///
  /// In en, this message translates to:
  /// **'Enter your cash assets'**
  String get enterCashAssets;

  /// No description provided for @enterOtherAssets.
  ///
  /// In en, this message translates to:
  /// **'Enter your other assets'**
  String get enterOtherAssets;

  /// No description provided for @startingAmount.
  ///
  /// In en, this message translates to:
  /// **'Your starting amount:'**
  String get startingAmount;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @budgetTrackOnlyTurkish.
  ///
  /// In en, this message translates to:
  /// **''**
  String get budgetTrackOnlyTurkish;

  /// No description provided for @budgetTrack.
  ///
  /// In en, this message translates to:
  /// **'Budget Track'**
  String get budgetTrack;

  /// No description provided for @appPreparationMessage.
  ///
  /// In en, this message translates to:
  /// **'Your App is Getting Ready'**
  String get appPreparationMessage;

  /// No description provided for @thankYouMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for using Budget Wise'**
  String get thankYouMessage;

  /// No description provided for @savedActivities.
  ///
  /// In en, this message translates to:
  /// **'Saved Activities'**
  String get savedActivities;

  /// No description provided for @savedActivitiesAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get savedActivitiesAmount;

  /// No description provided for @savedActivitiesCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get savedActivitiesCategory;

  /// No description provided for @numberOfSavedActivities.
  ///
  /// In en, this message translates to:
  /// **'Number of Saved Activities:'**
  String get numberOfSavedActivities;

  /// No description provided for @lastActivities.
  ///
  /// In en, this message translates to:
  /// **'Last Activities'**
  String get lastActivities;

  /// No description provided for @numberOfShowingActivities.
  ///
  /// In en, this message translates to:
  /// **'Showing Activities'**
  String get numberOfShowingActivities;

  /// No description provided for @repetitiveActivities.
  ///
  /// In en, this message translates to:
  /// **'Repetitive Activities'**
  String get repetitiveActivities;

  /// No description provided for @repetitiveActivitiesSize.
  ///
  /// In en, this message translates to:
  /// **'18'**
  String get repetitiveActivitiesSize;

  /// No description provided for @cancelRepetition.
  ///
  /// In en, this message translates to:
  /// **'Cancel The Repetition'**
  String get cancelRepetition;

  /// No description provided for @yesCancel.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesCancel;

  /// No description provided for @confirmNoRepeat.
  ///
  /// In en, this message translates to:
  /// **'This activity will not be repeated again, do you confirm?'**
  String get confirmNoRepeat;

  /// No description provided for @repeatCancelled.
  ///
  /// In en, this message translates to:
  /// **'Repeat canceled'**
  String get repeatCancelled;

  /// No description provided for @activityDetailsSmall.
  ///
  /// In en, this message translates to:
  /// **'Activity Details'**
  String get activityDetailsSmall;

  /// No description provided for @activeRepetitiveActivities.
  ///
  /// In en, this message translates to:
  /// **'Number of Active Repeating Activities:'**
  String get activeRepetitiveActivities;

  /// No description provided for @installmentActivities.
  ///
  /// In en, this message translates to:
  /// **'Installment Activities'**
  String get installmentActivities;

  /// No description provided for @cancelInstallment.
  ///
  /// In en, this message translates to:
  /// **'Cancel The Installment'**
  String get cancelInstallment;

  /// No description provided for @confirmNoInstallments.
  ///
  /// In en, this message translates to:
  /// **'Subsequent installments will not be processed, do you confirm?'**
  String get confirmNoInstallments;

  /// No description provided for @installmentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Installment canceled'**
  String get installmentCancelled;

  /// No description provided for @activeInstallmentActivities.
  ///
  /// In en, this message translates to:
  /// **'Number of Active Installment Activities:'**
  String get activeInstallmentActivities;

  /// No description provided for @searchActivity.
  ///
  /// In en, this message translates to:
  /// **'Search for an Activity'**
  String get searchActivity;

  /// No description provided for @noMatchData.
  ///
  /// In en, this message translates to:
  /// **'No Matching Data'**
  String get noMatchData;

  /// No description provided for @numberOfActivitiesForSearchSection.
  ///
  /// In en, this message translates to:
  /// **'Number of Activities:'**
  String get numberOfActivitiesForSearchSection;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @activityCount.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activityCount;

  /// No description provided for @todaysActivities.
  ///
  /// In en, this message translates to:
  /// **'Today’s Activities'**
  String get todaysActivities;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @monthlyIncome.
  ///
  /// In en, this message translates to:
  /// **'Monthly\nIncome'**
  String get monthlyIncome;

  /// No description provided for @monthlyExpenses.
  ///
  /// In en, this message translates to:
  /// **'Monthly\nExpenses'**
  String get monthlyExpenses;

  /// No description provided for @monthlyExpensesWithoutEnter.
  ///
  /// In en, this message translates to:
  /// **'Monthly Expenses'**
  String get monthlyExpensesWithoutEnter;

  /// No description provided for @noActivity.
  ///
  /// In en, this message translates to:
  /// **'No Activity'**
  String get noActivity;

  /// No description provided for @monthlyStatisticsOnlyForTurkish.
  ///
  /// In en, this message translates to:
  /// **''**
  String get monthlyStatisticsOnlyForTurkish;

  /// No description provided for @monthlyStatisticsOnlyForEnglishAndArabic.
  ///
  /// In en, this message translates to:
  /// **'Statistics for'**
  String get monthlyStatisticsOnlyForEnglishAndArabic;

  /// No description provided for @dailyAverageSpending.
  ///
  /// In en, this message translates to:
  /// **'Daily average spending'**
  String get dailyAverageSpending;

  /// No description provided for @spendingScore.
  ///
  /// In en, this message translates to:
  /// **'Budget score'**
  String get spendingScore;

  /// No description provided for @mostSpendingCategory.
  ///
  /// In en, this message translates to:
  /// **'Category with the\nmost spending'**
  String get mostSpendingCategory;

  /// No description provided for @changeInNetSpending.
  ///
  /// In en, this message translates to:
  /// **'Change in net spendings\ncompared to the previous month'**
  String get changeInNetSpending;

  /// No description provided for @mostSpendingDay.
  ///
  /// In en, this message translates to:
  /// **'Day with the most spending'**
  String get mostSpendingDay;

  /// No description provided for @monthlyIncomeExpenseScore.
  ///
  /// In en, this message translates to:
  /// **'Score calculated based on monthly income-expense ratio'**
  String get monthlyIncomeExpenseScore;

  /// No description provided for @noSpending.
  ///
  /// In en, this message translates to:
  /// **'No spending'**
  String get noSpending;

  /// No description provided for @noResult.
  ///
  /// In en, this message translates to:
  /// **'No result'**
  String get noResult;

  /// No description provided for @mostExpensiveSpending.
  ///
  /// In en, this message translates to:
  /// **'Most expensive spending'**
  String get mostExpensiveSpending;

  /// No description provided for @both.
  ///
  /// In en, this message translates to:
  /// **'BOTH'**
  String get both;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'INCOME'**
  String get income;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'EXPENSES'**
  String get expenses;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'YEARLY'**
  String get yearly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'MONTHLY'**
  String get monthly;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY'**
  String get weekly;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'DAILY'**
  String get daily;

  /// No description provided for @dataNotFound.
  ///
  /// In en, this message translates to:
  /// **'Data not found'**
  String get dataNotFound;

  /// No description provided for @totalAmountStatistics.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmountStatistics;

  /// No description provided for @yesBig.
  ///
  /// In en, this message translates to:
  /// **'YES'**
  String get yesBig;

  /// No description provided for @noBig.
  ///
  /// In en, this message translates to:
  /// **'NO'**
  String get noBig;

  /// No description provided for @categoryAppBar.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryAppBar;

  /// No description provided for @tapToFilter.
  ///
  /// In en, this message translates to:
  /// **'Tap to Filter'**
  String get tapToFilter;

  /// No description provided for @statisticsFiltering.
  ///
  /// In en, this message translates to:
  /// **'Statistics Filtering'**
  String get statisticsFiltering;

  /// No description provided for @activityType.
  ///
  /// In en, this message translates to:
  /// **'Activity Type'**
  String get activityType;

  /// No description provided for @dateStatistics.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateStatistics;

  /// No description provided for @period.
  ///
  /// In en, this message translates to:
  /// **'PERIOD'**
  String get period;

  /// No description provided for @onlySavedActivities.
  ///
  /// In en, this message translates to:
  /// **'Only Saved Activities'**
  String get onlySavedActivities;

  /// No description provided for @paymentMethodStatistics.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethodStatistics;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'ALL'**
  String get all;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @okStatistics.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okStatistics;

  /// No description provided for @viewFullList.
  ///
  /// In en, this message translates to:
  /// **'View Full List'**
  String get viewFullList;

  /// No description provided for @fullList.
  ///
  /// In en, this message translates to:
  /// **'Full List'**
  String get fullList;

  /// No description provided for @numberOfElementsShown.
  ///
  /// In en, this message translates to:
  /// **'Number of Elements Shown'**
  String get numberOfElementsShown;

  /// No description provided for @noEnoughDataForTheChart.
  ///
  /// In en, this message translates to:
  /// **'There is no enough data for the chart'**
  String get noEnoughDataForTheChart;

  /// No description provided for @firstDayOfTheMonth.
  ///
  /// In en, this message translates to:
  /// **'First day of the Month'**
  String get firstDayOfTheMonth;

  /// No description provided for @setAsOnlyForTurkish.
  ///
  /// In en, this message translates to:
  /// **''**
  String get setAsOnlyForTurkish;

  /// No description provided for @setAsExceptTurkish.
  ///
  /// In en, this message translates to:
  /// **'set as'**
  String get setAsExceptTurkish;

  /// No description provided for @defaultOption.
  ///
  /// In en, this message translates to:
  /// **'Default 1'**
  String get defaultOption;

  /// No description provided for @incomeInfo.
  ///
  /// In en, this message translates to:
  /// **'Income Info'**
  String get incomeInfo;

  /// No description provided for @expenseInfo.
  ///
  /// In en, this message translates to:
  /// **'Expense Info'**
  String get expenseInfo;

  /// No description provided for @calendarMonday.
  ///
  /// In en, this message translates to:
  /// **'Mo'**
  String get calendarMonday;

  /// No description provided for @calendarTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tu'**
  String get calendarTuesday;

  /// No description provided for @calendarWednesday.
  ///
  /// In en, this message translates to:
  /// **'We'**
  String get calendarWednesday;

  /// No description provided for @calendarThursday.
  ///
  /// In en, this message translates to:
  /// **'Th'**
  String get calendarThursday;

  /// No description provided for @calendarFriday.
  ///
  /// In en, this message translates to:
  /// **'Fr'**
  String get calendarFriday;

  /// No description provided for @calendarSaturday.
  ///
  /// In en, this message translates to:
  /// **'Sa'**
  String get calendarSaturday;

  /// No description provided for @calendarSunday.
  ///
  /// In en, this message translates to:
  /// **'Su'**
  String get calendarSunday;

  /// No description provided for @calendarMonthStartDayButton.
  ///
  /// In en, this message translates to:
  /// **'The starting day of the month.\nLong Press to Change it'**
  String get calendarMonthStartDayButton;

  /// No description provided for @dataForTheDayNotFound.
  ///
  /// In en, this message translates to:
  /// **'Data for the day not found!'**
  String get dataForTheDayNotFound;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'DATE'**
  String get date;

  /// No description provided for @missingEntry.
  ///
  /// In en, this message translates to:
  /// **'Missing entry'**
  String get missingEntry;

  /// No description provided for @pleaseEnterAnAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount!'**
  String get pleaseEnterAnAmount;

  /// No description provided for @enterAmountAndCategory.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount and a category!'**
  String get enterAmountAndCategory;

  /// No description provided for @enterCategoryWarning.
  ///
  /// In en, this message translates to:
  /// **'Please enter a category!'**
  String get enterCategoryWarning;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong: '**
  String get somethingWentWrong;

  /// No description provided for @tapToSelect.
  ///
  /// In en, this message translates to:
  /// **'Tap to select'**
  String get tapToSelect;

  /// No description provided for @expenseCategories.
  ///
  /// In en, this message translates to:
  /// **'Expense Categories'**
  String get expenseCategories;

  /// No description provided for @incomeCategories.
  ///
  /// In en, this message translates to:
  /// **'Income Categories'**
  String get incomeCategories;

  /// No description provided for @addDeleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Add / Delete Category'**
  String get addDeleteCategory;

  /// No description provided for @systemCategory.
  ///
  /// In en, this message translates to:
  /// **'System\nCategory'**
  String get systemCategory;

  /// No description provided for @addExpenseCategory.
  ///
  /// In en, this message translates to:
  /// **'Add expense category...'**
  String get addExpenseCategory;

  /// No description provided for @addIncomeCategory.
  ///
  /// In en, this message translates to:
  /// **'Add income category...'**
  String get addIncomeCategory;

  /// No description provided for @doneCategory.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneCategory;

  /// No description provided for @foodExpense.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get foodExpense;

  /// No description provided for @clothingExpense.
  ///
  /// In en, this message translates to:
  /// **'Clothing'**
  String get clothingExpense;

  /// No description provided for @entertainmentExpense.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainmentExpense;

  /// No description provided for @educationExpense.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get educationExpense;

  /// No description provided for @duesRentExpense.
  ///
  /// In en, this message translates to:
  /// **'Dues/Rent'**
  String get duesRentExpense;

  /// No description provided for @shoppingExpense.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shoppingExpense;

  /// No description provided for @personelExpense.
  ///
  /// In en, this message translates to:
  /// **'Personel-'**
  String get personelExpense;

  /// No description provided for @transportExpense.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get transportExpense;

  /// No description provided for @healthExpense.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get healthExpense;

  /// No description provided for @dailyExpenses.
  ///
  /// In en, this message translates to:
  /// **'Daily Expenses'**
  String get dailyExpenses;

  /// No description provided for @hobbyExpense.
  ///
  /// In en, this message translates to:
  /// **'Hobby'**
  String get hobbyExpense;

  /// No description provided for @otherExpense.
  ///
  /// In en, this message translates to:
  /// **'Other-'**
  String get otherExpense;

  /// No description provided for @pocketMoneyIncome.
  ///
  /// In en, this message translates to:
  /// **'Pocket Money'**
  String get pocketMoneyIncome;

  /// No description provided for @grantIncome.
  ///
  /// In en, this message translates to:
  /// **'Grant'**
  String get grantIncome;

  /// No description provided for @salaryIncome.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salaryIncome;

  /// No description provided for @creditIncome.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get creditIncome;

  /// No description provided for @personalIncome.
  ///
  /// In en, this message translates to:
  /// **'Personal+'**
  String get personalIncome;

  /// No description provided for @duesRentIncome.
  ///
  /// In en, this message translates to:
  /// **'Rent/Dues'**
  String get duesRentIncome;

  /// No description provided for @overtimeIncome.
  ///
  /// In en, this message translates to:
  /// **'Overtime'**
  String get overtimeIncome;

  /// No description provided for @freelanceIncome.
  ///
  /// In en, this message translates to:
  /// **'Freelance Income'**
  String get freelanceIncome;

  /// No description provided for @incomeViaCurrencyIncome.
  ///
  /// In en, this message translates to:
  /// **'Income Via Currency'**
  String get incomeViaCurrencyIncome;

  /// No description provided for @investmentIncome.
  ///
  /// In en, this message translates to:
  /// **'Investment Income'**
  String get investmentIncome;

  /// No description provided for @otherIncome.
  ///
  /// In en, this message translates to:
  /// **'Other+'**
  String get otherIncome;

  /// No description provided for @deleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get deleteCategory;

  /// No description provided for @categoryWithTwoDots.
  ///
  /// In en, this message translates to:
  /// **'Category:'**
  String get categoryWithTwoDots;

  /// No description provided for @numberOfActivities.
  ///
  /// In en, this message translates to:
  /// **'Number of Activities:'**
  String get numberOfActivities;

  /// No description provided for @deleteAndKeep.
  ///
  /// In en, this message translates to:
  /// **'Delete and keep the categories from old records. (Suggested)'**
  String get deleteAndKeep;

  /// No description provided for @deleteAndReplace.
  ///
  /// In en, this message translates to:
  /// **'Delete and replace the categories in the old records with another category.'**
  String get deleteAndReplace;

  /// No description provided for @keepAndDelete.
  ///
  /// In en, this message translates to:
  /// **'Keep and delete'**
  String get keepAndDelete;

  /// No description provided for @categoryWillBeDeletedOldRecordsWillNotBeChanged.
  ///
  /// In en, this message translates to:
  /// **'The category you selected will be deleted and the old records will not be changed.'**
  String get categoryWillBeDeletedOldRecordsWillNotBeChanged;

  /// No description provided for @replaceAndDelete.
  ///
  /// In en, this message translates to:
  /// **'Replace and delete'**
  String get replaceAndDelete;

  /// No description provided for @replaceCategoryQuestion.
  ///
  /// In en, this message translates to:
  /// **'Enter the edited category'**
  String get replaceCategoryQuestion;

  /// No description provided for @replaceCategoryOldRecords.
  ///
  /// In en, this message translates to:
  /// **'Which category should replace\nthe categories in the old records?'**
  String get replaceCategoryOldRecords;

  /// No description provided for @replaceWithExceptTurkish.
  ///
  /// In en, this message translates to:
  /// **'replace with'**
  String get replaceWithExceptTurkish;

  /// No description provided for @replaceWithOnlyTurkish.
  ///
  /// In en, this message translates to:
  /// **''**
  String get replaceWithOnlyTurkish;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get selectCategory;

  /// No description provided for @doneSmall.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneSmall;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategory;

  /// No description provided for @editAndKeep.
  ///
  /// In en, this message translates to:
  /// **'Edit and keep categories from old records. (Suggested)'**
  String get editAndKeep;

  /// No description provided for @editAndReplace.
  ///
  /// In en, this message translates to:
  /// **'Edit and replace the categories in the old records with the edited category.'**
  String get editAndReplace;

  /// No description provided for @keepAndEdit.
  ///
  /// In en, this message translates to:
  /// **'Keep and edit'**
  String get keepAndEdit;

  /// No description provided for @replaceAndEdit.
  ///
  /// In en, this message translates to:
  /// **'Replace and edit'**
  String get replaceAndEdit;

  /// No description provided for @enterCategory.
  ///
  /// In en, this message translates to:
  /// **'Enter a category'**
  String get enterCategory;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'CASH'**
  String get cash;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'CARD'**
  String get card;

  /// No description provided for @otherPaye.
  ///
  /// In en, this message translates to:
  /// **'OTHER'**
  String get otherPaye;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get save;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'ADD NOTE'**
  String get addNote;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @customize.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMIZE'**
  String get customize;

  /// No description provided for @tapToCustomize.
  ///
  /// In en, this message translates to:
  /// **'Tap to customize'**
  String get tapToCustomize;

  /// No description provided for @repeat.
  ///
  /// In en, this message translates to:
  /// **'REPETITION'**
  String get repeat;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @installment.
  ///
  /// In en, this message translates to:
  /// **'INSTALLMENT'**
  String get installment;

  /// No description provided for @enterMonths.
  ///
  /// In en, this message translates to:
  /// **'Enter number of months (1-144)'**
  String get enterMonths;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get month;

  /// No description provided for @monthlyInstallment.
  ///
  /// In en, this message translates to:
  /// **'Monthly Installment'**
  String get monthlyInstallment;

  /// No description provided for @dailyAddData.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get dailyAddData;

  /// No description provided for @weeklyAddData.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weeklyAddData;

  /// No description provided for @biweekly.
  ///
  /// In en, this message translates to:
  /// **'Biweekly'**
  String get biweekly;

  /// No description provided for @monthlyAddData.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthlyAddData;

  /// No description provided for @bimonthly.
  ///
  /// In en, this message translates to:
  /// **'Bimonthly'**
  String get bimonthly;

  /// No description provided for @everyThreeMonths.
  ///
  /// In en, this message translates to:
  /// **'Every Three Months'**
  String get everyThreeMonths;

  /// No description provided for @everyFourMonths.
  ///
  /// In en, this message translates to:
  /// **'Every Four Months'**
  String get everyFourMonths;

  /// No description provided for @everySixMonths.
  ///
  /// In en, this message translates to:
  /// **'Every Six Months'**
  String get everySixMonths;

  /// No description provided for @yearlyAddData.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearlyAddData;

  /// No description provided for @turkTekrarOnly.
  ///
  /// In en, this message translates to:
  /// **''**
  String get turkTekrarOnly;

  /// No description provided for @ayTaksitArapcaEpty.
  ///
  /// In en, this message translates to:
  /// **'Months Installment'**
  String get ayTaksitArapcaEpty;

  /// No description provided for @tekrarTurkEmpty.
  ///
  /// In en, this message translates to:
  /// **'Repeats'**
  String get tekrarTurkEmpty;

  /// No description provided for @taksitArabicOnly.
  ///
  /// In en, this message translates to:
  /// **''**
  String get taksitArabicOnly;

  /// No description provided for @taksitDevamArabicOnly.
  ///
  /// In en, this message translates to:
  /// **''**
  String get taksitDevamArabicOnly;

  /// No description provided for @deleteAll.
  ///
  /// In en, this message translates to:
  /// **'DELETE ALL'**
  String get deleteAll;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get done;

  /// No description provided for @activityAdded.
  ///
  /// In en, this message translates to:
  /// **'Activity added'**
  String get activityAdded;

  /// No description provided for @percentageCalculation.
  ///
  /// In en, this message translates to:
  /// **'Percentage Calculation'**
  String get percentageCalculation;

  /// No description provided for @calculator.
  ///
  /// In en, this message translates to:
  /// **'Calculator'**
  String get calculator;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @percentageRate.
  ///
  /// In en, this message translates to:
  /// **'Percentage Rate'**
  String get percentageRate;

  /// No description provided for @enteraNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a number'**
  String get enteraNumber;

  /// No description provided for @enteraPercentage.
  ///
  /// In en, this message translates to:
  /// **'Enter a Percentage'**
  String get enteraPercentage;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @processTheSecondNumber.
  ///
  /// In en, this message translates to:
  /// **'Process The Second Number'**
  String get processTheSecondNumber;

  /// No description provided for @firstNumber.
  ///
  /// In en, this message translates to:
  /// **'First Number'**
  String get firstNumber;

  /// No description provided for @secondNumber.
  ///
  /// In en, this message translates to:
  /// **'Second Number'**
  String get secondNumber;

  /// No description provided for @result2.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result2;

  /// No description provided for @secondNumberPercentageOfFirstNumber.
  ///
  /// In en, this message translates to:
  /// **'What percentage is the second\nnumber of the first number?'**
  String get secondNumberPercentageOfFirstNumber;

  /// No description provided for @rateOfChange.
  ///
  /// In en, this message translates to:
  /// **'What is the rate of change from the\nfirst number to the second number?'**
  String get rateOfChange;

  /// No description provided for @creditCalculation.
  ///
  /// In en, this message translates to:
  /// **'Credit Calculation'**
  String get creditCalculation;

  /// No description provided for @amount2.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount2;

  /// No description provided for @interestPercent.
  ///
  /// In en, this message translates to:
  /// **'Interest (Percent)'**
  String get interestPercent;

  /// No description provided for @maturity.
  ///
  /// In en, this message translates to:
  /// **'Maturity (Month)'**
  String get maturity;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculate;

  /// No description provided for @deleteAll2.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAll2;

  /// No description provided for @pleaseFillInTheRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the required fields!'**
  String get pleaseFillInTheRequiredFields;

  /// No description provided for @monthlyEqualInstalments.
  ///
  /// In en, this message translates to:
  /// **'Monthly Equal Instalments:  '**
  String get monthlyEqualInstalments;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount:  '**
  String get totalAmount;

  /// No description provided for @totalInterest.
  ///
  /// In en, this message translates to:
  /// **'Total Interest:  '**
  String get totalInterest;

  /// No description provided for @totalPayment.
  ///
  /// In en, this message translates to:
  /// **'Total Payment:  '**
  String get totalPayment;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard:'**
  String get copiedToClipboard;

  /// No description provided for @calculateFromCurrentExchangeRate.
  ///
  /// In en, this message translates to:
  /// **'Calculate from Current Exchange Rate'**
  String get calculateFromCurrentExchangeRate;

  /// No description provided for @calculateFromOldExchangeRate.
  ///
  /// In en, this message translates to:
  /// **'Calculate from Old Exchange Rate'**
  String get calculateFromOldExchangeRate;

  /// No description provided for @currentExchangeRate.
  ///
  /// In en, this message translates to:
  /// **'Current Exchange Rate :'**
  String get currentExchangeRate;

  /// No description provided for @exchangeRate.
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate :'**
  String get exchangeRate;

  /// No description provided for @lastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last Update :'**
  String get lastUpdate;

  /// No description provided for @currencyConverter.
  ///
  /// In en, this message translates to:
  /// **'Currency Converter'**
  String get currencyConverter;

  /// No description provided for @calculatePercentage.
  ///
  /// In en, this message translates to:
  /// **'Calculate Percentage'**
  String get calculatePercentage;

  /// No description provided for @calculateInterestCredit.
  ///
  /// In en, this message translates to:
  /// **'Calculate Interest-Credit'**
  String get calculateInterestCredit;

  /// No description provided for @currencyConverterWarning.
  ///
  /// In en, this message translates to:
  /// **'Currency rates are updating.'**
  String get currencyConverterWarning;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @loginPassword.
  ///
  /// In en, this message translates to:
  /// **'Login Password'**
  String get loginPassword;

  /// No description provided for @downloadData.
  ///
  /// In en, this message translates to:
  /// **'Download Data'**
  String get downloadData;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// No description provided for @assets.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get assets;

  /// No description provided for @yourNetAsset.
  ///
  /// In en, this message translates to:
  /// **'Your Net Asset'**
  String get yourNetAsset;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @write.
  ///
  /// In en, this message translates to:
  /// **'Write =>'**
  String get write;

  /// No description provided for @evaluate.
  ///
  /// In en, this message translates to:
  /// **'Evaluate'**
  String get evaluate;

  /// No description provided for @recommend.
  ///
  /// In en, this message translates to:
  /// **'Recommend'**
  String get recommend;

  /// No description provided for @heyDoYouWantManage.
  ///
  /// In en, this message translates to:
  /// **'Hey! Do you want to manage your budget?'**
  String get heyDoYouWantManage;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download Budget Wise'**
  String get download;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;

  /// No description provided for @backupStatus.
  ///
  /// In en, this message translates to:
  /// **'Backup Status'**
  String get backupStatus;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @defaultCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get defaultCurrency;

  /// No description provided for @changeCurrencyWarning.
  ///
  /// In en, this message translates to:
  /// **'The currency of all records will be changed to the following currency according to the exchange rate of the activity date:'**
  String get changeCurrencyWarning;

  /// No description provided for @convert.
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get convert;

  /// No description provided for @convertMessage.
  ///
  /// In en, this message translates to:
  /// **'Converting\nplease wait'**
  String get convertMessage;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @dateFormat.
  ///
  /// In en, this message translates to:
  /// **'Date Format'**
  String get dateFormat;

  /// No description provided for @dateFormatSize.
  ///
  /// In en, this message translates to:
  /// **'150'**
  String get dateFormatSize;

  /// No description provided for @dayMonthYear.
  ///
  /// In en, this message translates to:
  /// **'Day.Month.Year'**
  String get dayMonthYear;

  /// No description provided for @monthDayYear.
  ///
  /// In en, this message translates to:
  /// **'Month.Day.Year'**
  String get monthDayYear;

  /// No description provided for @yearMonthDay.
  ///
  /// In en, this message translates to:
  /// **'Year.Month.Day'**
  String get yearMonthDay;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @whatsNew.
  ///
  /// In en, this message translates to:
  /// **'What\'s New'**
  String get whatsNew;

  /// No description provided for @guideline.
  ///
  /// In en, this message translates to:
  /// **'Guideline'**
  String get guideline;

  /// No description provided for @homePage.
  ///
  /// In en, this message translates to:
  /// **'Home Page'**
  String get homePage;

  /// No description provided for @statisticsPage.
  ///
  /// In en, this message translates to:
  /// **'Statistics\nPage'**
  String get statisticsPage;

  /// No description provided for @calendarPage.
  ///
  /// In en, this message translates to:
  /// **'Calendar\nPage'**
  String get calendarPage;

  /// No description provided for @calculatorHelp.
  ///
  /// In en, this message translates to:
  /// **'Calculator'**
  String get calculatorHelp;

  /// No description provided for @backupSystem.
  ///
  /// In en, this message translates to:
  /// **'Backup\nSystem'**
  String get backupSystem;

  /// No description provided for @addEditHelp.
  ///
  /// In en, this message translates to:
  /// **'Add\nEdit'**
  String get addEditHelp;

  /// No description provided for @exchangeSystemHelp.
  ///
  /// In en, this message translates to:
  /// **'Exchange\nSystem'**
  String get exchangeSystemHelp;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get faq;

  /// No description provided for @appShutdown.
  ///
  /// In en, this message translates to:
  /// **'Application Keeps Shutting Down'**
  String get appShutdown;

  /// No description provided for @recordsGone.
  ///
  /// In en, this message translates to:
  /// **'My Records Are Gone What Should I Do?'**
  String get recordsGone;

  /// No description provided for @iWantToContactYou.
  ///
  /// In en, this message translates to:
  /// **'I Want To Contact You'**
  String get iWantToContactYou;

  /// No description provided for @answerOne.
  ///
  /// In en, this message translates to:
  /// **'In some cases, we may encounter unexpected results. In such a case, what you need to do is checking the updates. If the problem is not solved, please leave a feedback.'**
  String get answerOne;

  /// No description provided for @answerTwo.
  ///
  /// In en, this message translates to:
  /// **'The fact that the database does not support the old version with the last update to the application may have caused this problem. In order not to encounter this situation, our technical team performs the backup process during the version update, you can still leave a feedback.'**
  String get answerTwo;

  /// No description provided for @answerThree.
  ///
  /// In en, this message translates to:
  /// **'You can contact us via our e-mail or Linkedin addresses in the contact section of our application.'**
  String get answerThree;

  /// No description provided for @passwordStatus.
  ///
  /// In en, this message translates to:
  /// **'Password Status'**
  String get passwordStatus;

  /// No description provided for @newPasscode.
  ///
  /// In en, this message translates to:
  /// **'Enter the new password'**
  String get newPasscode;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords Do Not Match'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordCreated.
  ///
  /// In en, this message translates to:
  /// **'Your Password Has Been Created'**
  String get passwordCreated;

  /// No description provided for @securityQuestion.
  ///
  /// In en, this message translates to:
  /// **'Security question:'**
  String get securityQuestion;

  /// No description provided for @enterThePasscode.
  ///
  /// In en, this message translates to:
  /// **'Enter the passcode'**
  String get enterThePasscode;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPassword;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @youHaveNotCreatedAnyPasswordWarning.
  ///
  /// In en, this message translates to:
  /// **'You have not created any password. Do you still want to create a password?'**
  String get youHaveNotCreatedAnyPasswordWarning;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @whatIsYourFavoriteAnimal.
  ///
  /// In en, this message translates to:
  /// **'What is your favorite animal ?'**
  String get whatIsYourFavoriteAnimal;

  /// No description provided for @pleaseEnteraName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get pleaseEnteraName;

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get enter;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @disablePasswordParagraph.
  ///
  /// In en, this message translates to:
  /// **'To disable the password, you must answer the security question. You only have 3 tries, in case you enter incorrectly, your data will be deleted. If you are ready.'**
  String get disablePasswordParagraph;

  /// No description provided for @continueProcessing.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueProcessing;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @remainingTries.
  ///
  /// In en, this message translates to:
  /// **'Remaining Tries'**
  String get remainingTries;

  /// No description provided for @backupViaGoogleDrive.
  ///
  /// In en, this message translates to:
  /// **'Backup via Google Drive'**
  String get backupViaGoogleDrive;

  /// No description provided for @backupViaGoogleAccount.
  ///
  /// In en, this message translates to:
  /// **'Backup via Google account'**
  String get backupViaGoogleAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'E-mail:  '**
  String get email;

  /// No description provided for @nameAndSurname.
  ///
  /// In en, this message translates to:
  /// **'Name and Surname:'**
  String get nameAndSurname;

  /// No description provided for @lastBackupDate.
  ///
  /// In en, this message translates to:
  /// **'Last Backup Date:'**
  String get lastBackupDate;

  /// No description provided for @notBackedUp.
  ///
  /// In en, this message translates to:
  /// **'Not backed up'**
  String get notBackedUp;

  /// No description provided for @backupFrequency.
  ///
  /// In en, this message translates to:
  /// **'Backup Frequency'**
  String get backupFrequency;

  /// No description provided for @dailyBackup.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get dailyBackup;

  /// No description provided for @monthlyBackup.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthlyBackup;

  /// No description provided for @yearlyBackup.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearlyBackup;

  /// No description provided for @restoreData.
  ///
  /// In en, this message translates to:
  /// **'Restore Data'**
  String get restoreData;

  /// No description provided for @numberOfRecordsShown.
  ///
  /// In en, this message translates to:
  /// **'Number of Records Shown:'**
  String get numberOfRecordsShown;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @uploadedToGoogleDrive.
  ///
  /// In en, this message translates to:
  /// **'Uploaded to Google Drive'**
  String get uploadedToGoogleDrive;

  /// No description provided for @dataRestoredFromGoogleDrive.
  ///
  /// In en, this message translates to:
  /// **'Your data has been restored from Google Drive'**
  String get dataRestoredFromGoogleDrive;

  /// No description provided for @yourDataIsBackedUp.
  ///
  /// In en, this message translates to:
  /// **'Your data is backed up'**
  String get yourDataIsBackedUp;

  /// No description provided for @yourDataHasBeenRestored.
  ///
  /// In en, this message translates to:
  /// **'Your data has been restored'**
  String get yourDataHasBeenRestored;

  /// No description provided for @backupError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while backing up!'**
  String get backupError;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @github.
  ///
  /// In en, this message translates to:
  /// **'Github:  '**
  String get github;

  /// No description provided for @developers.
  ///
  /// In en, this message translates to:
  /// **'DEVELOPERS'**
  String get developers;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning!'**
  String get goodMorning;

  /// No description provided for @goodDay.
  ///
  /// In en, this message translates to:
  /// **'Have a nice day!'**
  String get goodDay;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening!'**
  String get goodEvening;

  /// No description provided for @goodNight.
  ///
  /// In en, this message translates to:
  /// **'Goodnight!'**
  String get goodNight;

  /// No description provided for @hopeGood.
  ///
  /// In en, this message translates to:
  /// **'We hope you\'re doing well'**
  String get hopeGood;

  /// No description provided for @totalAssets.
  ///
  /// In en, this message translates to:
  /// **'TOTAL ASSET'**
  String get totalAssets;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'TOTAL'**
  String get total;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @myPastAssetRecords.
  ///
  /// In en, this message translates to:
  /// **'MY PAST ASSET RECORDS'**
  String get myPastAssetRecords;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @totalSmall.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalSmall;

  /// No description provided for @doneBitti.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneBitti;

  /// No description provided for @noAssetFound.
  ///
  /// In en, this message translates to:
  /// **'No Asset Found!'**
  String get noAssetFound;

  /// No description provided for @addRemoveAsset.
  ///
  /// In en, this message translates to:
  /// **'Add/Remove Asset'**
  String get addRemoveAsset;

  /// No description provided for @myCurrencies.
  ///
  /// In en, this message translates to:
  /// **'My Currencies'**
  String get myCurrencies;

  /// No description provided for @myCurrenciesSize.
  ///
  /// In en, this message translates to:
  /// **'0.39'**
  String get myCurrenciesSize;

  /// No description provided for @currencyNotFound.
  ///
  /// In en, this message translates to:
  /// **'Currency Not Found'**
  String get currencyNotFound;

  /// No description provided for @addAssetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Asset'**
  String get addAssetTitle;

  /// No description provided for @removeAssetTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove Asset'**
  String get removeAssetTitle;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @cashAsset.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cashAsset;

  /// No description provided for @cardAsset.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get cardAsset;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @removeAsset.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeAsset;

  /// No description provided for @addAsset.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addAsset;

  /// No description provided for @doneAsset.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneAsset;

  /// No description provided for @pleaseSelectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Please Select a Currency'**
  String get pleaseSelectCurrency;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get enterAmount;

  /// No description provided for @asset.
  ///
  /// In en, this message translates to:
  /// **'ASSET'**
  String get asset;

  /// No description provided for @currencyExchange.
  ///
  /// In en, this message translates to:
  /// **'Currency Exchange'**
  String get currencyExchange;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note:'**
  String get note;

  /// No description provided for @convertTo.
  ///
  /// In en, this message translates to:
  /// **'Convert To'**
  String get convertTo;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get selectCurrency;

  /// No description provided for @doneExchange.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneExchange;

  /// No description provided for @currentRate.
  ///
  /// In en, this message translates to:
  /// **'Current Rate'**
  String get currentRate;

  /// No description provided for @receivedAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount You Will Receive'**
  String get receivedAmount;

  /// No description provided for @detailsForCurrencyExchange.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detailsForCurrencyExchange;

  /// No description provided for @activityDetails.
  ///
  /// In en, this message translates to:
  /// **'ACTIVITY DETAILS'**
  String get activityDetails;

  /// No description provided for @activityDetail.
  ///
  /// In en, this message translates to:
  /// **'Activity\nDetail'**
  String get activityDetail;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'DETAILS'**
  String get details;

  /// No description provided for @dateDetails.
  ///
  /// In en, this message translates to:
  /// **'DATE'**
  String get dateDetails;

  /// No description provided for @timeDetails.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get timeDetails;

  /// No description provided for @categoryDetails.
  ///
  /// In en, this message translates to:
  /// **'CATEGORY'**
  String get categoryDetails;

  /// No description provided for @paymentMethodDetails.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT METHOD'**
  String get paymentMethodDetails;

  /// No description provided for @cashDetails.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cashDetails;

  /// No description provided for @cardDetails.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get cardDetails;

  /// No description provided for @amountDetails.
  ///
  /// In en, this message translates to:
  /// **'AMOUNT'**
  String get amountDetails;

  /// No description provided for @savingStatusDetails.
  ///
  /// In en, this message translates to:
  /// **'SAVING STATUS'**
  String get savingStatusDetails;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @notSaved.
  ///
  /// In en, this message translates to:
  /// **'Not saved'**
  String get notSaved;

  /// No description provided for @systemMessage.
  ///
  /// In en, this message translates to:
  /// **'SYSTEM MESSAGE'**
  String get systemMessage;

  /// No description provided for @repetitionActivityDetails.
  ///
  /// In en, this message translates to:
  /// **'REPETITION'**
  String get repetitionActivityDetails;

  /// No description provided for @installmentActivityDetails.
  ///
  /// In en, this message translates to:
  /// **'INSTALLMENT'**
  String get installmentActivityDetails;

  /// No description provided for @addAgain.
  ///
  /// In en, this message translates to:
  /// **'Add Again'**
  String get addAgain;

  /// No description provided for @noteDetails.
  ///
  /// In en, this message translates to:
  /// **'NOTE'**
  String get noteDetails;

  /// No description provided for @noNoteAdded.
  ///
  /// In en, this message translates to:
  /// **'No Note Added'**
  String get noNoteAdded;

  /// No description provided for @deleteDetails.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteDetails;

  /// No description provided for @activityDeleted.
  ///
  /// In en, this message translates to:
  /// **'Activity deleted'**
  String get activityDeleted;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @updateDone.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get updateDone;

  /// No description provided for @activityUpdated.
  ///
  /// In en, this message translates to:
  /// **'Activity updated'**
  String get activityUpdated;

  /// No description provided for @clickToAddNote.
  ///
  /// In en, this message translates to:
  /// **'Tap to add note'**
  String get clickToAddNote;

  /// No description provided for @firstWeek.
  ///
  /// In en, this message translates to:
  /// **'1st week'**
  String get firstWeek;

  /// No description provided for @secondWeek.
  ///
  /// In en, this message translates to:
  /// **'2nd week'**
  String get secondWeek;

  /// No description provided for @thirdWeek.
  ///
  /// In en, this message translates to:
  /// **'3rd week'**
  String get thirdWeek;

  /// No description provided for @fourthWeek.
  ///
  /// In en, this message translates to:
  /// **'4th week'**
  String get fourthWeek;

  /// No description provided for @fifthWeek.
  ///
  /// In en, this message translates to:
  /// **'5th week'**
  String get fifthWeek;

  /// No description provided for @activeCurrency.
  ///
  /// In en, this message translates to:
  /// **'Active Currency'**
  String get activeCurrency;

  /// No description provided for @inactiveCurrency.
  ///
  /// In en, this message translates to:
  /// **'Inactive Currency'**
  String get inactiveCurrency;

  /// No description provided for @backupSystem1.
  ///
  /// In en, this message translates to:
  /// **'BACKUP SYSTEM'**
  String get backupSystem1;

  /// No description provided for @backupSystem2.
  ///
  /// In en, this message translates to:
  /// **'All your data is backed up via your Google account. For this, you need to log in with your Google account.'**
  String get backupSystem2;

  /// No description provided for @whatYouCanDoOnThisPage.
  ///
  /// In en, this message translates to:
  /// **'What you can do on this page'**
  String get whatYouCanDoOnThisPage;

  /// No description provided for @backupSystem4.
  ///
  /// In en, this message translates to:
  /// **'By default, automatic backup is active and monthly backups are made by default.'**
  String get backupSystem4;

  /// No description provided for @backupSystem5.
  ///
  /// In en, this message translates to:
  /// **'When the Backup button is clicked, all your data is backed up by converting them to .csv file.'**
  String get backupSystem5;

  /// No description provided for @backupSystem6.
  ///
  /// In en, this message translates to:
  /// **'When the Restore Data button is clicked, the most recently backed up records are downloaded to the application.'**
  String get backupSystem6;

  /// No description provided for @backupSystem7.
  ///
  /// In en, this message translates to:
  /// **'If you long press on your recording, you can delete the recording you want.'**
  String get backupSystem7;

  /// No description provided for @backupSystem8.
  ///
  /// In en, this message translates to:
  /// **'When your records are restored, your existing records are deleted and your selected records are loaded.'**
  String get backupSystem8;

  /// No description provided for @assetsPage1.
  ///
  /// In en, this message translates to:
  /// **'MY ASSETS PAGE'**
  String get assetsPage1;

  /// No description provided for @assetsPage2.
  ///
  /// In en, this message translates to:
  /// **'The My Assets page is designed for you to see all your assets.'**
  String get assetsPage2;

  /// No description provided for @assetsPage3.
  ///
  /// In en, this message translates to:
  /// **'Allows you to edit your assets. You can add or remove either in foreign currency or in your local currency.,'**
  String get assetsPage3;

  /// No description provided for @assetsPage4.
  ///
  /// In en, this message translates to:
  /// **'Net amounts for each of the Card, Cash and Other are also shown.'**
  String get assetsPage4;

  /// No description provided for @assetsPage5.
  ///
  /// In en, this message translates to:
  /// **'In the field designated for your currencies, only your active currencies are displayed. This field shows records that different from the default currency and are entered as income'**
  String get assetsPage5;

  /// No description provided for @assetsPage6.
  ///
  /// In en, this message translates to:
  /// **'You can change the currency of the displayed records either here or from the activity details. When you click on the record, the Currency Exchange will show up and you can exchange or  convert your currency to different currencies with current exchange rates.'**
  String get assetsPage6;

  /// No description provided for @version2Title.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version2Title;

  /// No description provided for @version2.
  ///
  /// In en, this message translates to:
  /// **'V2.1.1 Version'**
  String get version2;

  /// No description provided for @budgetUpdate.
  ///
  /// In en, this message translates to:
  /// **'Budget Wise Updated!'**
  String get budgetUpdate;

  /// No description provided for @implementedSuggestions.
  ///
  /// In en, this message translates to:
  /// **'We have implemented your suggestions so far in the Budget Wise application.'**
  String get implementedSuggestions;

  /// No description provided for @whatsNewVersion.
  ///
  /// In en, this message translates to:
  /// **'What\'s New'**
  String get whatsNewVersion;

  /// No description provided for @languageSupport.
  ///
  /// In en, this message translates to:
  /// **'Language Support'**
  String get languageSupport;

  /// No description provided for @supportedLanguages.
  ///
  /// In en, this message translates to:
  /// **'You can now use the application in the following languages: Turkish, English, Arabic.'**
  String get supportedLanguages;

  /// No description provided for @currencies.
  ///
  /// In en, this message translates to:
  /// **'Currencies'**
  String get currencies;

  /// No description provided for @supportedCurrencies.
  ///
  /// In en, this message translates to:
  /// **'You can now use the following currencies: USD TRY GBP EUR KWD IQD SAR JOD'**
  String get supportedCurrencies;

  /// No description provided for @exchangeSystem.
  ///
  /// In en, this message translates to:
  /// **'Foreign Exchange System'**
  String get exchangeSystem;

  /// No description provided for @exchangeSystemDescription.
  ///
  /// In en, this message translates to:
  /// **'In the new exchange system, rates and your records are updated every 3 hours. Your foreign exchange activities are evaluated to determine their status as either active or inactive.'**
  String get exchangeSystemDescription;

  /// No description provided for @currencyConverterDescription.
  ///
  /// In en, this message translates to:
  /// **'The currency converter is now active. You can make your calculations from current and old exchange rates.'**
  String get currencyConverterDescription;

  /// No description provided for @darkModeDescription.
  ///
  /// In en, this message translates to:
  /// **'You can switch to the dark mode for a more comfortable experience.'**
  String get darkModeDescription;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @categoriesDescription.
  ///
  /// In en, this message translates to:
  /// **'You can add as many categories as you want, and you can also edit the categories you added.'**
  String get categoriesDescription;

  /// No description provided for @activityCustomize.
  ///
  /// In en, this message translates to:
  /// **'Activity Customize'**
  String get activityCustomize;

  /// No description provided for @activityCustomizeDescription.
  ///
  /// In en, this message translates to:
  /// **'It is now possible to add repetitive and installment activities. You can customize your activities from the add page.'**
  String get activityCustomizeDescription;

  /// No description provided for @newBackupSystem.
  ///
  /// In en, this message translates to:
  /// **'Backup System'**
  String get newBackupSystem;

  /// No description provided for @backupSystemDescription.
  ///
  /// In en, this message translates to:
  /// **'Google Drive backup has been added for your data security, and error management has been added for auto backup.'**
  String get backupSystemDescription;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchDescription.
  ///
  /// In en, this message translates to:
  /// **'To access your past activities, you can type the note, date, payment method, or category into the search engine.'**
  String get searchDescription;

  /// No description provided for @myAssetsPage.
  ///
  /// In en, this message translates to:
  /// **'My Assets Page'**
  String get myAssetsPage;

  /// No description provided for @myAssetsPageDescription.
  ///
  /// In en, this message translates to:
  /// **'You can view and add your assets from a single page; also, your active currencies are displayed on this page.'**
  String get myAssetsPageDescription;

  /// No description provided for @installation.
  ///
  /// In en, this message translates to:
  /// **'Installation'**
  String get installation;

  /// No description provided for @installationDescription.
  ///
  /// In en, this message translates to:
  /// **'You can enhance your app experience by following the installation.'**
  String get installationDescription;

  /// No description provided for @statisticsImprovements.
  ///
  /// In en, this message translates to:
  /// **'Statistics Improvements'**
  String get statisticsImprovements;

  /// No description provided for @statisticsImprovementsDescription.
  ///
  /// In en, this message translates to:
  /// **'You can now get more detailed statistics with more filtering options.'**
  String get statisticsImprovementsDescription;

  /// No description provided for @interfaceImprovements.
  ///
  /// In en, this message translates to:
  /// **'Interface Improvements'**
  String get interfaceImprovements;

  /// No description provided for @interfaceImprovementsDescription.
  ///
  /// In en, this message translates to:
  /// **'In order to increase the user experience, a more useful interface was made and design adjustments were made. Scrollable design has been implemented on the home page and calendar page.'**
  String get interfaceImprovementsDescription;

  /// No description provided for @newSettings.
  ///
  /// In en, this message translates to:
  /// **'New Settings'**
  String get newSettings;

  /// No description provided for @newSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'You can now set the starting day of the month. You can also choose your date format.'**
  String get newSettingsDescription;

  /// No description provided for @yeniNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get yeniNew;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @homePageHelp.
  ///
  /// In en, this message translates to:
  /// **'HOME PAGE'**
  String get homePageHelp;

  /// No description provided for @homePageDescription.
  ///
  /// In en, this message translates to:
  /// **'This page has been prepared for you to follow the activities you have added on a monthly basis and to access other pages.'**
  String get homePageDescription;

  /// No description provided for @activitySearchMenu.
  ///
  /// In en, this message translates to:
  /// **'Activity search menu by note and category.'**
  String get activitySearchMenu;

  /// No description provided for @repeatingAndInstallmentMenu.
  ///
  /// In en, this message translates to:
  /// **'Repeating and installment activities menu. You can check such activities here.'**
  String get repeatingAndInstallmentMenu;

  /// No description provided for @savedAndRecentMenu.
  ///
  /// In en, this message translates to:
  /// **'Saved activities menu and recent activities menu.'**
  String get savedAndRecentMenu;

  /// No description provided for @settingsMenu.
  ///
  /// In en, this message translates to:
  /// **'Settings menu. You can also change the theme here by holding down the icon.'**
  String get settingsMenu;

  /// No description provided for @changeMonthButtonInfo.
  ///
  /// In en, this message translates to:
  /// **'You can change the month using the buttons or simply swipe the monthly data left or right. Pressing the text will return you to the current month.'**
  String get changeMonthButtonInfo;

  /// No description provided for @dailyActivitiesInfo.
  ///
  /// In en, this message translates to:
  /// **'Contains the day\'s activities. You can click on it to see the details listed.'**
  String get dailyActivitiesInfo;

  /// No description provided for @accessDetailsButtonInfo.
  ///
  /// In en, this message translates to:
  /// **'By pressing these text buttons, you can access the activity details of the current day or the calendar menu.'**
  String get accessDetailsButtonInfo;

  /// No description provided for @activityDetailsDropdown.
  ///
  /// In en, this message translates to:
  /// **'Activity Details - Dropdown Menu'**
  String get activityDetailsDropdown;

  /// No description provided for @activityDetailsInfo.
  ///
  /// In en, this message translates to:
  /// **'It contains all the details of an activity. From this menu, you can delete, re-add, and edit the activity.'**
  String get activityDetailsInfo;

  /// No description provided for @activeInfo.
  ///
  /// In en, this message translates to:
  /// **'This information will be included with the currencies you add as income. If you don\'t spend the money, it will be recalculated daily based on the current exchange rate.'**
  String get activeInfo;

  /// No description provided for @inactiveInfo.
  ///
  /// In en, this message translates to:
  /// **'This information will appear as a result of adding a foreign currency as an expense that was previously added as income, so the amount will remain constant.'**
  String get inactiveInfo;

  /// No description provided for @systemMessageInfo.
  ///
  /// In en, this message translates to:
  /// **'If SYSTEM MESSAGE appears in the activity details menu, that activity is a repetitive or installment activity.'**
  String get systemMessageInfo;

  /// No description provided for @addEdit.
  ///
  /// In en, this message translates to:
  /// **'ADD – EDIT ACTIVITY'**
  String get addEdit;

  /// No description provided for @operationsDescription.
  ///
  /// In en, this message translates to:
  /// **'You can do three operations from one page. Add, edit and re-add the activity.'**
  String get operationsDescription;

  /// No description provided for @categoryCurrencyVariation.
  ///
  /// In en, this message translates to:
  /// **'Category types and whether currency is active or inactive will vary depending on the income or expense selection.'**
  String get categoryCurrencyVariation;

  /// No description provided for @startingDaySelection.
  ///
  /// In en, this message translates to:
  /// **'The day on which the activity is added will also be selected as the starting day for repeating and installment activities.'**
  String get startingDaySelection;

  /// No description provided for @systemCategoryEdit.
  ///
  /// In en, this message translates to:
  /// **'System categories cannot be edited. You can only edit categories you\'ve added.'**
  String get systemCategoryEdit;

  /// No description provided for @singleCardPayment.
  ///
  /// In en, this message translates to:
  /// **'You can only add one card to how you pay the activity.'**
  String get singleCardPayment;

  /// No description provided for @savedActivitiesMenu.
  ///
  /// In en, this message translates to:
  /// **'The activities you have saved will be listed in the menu at the top of the home page.'**
  String get savedActivitiesMenu;

  /// No description provided for @repeatingToInstallment.
  ///
  /// In en, this message translates to:
  /// **'A repeating activity cannot be converted to an installment activity later. For an activity in installments, you must enter the entire amount, the system will divide the amount according to the number of installments.'**
  String get repeatingToInstallment;

  /// No description provided for @maximumAmount.
  ///
  /// In en, this message translates to:
  /// **'You can add a maximum of 7-digit amount. If you add foreign currency, the foreign currency will be calculated according to the date of the activity.'**
  String get maximumAmount;

  /// No description provided for @incomeCurrencyUpdate.
  ///
  /// In en, this message translates to:
  /// **'Only the amount of foreign currency you add as income will constantly change according to the current exchange rate. You can check these activities from the activity details.'**
  String get incomeCurrencyUpdate;

  /// No description provided for @activityEditAddAgain.
  ///
  /// In en, this message translates to:
  /// **'Activity Edit - Add Again'**
  String get activityEditAddAgain;

  /// No description provided for @activityAddAgainCurrentDate.
  ///
  /// In en, this message translates to:
  /// **'Activities you will add again will be added according to the current date, while activities you will edit will be arranged according to the date of the activity.'**
  String get activityAddAgainCurrentDate;

  /// No description provided for @startOverToUpdate.
  ///
  /// In en, this message translates to:
  /// **'To start the edit process again, you can press the cross sign and start again.'**
  String get startOverToUpdate;

  /// No description provided for @beCarefulInactiveCurrency.
  ///
  /// In en, this message translates to:
  /// **'You should be careful when editing a currency that is inactive. If you make income, the foreign currency will be activated.'**
  String get beCarefulInactiveCurrency;

  /// No description provided for @editActivitiesWithSystemMessage.
  ///
  /// In en, this message translates to:
  /// **'While editing the activities containing the system message, you should not forget that the activity is a repeated or installment activity. You can also make a non-repetitive activity repetitive.'**
  String get editActivitiesWithSystemMessage;

  /// No description provided for @foreignExchangeSystem.
  ///
  /// In en, this message translates to:
  /// **'FOREİGN EXCHANGE SYSTEM'**
  String get foreignExchangeSystem;

  /// No description provided for @currencySelectionExplanation.
  ///
  /// In en, this message translates to:
  /// **'If you select the currency of an activity different from the system currency on the expense - income adding page, the system will perceive it as foreign currency.'**
  String get currencySelectionExplanation;

  /// No description provided for @foreignCurrencyFirstIncomeExplanation.
  ///
  /// In en, this message translates to:
  /// **'If you have never added foreign currency as income before, you should not add the first foreign currency as an expense. Otherwise, a foreign currency that does not exist has left the account. This logic is wrong.'**
  String get foreignCurrencyFirstIncomeExplanation;

  /// No description provided for @activeCurrencyExplanation.
  ///
  /// In en, this message translates to:
  /// **'If you add foreign currency as income, the system will calculate the amount at the current exchange rate every time you open the app, this is called the active currency. When you spend the currency, the currency will become inactive.'**
  String get activeCurrencyExplanation;

  /// No description provided for @inactiveCurrencyExplanation.
  ///
  /// In en, this message translates to:
  /// **'When you spend your foreign currency, the remaining amount of foreign currency you previously added will not be recalculated. This is called inactive currency.'**
  String get inactiveCurrencyExplanation;

  /// No description provided for @updateCurrencyTypeInstructions.
  ///
  /// In en, this message translates to:
  /// **'You should not edit the existing foreign currency and change the type to expense. From Add Income/Expenses page, you must add foreign currency whose type is expense.'**
  String get updateCurrencyTypeInstructions;

  /// No description provided for @currencyActivityCheckInstructions.
  ///
  /// In en, this message translates to:
  /// **'You can check whether the currency is active or inactive from the activity details.'**
  String get currencyActivityCheckInstructions;

  /// No description provided for @splitIncomeToExpenseExplanation.
  ///
  /// In en, this message translates to:
  /// **'If you spend part of the foreign currency amount, the system will divide the amount starting from the oldest. The active foreign currency equivalent to the amount of the expense will become inactive, while the rest will continue to be active.'**
  String get splitIncomeToExpenseExplanation;

  /// No description provided for @myAssetsPageExplanation.
  ///
  /// In en, this message translates to:
  /// **'You can follow your active currencies on the My Assets page. Foreign currencies you add from the My Assets page will also be active. Activities added here will not be reflected on the home page. This page exists to balance your assets. You should add your activities from the Add Income/Expenses page.'**
  String get myAssetsPageExplanation;

  /// No description provided for @currencyConversionExplanation.
  ///
  /// In en, this message translates to:
  /// **'This list includes some currencies. All you have to do is select the currency you want to convert and enter the amount.'**
  String get currencyConversionExplanation;

  /// No description provided for @currencyConversionDirection.
  ///
  /// In en, this message translates to:
  /// **'Indicates the direction of the currency conversion.'**
  String get currencyConversionDirection;

  /// No description provided for @changeCurrencyLocation.
  ///
  /// In en, this message translates to:
  /// **'You can change the conversion direction with this button.'**
  String get changeCurrencyLocation;

  /// No description provided for @clearCopyButton.
  ///
  /// In en, this message translates to:
  /// **'You can reset the amount with the delete button and copy the result with the copy button.'**
  String get clearCopyButton;

  /// No description provided for @oldExchangeRateCalculation.
  ///
  /// In en, this message translates to:
  /// **'If you want to calculate from the old exchange rate, all exchange rates recorded in the system will be displayed. Currently you cannot access a date that is not in the list.'**
  String get oldExchangeRateCalculation;

  /// No description provided for @instructions.
  ///
  /// In en, this message translates to:
  /// **'After entering the amount and interest, you have to choose the maturity period. You can see the results by pressing the Calculate button, and delete the values you entered with the Delete All button.'**
  String get instructions;

  /// No description provided for @maxAmount.
  ///
  /// In en, this message translates to:
  /// **'You can enter a maximum of 7-digit amount. You cannot enter maturities other than those in the maturity list.'**
  String get maxAmount;

  /// No description provided for @instructionsPercentage.
  ///
  /// In en, this message translates to:
  /// **'If you do not process the second number, you must enter a number and a percentage. It will give the percentage of the entered number.'**
  String get instructionsPercentage;

  /// No description provided for @secondNumberNote.
  ///
  /// In en, this message translates to:
  /// **'You must check the box to process the second number.'**
  String get secondNumberNote;

  /// No description provided for @twoNumberedTransactions.
  ///
  /// In en, this message translates to:
  /// **'In two-numbered transactions, you can perform the transactions written on the page.'**
  String get twoNumberedTransactions;

  /// No description provided for @calenderPage.
  ///
  /// In en, this message translates to:
  /// **'CALENDAR PAGE'**
  String get calenderPage;

  /// No description provided for @calenderPageDescription.
  ///
  /// In en, this message translates to:
  /// **'You can access the activities you added from this customized calendar.'**
  String get calenderPageDescription;

  /// No description provided for @changeMonthYear.
  ///
  /// In en, this message translates to:
  /// **'Here you can change the month and year by swiping left or right.'**
  String get changeMonthYear;

  /// No description provided for @backToCurrentMonth.
  ///
  /// In en, this message translates to:
  /// **'With this button, you can go back to the current month.'**
  String get backToCurrentMonth;

  /// No description provided for @startingDayOfMonth.
  ///
  /// In en, this message translates to:
  /// **'This button shows the starting day of the month. You can go to settings by long pressing to change it. (Example: If 15 is selected, the calendar will show activities until the 14th of the next month).'**
  String get startingDayOfMonth;

  /// No description provided for @dayButtons.
  ///
  /// In en, this message translates to:
  /// **'Days are buttons. Red or green indicates that your total activities for that day are negative or positive. When you click on any button, all activities for that day will appear.'**
  String get dayButtons;

  /// No description provided for @incomeNetAmountExpenses.
  ///
  /// In en, this message translates to:
  /// **'Your total income, net amount, and total expenses for the selected month are displayed.'**
  String get incomeNetAmountExpenses;

  /// No description provided for @statisticsPageHelp.
  ///
  /// In en, this message translates to:
  /// **'STATISTICS PAGE'**
  String get statisticsPageHelp;

  /// No description provided for @statisticsPageHelpDescription.
  ///
  /// In en, this message translates to:
  /// **'You can filter the activities and examine the distribution of activities according to categories.'**
  String get statisticsPageHelpDescription;

  /// No description provided for @infoBoxesForFiltering.
  ///
  /// In en, this message translates to:
  /// **'These boxes will give you information about filtering. Yellow colored ones are included in the filtering.'**
  String get infoBoxesForFiltering;

  /// No description provided for @filteringInstructions.
  ///
  /// In en, this message translates to:
  /// **'You can filter the activity type, date, saved activities and payment method from the lists in the Statistics Filtering.'**
  String get filteringInstructions;

  /// No description provided for @resetButtonForFiltering.
  ///
  /// In en, this message translates to:
  /// **'You can return the filtering to its default settings by pressing the reset button.'**
  String get resetButtonForFiltering;

  /// No description provided for @filteringResult.
  ///
  /// In en, this message translates to:
  /// **'As a result of filtering, the percentage and amount of the categories are shown. You can also see other details by clicking on it.'**
  String get filteringResult;

  /// No description provided for @pieChart.
  ///
  /// In en, this message translates to:
  /// **'You can follow the distribution of categories via the pie chart.'**
  String get pieChart;

  /// No description provided for @question1.
  ///
  /// In en, this message translates to:
  /// **'My records are gone what should I do?'**
  String get question1;

  /// No description provided for @answer1.
  ///
  /// In en, this message translates to:
  /// **'You can restore your data from Google Drive. But if you have not backed up your data, you cannot restore your data. If you think the problem is not caused by you, please contact us.'**
  String get answer1;

  /// No description provided for @question2.
  ///
  /// In en, this message translates to:
  /// **'I want to contact you'**
  String get question2;

  /// No description provided for @answer2.
  ///
  /// In en, this message translates to:
  /// **'You can contact us via our e-mail or Linkedin addresses. You can press the button to.'**
  String get answer2;

  /// No description provided for @question3.
  ///
  /// In en, this message translates to:
  /// **'Can I export my data to Excel format?'**
  String get question3;

  /// No description provided for @answer3.
  ///
  /// In en, this message translates to:
  /// **'Yes, after backing up your data to your Google Account, you can convert and view the .csv file as Excel.'**
  String get answer3;

  /// No description provided for @question4.
  ///
  /// In en, this message translates to:
  /// **'How does the foreign exchange system work, what does active and inactive currency mean?'**
  String get question4;

  /// No description provided for @answer4.
  ///
  /// In en, this message translates to:
  /// **'This topic is explained in detail on the help page. You can press the button to go.'**
  String get answer4;

  /// No description provided for @question5.
  ///
  /// In en, this message translates to:
  /// **'Some of the data I backed up has been deleted, is this a bug?'**
  String get question5;

  /// No description provided for @answer5.
  ///
  /// In en, this message translates to:
  /// **'No, this is not an error, our system requests Google Drive to delete old backups after a certain number of backups. You can store backups elsewhere if you wish.'**
  String get answer5;

  /// No description provided for @question6.
  ///
  /// In en, this message translates to:
  /// **'What happens when you change the starting day of the month?'**
  String get question6;

  /// No description provided for @answer6.
  ///
  /// In en, this message translates to:
  /// **'Depending on the day you choose, that will be the beginning of the month. For example: if you selected 15, the monthly data will be calculated until the 14th of the next month, and the display on the calendar and home page will change according to the selected day.'**
  String get answer6;

  /// No description provided for @question7.
  ///
  /// In en, this message translates to:
  /// **'What happens when the date format is changed?'**
  String get question7;

  /// No description provided for @answer7.
  ///
  /// In en, this message translates to:
  /// **'The date format you choose only changes the view. It has no impact on activities. You can choose the format you want.'**
  String get answer7;

  /// No description provided for @question8.
  ///
  /// In en, this message translates to:
  /// **'Can I add more than one card?'**
  String get question8;

  /// No description provided for @answer8.
  ///
  /// In en, this message translates to:
  /// **'No, you must add activities as if you had a single card. The option to add cards will come in subsequent updates.'**
  String get answer8;

  /// No description provided for @backupFailed.
  ///
  /// In en, this message translates to:
  /// **'Backup Failed'**
  String get backupFailed;

  /// No description provided for @backupFailedEnter.
  ///
  /// In en, this message translates to:
  /// **'Backup\nFailed'**
  String get backupFailedEnter;

  /// No description provided for @backupFailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Backup could not be done due to internet connection. Check the connection and log in again.'**
  String get backupFailedDescription;

  /// No description provided for @activeAccount.
  ///
  /// In en, this message translates to:
  /// **'Account:'**
  String get activeAccount;

  /// No description provided for @signInAndBackupWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in and Backup with Google (Recommended)'**
  String get signInAndBackupWithGoogle;

  /// No description provided for @turnOffBackupAndSignOutFromGoogle.
  ///
  /// In en, this message translates to:
  /// **'Turn Off Backup and Sign Out from Google.'**
  String get turnOffBackupAndSignOutFromGoogle;

  /// No description provided for @clickToCheck.
  ///
  /// In en, this message translates to:
  /// **'Tap to Check'**
  String get clickToCheck;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection found. Backup could not be done.'**
  String get noInternetConnection;

  /// No description provided for @okAnladim.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get okAnladim;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @care1.
  ///
  /// In en, this message translates to:
  /// **'Budget Wise is under maintenance'**
  String get care1;

  /// No description provided for @care2.
  ///
  /// In en, this message translates to:
  /// **'Thanks for waiting'**
  String get care2;

  /// No description provided for @care3.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get care3;

  /// No description provided for @update1.
  ///
  /// In en, this message translates to:
  /// **'Budget Wise updated!'**
  String get update1;

  /// No description provided for @update2.
  ///
  /// In en, this message translates to:
  /// **'Please update the application from the store'**
  String get update2;

  /// No description provided for @update3.
  ///
  /// In en, this message translates to:
  /// **'Tap to update'**
  String get update3;

  /// No description provided for @downloadedData.
  ///
  /// In en, this message translates to:
  /// **'Your data downloaded'**
  String get downloadedData;

  /// No description provided for @backupedData.
  ///
  /// In en, this message translates to:
  /// **'Your data is backed up'**
  String get backupedData;

  /// No description provided for @assetChart30Days.
  ///
  /// In en, this message translates to:
  /// **'30 Day Asset Chart'**
  String get assetChart30Days;

  /// No description provided for @yourHighestIncome.
  ///
  /// In en, this message translates to:
  /// **'Your Highest Income'**
  String get yourHighestIncome;

  /// No description provided for @deleteMyAccount.
  ///
  /// In en, this message translates to:
  /// **'DELETE MY ACCOUNT'**
  String get deleteMyAccount;

  /// No description provided for @allDataInYourEmailAccountWillBeDeleted.
  ///
  /// In en, this message translates to:
  /// **'All data in your email account will be deleted.'**
  String get allDataInYourEmailAccountWillBeDeleted;

  /// No description provided for @doYouConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you confirm? (You will be able to log in again with the same Email account.)'**
  String get doYouConfirm;

  /// No description provided for @deleteMyAccountSmall.
  ///
  /// In en, this message translates to:
  /// **'Delete My Account'**
  String get deleteMyAccountSmall;

  /// No description provided for @deleteMyAccountSmallSize.
  ///
  /// In en, this message translates to:
  /// **'135'**
  String get deleteMyAccountSmallSize;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get cancel;

  /// No description provided for @analysis.
  ///
  /// In en, this message translates to:
  /// **'ANALYSIS'**
  String get analysis;

  /// No description provided for @iAmYourBudgetWiseAssistant.
  ///
  /// In en, this message translates to:
  /// **'Hello, I am your BudgetWise Assistant!'**
  String get iAmYourBudgetWiseAssistant;

  /// No description provided for @lookAtYourMonthlyExpenses.
  ///
  /// In en, this message translates to:
  /// **'Let\'s look at your monthly expenses.'**
  String get lookAtYourMonthlyExpenses;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @sir.
  ///
  /// In en, this message translates to:
  /// **'Sir'**
  String get sir;

  /// No description provided for @spendingInPositiveBalance.
  ///
  /// In en, this message translates to:
  /// **'I see that your monthly Income and Expenses are in positive balance. '**
  String get spendingInPositiveBalance;

  /// No description provided for @keepGoingLikeThis.
  ///
  /// In en, this message translates to:
  /// **'Keep going like this '**
  String get keepGoingLikeThis;

  /// No description provided for @goodJobKeepGoingLikeThis.
  ///
  /// In en, this message translates to:
  /// **'Good job, keep going like this '**
  String get goodJobKeepGoingLikeThis;

  /// No description provided for @great.
  ///
  /// In en, this message translates to:
  /// **'Great! '**
  String get great;

  /// No description provided for @recommendThatYouSpendYourBudgetWisely.
  ///
  /// In en, this message translates to:
  /// **'We recommend that you spend your budget wisely '**
  String get recommendThatYouSpendYourBudgetWisely;

  /// No description provided for @youSpentThisMuchOfYourMonthlyIncome.
  ///
  /// In en, this message translates to:
  /// **'You spent this much of your Monthly Income : '**
  String get youSpentThisMuchOfYourMonthlyIncome;

  /// No description provided for @percentage.
  ///
  /// In en, this message translates to:
  /// **'%'**
  String get percentage;

  /// No description provided for @numberOfDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'Number of days left until the end of the month : '**
  String get numberOfDaysLeft;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get day;

  /// No description provided for @spendingThisMuchPerDayOnAverage.
  ///
  /// In en, this message translates to:
  /// **'You can reach the end of the month by spending this much per day on average : '**
  String get spendingThisMuchPerDayOnAverage;

  /// No description provided for @yourIncomeExpensesAreEqual.
  ///
  /// In en, this message translates to:
  /// **'Your monthly income and expenses are equal. '**
  String get yourIncomeExpensesAreEqual;

  /// No description provided for @fortunatelyYouAlreadyHaveMoneyInAssets.
  ///
  /// In en, this message translates to:
  /// **'Fortunately, you already have money in Assets. '**
  String get fortunatelyYouAlreadyHaveMoneyInAssets;

  /// No description provided for @spendingInNegativeBalance.
  ///
  /// In en, this message translates to:
  /// **'I see that your monthly income and expenses are unfortunately in negative balance. '**
  String get spendingInNegativeBalance;

  /// No description provided for @youDoNotHaveAnyAssetsEditYourAssets.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, you do not have any assets. You can edit your assets from My Assets page. '**
  String get youDoNotHaveAnyAssetsEditYourAssets;

  /// No description provided for @yourTotalMoneyOnTheMyAssetsPageIs.
  ///
  /// In en, this message translates to:
  /// **'Your total money on the My Assets page : '**
  String get yourTotalMoneyOnTheMyAssetsPageIs;

  /// No description provided for @lastShowDate.
  ///
  /// In en, this message translates to:
  /// **'Last Show date : '**
  String get lastShowDate;

  /// No description provided for @yourIncomeActivitiesForThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Your Income activities for this month'**
  String get yourIncomeActivitiesForThisMonth;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
