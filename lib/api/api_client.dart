import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/app_constants.dart';
import '../model/errorResponse.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;

  String? token = "";
  Map<String, String> _mainHeaders = {};

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {

    if (sharedPreferences.getString(AppConstants.token) == null) {
      token = "";
    } else {
      token = sharedPreferences.getString(AppConstants.token)!;
    }
    debugPrint('Token: $token');

    updateHeader(
      token,
    );
  }

  void updateHeader(String? token) {
    _mainHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      Http.Response response = await Http.get(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postBodyData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');
      if (sharedPreferences.getString(AppConstants.token) == null) {
        token = "";
      } else {
        token = sharedPreferences.getString(AppConstants.token)!;
      }

      Http.Response response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');
      Http.Response response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: body,
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  // Future<Response> postMultipartData(
  //     String uri, Map<String, String> body, List<MultipartBody> multipartBody,
  //     {Map<String, String>? headers}) async {
  //   try {
  //     debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
  //     debugPrint('====> API Body: $body');
  //     Http.MultipartRequest _request =
  //         Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
  //     _request.headers.addAll(headers ?? _mainHeaders);
  //     for (MultipartBody multipart in multipartBody) {
  //       if (Foundation.kIsWeb) {
  //         Uint8List _list = await multipart.file.readAsBytes();
  //         Http.MultipartFile _part = Http.MultipartFile(
  //           multipart.key,
  //           multipart.file.readAsBytes().asStream(),
  //           _list.length,
  //           filename: basename(multipart.file.path),
  //           contentType: MediaType('image', 'jpg'),
  //         );
  //         _request.files.add(_part);
  //       } else {
  //         File _file = File(multipart.file.path);
  //         _request.files.add(Http.MultipartFile(
  //           multipart.key,
  //           _file.readAsBytes().asStream(),
  //           _file.lengthSync(),
  //           filename: _file.path.split('/').last,
  //         ));
  //       }
  //     }
  //     _request.fields.addAll(body);
  //     Http.Response _response =
  //         await Http.Response.fromStream(await _request.send());
  //     return handleResponse(_response, uri);
  //   } catch (e) {
  //     return Response(statusCode: 1, statusText: noInternetMessage);
  //   }
  // }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');
      Http.Response response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      Http.Response response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {}
    Response response0 = Response(
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
    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      if (response0.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: errorResponse.errors![0].message);
      } else if (response0.body.toString().startsWith('{message')) {
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: response0.body['message']);
      }
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = const Response(statusCode: 0, statusText: noInternetMessage);
    }
    debugPrint(
        '====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    return response0;
  }
}

// class MultipartBody {
//   String key;
//   XFile file;
//
//   MultipartBody(this.key, this.file);
// }
