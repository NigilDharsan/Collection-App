class AppConstants {
  static const String appName = 'Hello Taxi';

  static const String configUrl = 'configs';
  static const String onBoards = 'on-boards';
  static const String socialLoginUrl = 'social-login';
  static const String getEmpLoginUrl = 'employee/emp_login/';
  static const String employeeTokenRefresh =
      'customersettings/employee_token_refresh/';
  static const String getDashboardUrl = 'dashboard/admin_app_dashboard/';
  static const String getCustomerUrl = 'customersettings/customer_approval/';
  static const String activeDesignProduct = 'catalogmasters/design_mapping/';
  static const String activeProduct =
      'catalogmasters/admin_active_all_product/';

  static const String oldItemTypeUrl = 'retailmaster/old_metal_item/?active';

  static String tagDetails(String tagCode, int branchId) =>
      'estimation/search_tag?tag_code=$tagCode&id_branch=$branchId';
  static const String getNewOrderListUrl = 'orders/open_orders/list/';
  static const String getOrderStatusListByIdUrl =
      'orders/in_progress_orders/?status=';
  static const String getOrderAssignUrl = 'orders/job_order/create/';
  static const String getMobileNUmberSearchUrl =
      'customersettings/customer_autocomplete/';
  static String customerDetailsSummaryUrl = "reports/search_customer/";

  static String customerFeedbackUrl =
      "customersettings/customers_feedbacks/list/?page=1";

  static String goldRateUrl = "retailmaster/mob_app_rates_list/";
  static const String getEstimateCreatUrl = "estimation/create/";
  static const String getApprovePendingHistoryUrl =
      "estimation/app/pending_history/?page=1";
  static const String getApprovedRectDataUrl =
      "estimation/app/pending_history/?page=1";

  static const String getEstimateListUrl =
      'billing/estimation_sales/app/?page=1';
  static const String getSalesDetailsListUrl = 'billing/bill_details/';
  static const String getEstimateDetailsListUrl =
      'estimation/estimation_details/';
  static const String getTodaySalesDetailsUrl =
      'retail_dashboard/metal_wise_sale_detail/app/';
  static const String getTodayPurchaseDetailsUrl =
      "retail_dashboard/metal_wise_purchase_detail/app/";
  static const String getPurchaseDetailsUrl =
      'retail_dashboard/metal_wise_purchase/app/';

  static const String getEstimatePdf = "estimation/print/";
  static const String getStockListUrl = "retail_dashboard/current_stock/app/";
  static const String getTodaySalesUpdateUrl =
      "retail_dashboard/metal_wise_sale/app/";
  static const String getPurchaseUpdateUrl =
      "retail_dashboard/metal_wise_purchase/app/";

  static const String getCashFlowUrl =
      "retail_dashboard/cash_inward_outward/app/";
  static const String getCashFlowInwardUrl =
      'retail_dashboard/cash_inward_detail/app/';
  static const String getCashFlowOutwardUrl =
      'retail_dashboard/cash_outward_detail/app/';

  static const String getPercentageEstimationUrl =
      "retail_dashboard/estimation/app/";

  static const String customerSignup = 'customersettings/customer_signup/';
  static const String dashboardSettingsUrl = 'employee/dashboard_settings/app/';

  static const String getOrderUpdatenUrl = 'orders/order/job_orders/update/';
  static const String getSupplierUrl = 'retailmaster/supplier/?active';
  static const String getEmployeeListUrl = 'employee/active_employee/';

  static const String getBranchListUrl = 'retailmaster/active_all_branch/';
  static const String getAreaListUrl = 'retailmaster/area/?is_active';
  static const String getCategoryListUrl = 'catalogmasters/category/?status';
  static const String getMetalListUrl = 'catalogmasters/metal/?status';
  static const String getProductListUrl =
      'catalogmasters/admin_active_product/';
  static const String getAccountHeadListUrl =
      'retailmaster/account_head/?active';

  static const String billingPdfUrl = 'billing/pdf/';

  static const String getTagSearchUrl = 'inventory/tag/admin_app/search/';
  static const String getTagImageUpdateUrl =
      'inventory/tag/admin_app/image_update/';

  static const String getBannerUpdateUrl = 'retailmaster/banner/';
  static const String getBannerListUrl = 'retailmaster/banner_list/app/';
  static const String getBannerEdittUrl = 'retailmaster/banner/<int:pk>/';
  static const String getBannerDeleteUrl = 'retailmaster/banner/<int:pk>/';
  static const String getBannerDashUrl = 'retailmaster/banners/?status';

  static const String getStatusListUrl = 'retailmaster/daily_status/app/';
  static const String getStatusAddUrl = 'retailmaster/daily_status/';
  static const String getStatusEditUrl = 'retailmaster/daily_status/<int:pk>/';
  static const String getStatusDeleteUrl =
      'retailmaster/daily_status/<int:pk>/';

  static const String getRatesList = 'retailmaster/metal_rates/app/';
  static const String getRatesAddUrl = 'retailmaster/metal_rates/';
  static const String getRatesEditUrl = 'retailmaster/metal_rates/<int:pk>/';
  static const String getRatesDeleteUrl = 'retailmaster/metal_rates/<int:pk>/';

  static const String getEstimationDashListUrl = 'admin_app/est_list/?page=1';

  // static const String getEstimateUpdateList = 'estimation/est_details/';
  static const String getEstimateUpdateList = 'estimation/est_app_details/';

  static const String getEstimateUpdateEditUrl = 'estimation/app_update/';
  static const String getIssueReceiptCreate = 'billing/issue_receipt/create/';
  static const String getIssueReceiptListUrl =
      'admin_app/issue_receipt_list/?page=1';
  static const String getIssueReceiptCancelUrl =
      'billing/issue_receipt/cancel/';

  //reports
  static const String getSchemeWiseReport = 'reports/scheme_wise_opening/app/';
  static const String getSchemeAbstractReport = 'reports/scheme_abstract/app/';
  static const String getCashAbstractReport = 'reports/cash_abstract_report/';
  static const String getDailyAbstractReport =
      'reports/category_wise_abstract_report/';
  static const String getAreaWiseSalesReport =
      'reports/area_wise_sales_report/app/';
  static String areaWiseCollectionReportUrl =
      "reports/area_wise_collection_pending/";

  // fact sheet
  static const String getFactSheetListUrl = 'estimation/non_converted_list/';
  static const String getFactSheetEditUrl =
      'estimation/non_converted_estimation/<int:pk>/';
  static const String factSheetSaveUrl =
      'estimation/estimation_fact_sheet_update/';

  //category purity rate
  static const String getCategoryPurityListUrl =
      "catalogmasters/category_purity_rate/app/";
  static const String getCategoryPurityAddUrl =
      "catalogmasters/category_purity_rate/";
  static const String getCategoryDropdownUrl =
      "catalogmasters/category/app/?status";
  static const String getPurityDropdownUrl =
      "catalogmasters/purity/app/?status ";
  static const String getStoneUrl = 'catalogmasters/stone/?status';
  static const String getQualityUrl = 'catalogmasters/quality_code/?status';
  static const String getUOMUrl = 'retailmaster/uom/?active';

  static const String getBagListUrl = "retailmaster/lot_bag/?status";

  //dashboard stock pages
  static String getStockDetails(int metal) =>
      'retail_dashboard/current_stock/app/?metal=$metal&type=3';
  static String getStockMetalList(int group_by) =>
      'retail_dashboard/current_stock/app/?type=2&group_by=$group_by';

  //BIllings
  static String getEstDetails = 'estimation/est_details/';
  static String getPaymentMode = 'retailmaster/active_paymentmode/';
  static String getActiveBank = 'retailmaster/active_bank/?active';
  static String getActivePayDevice = 'retailmaster/active_pay_device/?active';
  static String getBillingCreate = 'billing/create/';
  static String getBillingList = 'admin_app/invoice_list/';

  static String getBillingCalculateItemDetails =
      'estimation/calculate_item_details/';
  static String getEstimateCalculateItemDetails =
      'estimation/calculate_custom_item_details/';

  // collection app
  static const String getCollectionDashboardUrl =
      'admin_app/collection_app_dashbaord/';
  static const String getAreaWisePendingCredits =
      'employee/area_wise_pending_credits/';
  static const String getAreaWiseChitDues = 'employee/area_wise_chit_dues/';
  static const String getAreaWisePendingCreditsDetails =
      'employee/area_wise_pending_credits/';
  static const String getAreaWisePendingChitDueDetails =
      'employee/area_wise_chit_dues/?page=1';
  static String getCreditCollectionCreate = 'billing/issue_receipt/create/';
  static String getSchemeJoinCreate = 'managescheme/scheme_account/';
  static String getCustomerAccounts = 'managescheme/customer_account/';
  static String getSchemePayment = 'payment/scheme_payment/';
  static String getSchemeDrop = 'scheme/customer_multi_scheme_list/';
  static String getCountry = 'retailmaster/country/?active';
  static String getState = 'retailmaster/state/?active';
  static String getCity = 'retailmaster/city/?active';
  static String getActiveAreas = 'employee/assigned_areas';
  static String getCustomerCreate = 'customersettings/customer/app/';
  static String getCustomerCreditDueList = 'employee/customer_credit_due_list/';
  static String getCollectionSummary = 'employee/collections_summary/';
  static String getCreditCollectionReport =
      'employee/credit_collection_report/?page=1';
  static String getChitCollectionReport =
      'employee/chit_collection_report/?page=1';
  static String getPaymentReceipt = 'payment/receipt/';
  static String getModeWiseSummary = 'employee/collection_amount_summary/';
  static String getHandoverCollection = 'employee/handover_collection/';

  // customer walkin
  static String createCustomerWalkin = 'customersettings/customers_visits/';
  static String getVisitPurposeDrop = 'retailmaster/visit_purposes/?active';
  static String getCustomerWalkinList = 'customersettings/customers_visits/';

  static const String isSupplier = 'is_supplier';
  static const String notificationChannel = 'channel_type';
  static const String theme = 'lms_theme';
  static const String token = 'lms_token';
  static const String refreshToken = 'refresh_token';
  static const String countryCode = 'lms_country_code';
  static const String languageCode = 'lms_language_code';
  static const String languagename = 'lms_language_name';
  static const String userPassword = 'lms_user_password';
  static const String userNumber = 'lms_user_number';
  static const String userEmail = 'lms_user_email';
  static const String userCountryCode = 'lms_user_country_code';
  static const String notification = 'lms_notification';
  static const String isOnBoardScreen = 'lms_on_board_seen';
  static const String isTapNotification = 'tap_on_notification';
  static const String topic = 'customer';
  static const String localizationKey = 'X-localization';
  static const String subscriptionUrl = '/api/v1/customer/config/pages';
}
