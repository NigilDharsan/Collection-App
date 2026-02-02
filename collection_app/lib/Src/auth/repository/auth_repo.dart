import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/data/provider/client_api.dart';
import '../model/account_model.dart';


class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> getUserProfile() async {
    try {
      return await apiClient.getData("https://yourapi.com/get-profile");
    } catch (e) {
      print("Error fetching user profile: $e");
      return null;
    }
  }

  Future<Response?> validateUser(String email) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*'
    };

    return await apiClient.getData("${AppConstants.configUrl}$email",
        headers: headers);
  }

  Future<Response?> login(
      {required String mobileNumber, required String password}) async {
    var body = {
      "username": mobileNumber,
      "password": password,
      "id_company": "1",
      "deviceID": "111"
    };

    return await apiClient.postLoginData(
      AppConstants.getEmpLoginUrl,
      body,
    );
  }

  Future<Response?> signupVerification(Map<String, String> body) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    return await apiClient.postData(AppConstants.customerSignup, body,
        headers: headers);
  }

  Future<void> saveUserNumberAndEmail(String number, String email) async {
    try {
      await sharedPreferences.setString(AppConstants.userEmail, email);
      await sharedPreferences.setString(AppConstants.userNumber, number);
    } catch (e) {
      rethrow;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.userNumber) ?? "";
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.userEmail) ?? "";
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.notification) ?? true;
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.userPassword);
    await sharedPreferences.remove(AppConstants.userCountryCode);
    return await sharedPreferences.remove(AppConstants.userNumber);
  }

  Future<bool?> saveRefreshToken(String token) async {
    print(token);
    return await sharedPreferences.setString(AppConstants.refreshToken, token);
  }

  Future<bool?> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.postUpdateHeader(token);
    apiClient.getUpdateHeader(token);

    return await sharedPreferences.setString(AppConstants.token, token);
  }

  static const String _keyUserModel = 'user_model';

  static Future<void> saveUserModel(AccountModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(userModel.toJson());
    await prefs.setString(_keyUserModel, jsonString);
  }

  static Future<AccountModel?> getUserModel() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_keyUserModel);

    if (jsonString != null) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return AccountModel.fromJson(jsonMap);
    }
    return null; // Return null if no user model is found
  }

  String getRefreshToken() {
    return sharedPreferences.getString(AppConstants.refreshToken) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  bool isSupplier() {
    return sharedPreferences.containsKey(AppConstants.isSupplier);
  }

  ///user address and language code should not be deleted
  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.clear();
    return true;
  }

  refreshToken() async {
    final loginModel = await AuthRepo.getUserModel();
    final prefs = await SharedPreferences.getInstance();

    final headers = {
      "Content-Type": "application/json",
    };
    return await apiClient.postData(
        AppConstants.employeeTokenRefresh,
        {
          "id_employee": loginModel?.employee?.idEmployee.toString() ?? "",
          "username": prefs.getString('username'),
          "password": prefs.getString('password'),
        },
        headers: headers);
  }
}

class SingleTon {
  static final SingleTon qwerty = SingleTon._internal();

  factory SingleTon() {
    return qwerty;
  }

  SingleTon._internal();

  String ImageData = "";
  String LoginType = "";
  bool isPhoneVerified = false;
  bool isEmailVerified = false;
  bool isEstablishPhoneVerified = false;
  bool isEstablishEmailVerified = false;
  bool isRecurring = false;
}
