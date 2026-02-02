import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Src/auth/controller/auth_controller.dart';
import '../../app_constants.dart';
import '../../config.dart';
import '../../core/common_model/errors_model.dart';
import '../../core/helper/error_handler.dart';
import '../../core/helper/help_me.dart';
import '../../widgets/custom_snackbar.dart';

class ApiClient extends GetxService {
  final String? appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;

  String? token;
  late Map<String, String> getmainHeaders;
  late Map<String, String> mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token);

    postUpdateHeader(token);
    getUpdateHeader(token);
  }

  void getUpdateHeader(String? token) {
    getmainHeaders = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Token $token'
    };
  }

  void postUpdateHeader(String? token) {
    mainHeaders = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Token $token'
    };
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      print(Uri.parse(appBaseUrl! + uri));
      print(headers ?? getmainHeaders);

      http.Response response = await http
          .get(
            Uri.parse(appBaseUrl! + uri),
            headers: headers ?? getmainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      // printLog("-----getData response: ${response.body}");
      if (response.statusCode == 401 &&
          Get.find<AuthController>().isLoggedIn()) {}
      return response.body == ""
          ? handleResponse(response, uri)
          : handleLanguageResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    print(Uri.parse(appBaseUrl! + uri));
    print("Header :: ${headers}");
    print("Request ::${jsonEncode(body)}");

    http.Response response = await http
        .post(
          Uri.parse(appBaseUrl! + uri),
          body: jsonEncode(body),
          headers: headers ?? mainHeaders,
        )
        .timeout(Duration(seconds: timeoutInSeconds));
    try {
      if (response.statusCode == 401 &&
          Get.find<AuthController>().isLoggedIn()) {}
      printLog("RESPONSE BODY ${response.body}");
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postLoginData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    print(Uri.parse(Config.baseUrl + uri));
    print(jsonEncode(body));
    print(headers);

    http.Response response = await http
        .post(
          Uri.parse(Config.baseUrl + uri),
          body: body,
          headers: headers ?? null,
        )
        .timeout(Duration(seconds: timeoutInSeconds));
    try {
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartDataConversation(
    String? uri,
    File file,
    String receiverId,
  ) async {
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(appBaseUrl! + uri!));
    // request.headers.addAll(_mainHeaders);
    request.fields['receiver_id'] = receiverId;
    var stream = http.ByteStream(file.openRead())..cast();
    var length = await file.length();
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    final data = await request.send();
    http.Response response = await http.Response.fromStream(data);
    return handleResponse(response, uri);
  }

  Future<Response> postMultipartData(String? uri, Map<String, String> body,
      List<MultipartBody>? multipartBody, File? otherFile,
      {Map<String, String>? headers}) async {
    print(Uri.parse(appBaseUrl! + uri!));
    print(jsonEncode(body));
    print(headers);
    try {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(appBaseUrl! + uri!));
      // request.headers.addAll(headers ?? _mainHeaders);
      if (otherFile != null) {
        Uint8List list = await otherFile.readAsBytes();
        var part = http.MultipartFile(
            'submitted_file', otherFile.readAsBytes().asStream(), list.length,
            filename: basename(otherFile.path));
        request.files.add(part);
      }
      if (multipartBody != null) {
        for (MultipartBody multipart in multipartBody) {
          File file = File(multipart.file.path);
          request.files.add(http.MultipartFile(
            multipart.key!,
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: file.path.split('/').last,
          ));
        }
      }
      request.fields.addAll(body);
      http.Response response =
          await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response, String? uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      //
    }
    String decodedResponse = utf8.decode(response.bodyBytes);
    Response response0 = Response(
      bodyBytes: Stream.fromIterable([response.bodyBytes]),
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    try {
      if (response0.statusCode != 200 &&
          response0.body != null &&
          response0.body is! String) {
        if (response0.body.toString().startsWith('{response_code:')) {
          ErrorsModel errorResponse = ErrorsModel.fromJson(response0.body);
          response0 = Response(
              statusCode: response0.statusCode,
              body: response0.body,
              statusText: errorResponse.responseCode);
        } else if (response0.body.toString().startsWith('{message')) {
          response0 = Response(
              statusCode: response0.statusCode,
              body: response0.body,
              statusText: response0.body['message']);
        }
      } else if (response0.statusCode != 200 && response0.body == null) {
        response0 = Response(statusCode: 0, statusText: noInternetMessage);
      }
    } catch (err) {
      String errorMessage = ErrorHandler.handleError(err);
      // Do something with the error message (e.g., display in UI, log it, etc.)
      print('Error: $errorMessage');
    }

    if (foundation.kDebugMode) {
      debugPrint(
          '====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    }

    if (response0.statusCode != 200 && response0.statusCode != 201) {
      String errorMessage = ErrorHandler.handleError(response0.body);
      print(errorMessage);
      if (response0.statusCode == 500) {
        var tokenExpiredHeader = response.headers['token-expired'];
        bool tokenExpired = tokenExpiredHeader != null &&
            tokenExpiredHeader.toLowerCase() == 'true';
        if (tokenExpired) {
          print("Token has expired");
        } else {
          if (errorMessage == 'UNREGISTERED') {
            customSnackBar('User not registered. Sign up now', isError: true);
          } else if (errorMessage == 'DISABLED') {
            customSnackBar('Account Disabled', isError: true);
          } else if (errorMessage == 'INVALIDAPP') {
            customSnackBar('Please use Web Application to login',
                isError: true);
          } else {
            customSnackBar(errorMessage, isError: true);
          }
        }
      } else {
        customSnackBar(errorMessage, isError: true);
      }
    }
    return response0;
  }

  Response handleLanguageResponse(http.Response response, String? uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      //
    }
    String decodedResponse = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(decodedResponse);
    Response response0 = Response(
      bodyBytes: Stream.fromIterable([response.bodyBytes]),
      body: jsonData, // ?? response.body,
      bodyString: decodedResponse, // ?? response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    try {
      if (response0.statusCode != 200 &&
          response0.body != null &&
          response0.body is! String) {
        if (response0.body.toString().startsWith('{response_code:')) {
          ErrorsModel errorResponse = ErrorsModel.fromJson(response0.body);
          response0 = Response(
              statusCode: response0.statusCode,
              body: response0.body,
              statusText: errorResponse.responseCode);
        } else if (response0.body.toString().startsWith('{message')) {
          response0 = Response(
              statusCode: response0.statusCode,
              body: response0.body,
              statusText: response0.body['message']);
        }
      } else if (response0.statusCode != 200 && response0.body == null) {
        response0 = Response(statusCode: 0, statusText: noInternetMessage);
      }
    } catch (err) {
      String errorMessage = ErrorHandler.handleError(err);
      // Do something with the error message (e.g., display in UI, log it, etc.)
      print('Error: $errorMessage');
    }
    if (foundation.kDebugMode) {
      debugPrint(
          '====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    }
    if (response0.statusCode != 200 && response0.statusCode != 201) {
      String errorMessage = ErrorHandler.handleError(response0.body);
      print(errorMessage);
      if (response0.statusCode == 500) {
        var tokenExpiredHeader = response.headers['token-expired'];
        bool tokenExpired = tokenExpiredHeader != null &&
            tokenExpiredHeader.toLowerCase() == 'true';
        if (tokenExpired) {
          print("Token has expired");
        } else {
          if (errorMessage == 'UNREGISTERED') {
            customSnackBar('User not registered. Sign up now', isError: true);
          } else if (errorMessage == 'DISABLED') {
            customSnackBar('Account Disabled', isError: true);
          } else if (errorMessage == 'INVALIDAPP') {
            customSnackBar('Please use Web Application to login',
                isError: true);
          } else {
            customSnackBar(errorMessage, isError: true);
          }
        }
      } else {
        customSnackBar(errorMessage, isError: true);
      }
    }
    return response0;
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    print(Uri.parse(appBaseUrl! + uri));
    print("Header :: ${headers}");
    print("Request ::${jsonEncode(body)}");

    try {
      http.Response response = await http
          .put(
            Uri.parse(appBaseUrl! + uri),
            body: jsonEncode(body),
            headers: headers ?? mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));

      if (response.statusCode == 401 &&
          Get.find<AuthController>().isLoggedIn()) {
        // Handle unauthorized if needed
      }
      printLog("PUT RESPONSE BODY ${response.body}");
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    print(Uri.parse(appBaseUrl! + uri));
    print("Header :: ${headers}");

    try {
      http.Response response = await http
          .delete(
            Uri.parse(appBaseUrl! + uri),
            headers: headers ?? mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));

      if (response.statusCode == 204) {
        // Return a successful, empty response to indicate proper delete
        return Response(
          statusCode: 204,
          statusText: 'No Content',
          body: null,
          bodyString: '',
          headers: response.headers,
          request: Request(
            headers: response.request!.headers,
            method: response.request!.method,
            url: response.request!.url,
          ),
        );
      }

      if (response.statusCode == 401 &&
          Get.find<AuthController>().isLoggedIn()) {
        // Handle unauthorized if needed
      }
      printLog("DELETE RESPONSE BODY ${response.body}");
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
}

class MultipartBody {
  String? key;
  XFile file;

  MultipartBody(this.key, this.file);
}
