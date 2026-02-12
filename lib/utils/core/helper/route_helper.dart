import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Src/Billing/BillingDetails.dart';
import '../../../Src/CollectionReports/Chit_Collection_Summary_Report.dart';
import '../../../Src/CollectionReports/Credit_Collection_Summary_Report.dart';
import '../../../Src/CustomerJoin/Customer_Join_Screen.dart';
import '../../../Src/Dashboard/Dashboard_Screen/Collection_Dashboard.dart';
import '../../../Src/Dashboard/Dashboard_Screen/Collection_Dashboard_Details.dart';
import '../../../Src/Dashboard/Dashboard_Screen/Pending_Chit_Due_Details.dart';
import '../../../Src/Dashboard/Dashboard_Screen/Pending_Credits_Details.dart';
import '../../../Src/Dashboard/Dashboard_Screen/Pending_Credits_Payment.dart';
import '../../../Src/SchemeJoin/Scheme_Payment.dart';
import '../../../Src/auth/signIn/LoginScreen.dart';


class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String signIn = '/onboardscreen';
  static const String language = '/language';
  static const String main = '/main';
  static const String signUp = '/sign-up';
  static const String signUpEstablish = '/sign-up-establish';
  static const String addLocation = '/add-location';
  static const String onBoardScreen = '/onboard-screen';
  static const String otpVerifyScreen = '/otpVerifyScreen';
  static const String myorderScreen = '/myOrderScreen';
  static const String orderdetailScreen = '/orderDetailScreen';
  static const String salesEstimateScreen = '/sales_estimateScreen';
  static const String estimateDetailsScreen = '/sales_detailsScreen';
  static const String salesDetailsScreen = '/estimate_detailsScreen';

  static const String billingDetailsScreen = '/billing_detailsScreen';

  static const String neworderScreen = '/newOrderScreen';
  static const String tagsearchscreen = '/tagsearchscreen';
  static const String estimatescreen = '/estimatecreen';
  static const String scanscreen = '/scancreen';
  static const String estimatedetails1screen = '/estimatedetails1screen';
  static const String estimatedetails2screen = '/estimatedetails2screen';
  static const String newscreen = '/newscreen';
  static const String oldscreen = '/oldscreen';
  static const String stonedetailsscreen = '/stonescreen';

  static const String homeScreen = '/homeScreen';
  static const String cashFlowScreen = '/cashFlowScreen';
  static const String approvalScreen = '/approveScreen';
  static const String stockScreen = '/stockScreen';
  static const String bannerAddScreen = '/bannerAddScreen';
  static const String bannerListScreen = '/bannerListScreen';
  static const String statusAddScreen = '/statusAddScreen';

  static const String ratesList = '/ratesList';
  static const String ratesAdd = '/ratesAdd';

  static const String areaWisePendingCreditDetails =
      '/area-wise-credits-details';
  static const String areaWisePendingChitDueDetails =
      '/area-wise-chit-dues-details';
  static const String collectionDashboard = '/collectionDashboard';
  static const String collectionDashboardDetails =
      '/collectionDashboardDetails';
  static const String customerCreate = '/customerCreate';
  static const String createSchemePayment = '/createschemePayment';
  static const String creditCollectionReport = '/credit-collection-report';
  static const String chitCollectionReport = '/chit-collection-report';

  static const String pendingCreditPayment = '/pendingCreditPayment';

  static String getInitialRoute() => initial;

  static String getSplashRoute() => splash;

  static String getLanguageRoute(String page) => '$language?page=$page';

  static String getMainRoute(String page) => '$main?page=$page';

  static String getSignInRoute() => onBoardScreen;

  static String getOtpVerifyRoute() => otpVerifyScreen;

  static String getBillCreateScreen() => billingDetailsScreen;

  // static String getDashBoardRoute() => dashboardscreen;

  static String getMyOrderScreen() => myorderScreen;

  static String getOrderDetailsScreen() => orderdetailScreen;

  static String getNewOrderScreen() => neworderScreen;

  static String getTagSearchScreen() => tagsearchscreen;

  static String getEstimateScreen() => estimatescreen;

  static String getScanScreen() => scanscreen;

  static String getEstimatedetails1Screen() => estimatedetails1screen;

  static String getNewScreen() => newscreen;

  static String getOld2Screen() => oldscreen;

  static String getStoneScreen() => stonedetailsscreen;

  static String getDashBoardRoute() => homeScreen;
  static String getCollectionHomeRoute() => collectionDashboard;
  static String getCollectionHomeDetailsRoute() => collectionDashboardDetails;
  static String getCashFlowInwards() => cashFlowScreen;

  static String getMyApprovalPage() => approvalScreen;
  static String getSalesEstimatePage() => salesEstimateScreen;
  static String getSalesDetailsPage() => salesDetailsScreen;
  static String getEstimateDetailsPage() => estimateDetailsScreen;

  static String getJewelleryStock() => stockScreen;

  static String getBannerAdd() => bannerAddScreen;
  static String getBannerList() => bannerListScreen;
  static String getStatusAdd() => statusAddScreen;

  static String getRatesList() => ratesList;
  static String getAddList() => ratesAdd;
  static String getPendingCreditPayment() => pendingCreditPayment;

  static String getAddLocation(int id, int accountId) =>
      '$addLocation?userId=$id&accountId=$accountId';

  static List<GetPage> routes = [
    GetPage(name: onBoardScreen, page: () => getRoute(const LoginScreen())),
    // GetPage(name: dashboardscreen, page: () => const dashboardScreen()),
    GetPage(
        name: pendingCreditPayment, page: () => const PendingCreditsPayment()),

    GetPage(name: billingDetailsScreen, page: () => BillingDetailsScreen()),

    GetPage(
        name: areaWisePendingCreditDetails,
        page: () => PendingCreditsDetails()),
    GetPage(
        name: areaWisePendingChitDueDetails,
        page: () => PendingChitDueDetails()),
    GetPage(name: collectionDashboard, page: () => CollectionDashboard()),
    GetPage(
        name: collectionDashboardDetails,
        page: () => CollectionDashboardDetails()),
    GetPage(name: customerCreate, page: () => CustomerJoinScreen()),
    GetPage(name: createSchemePayment, page: () => SchemePayment()),
    GetPage(
        name: creditCollectionReport,
        page: () => CreditCollectionSummaryReport()),
    GetPage(
        name: chitCollectionReport, page: () => ChitCollectionSummaryReport()),

  ];

  static getRoute(Widget navigateTo) {
    double minimumVersion = 1;

  }
}
