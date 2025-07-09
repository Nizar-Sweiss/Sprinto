import 'dart:convert';
import 'dart:developer';
import 'package:app/services/request_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';

class HttpService {
  HttpService._privateConstructor();
  static final HttpService _instance = HttpService._privateConstructor();
  static HttpService get instance => _instance;

  Future<String?> _getToken() async {
    final box = GetStorage();
    return  box.read('jwt_token'); // Make sure your token key is correct
  }

  // Add Authorization header if token is available
  Future<Map<String, String>> _getHeaders({bool authRequired = false}) async {
    final headers = {'Content-Type': 'application/json'};

    if (authRequired) {
      final token = await _getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      } else {
        print('⚠️ No JWT token found');
      }
    }
    return headers;
  }

  // GET request
  Future<http.Response> get(BuildContext? context, String endpoint, {bool authRequired = false}) async {
    Uri uri = Uri.parse(endpoint);
    log(uri.toString());

    final headers = await _getHeaders(authRequired: authRequired);

    var response = await http.get(uri, headers: headers).catchError((e) {
      if (context != null && context.mounted) {
        RequestHandler.errorRequest(context, message: e.toString());
      }
      log("catchError: ${e.toString()}");
      return http.Response(e.toString(), 500);
    });

    if (response.statusCode != 200) {
      log("statusCode: ${response.statusCode}");
      log("reasonPhrase: ${response.reasonPhrase}");
      log("body: ${response.body}");
    }
    return response;
  }

  // POST request
  Future<http.Response> post(BuildContext? context, String endpoint, dynamic body, {bool authRequired = false}) async {
    Uri uri = Uri.parse(endpoint);
    log(uri.toString());
    log(body.toString());

    final headers = await _getHeaders(authRequired: authRequired);

    var response = await http
        .post(uri, headers: headers, body: json.encode(body))
        .catchError((e) {
      if (context != null && context.mounted) {
        RequestHandler.errorRequest(context, message: e.toString());
      }
      log("catchError: ${e.toString()}");
      return http.Response(e.toString(), 500);
    });

    if (response.statusCode != 200) {
      log("statusCode: ${response.statusCode}");
      log("reasonPhrase: ${response.reasonPhrase}");
      log("body: ${response.body}");
    }
    return response;
  }

  // PUT request
  Future<http.Response> put(BuildContext? context, String endpoint, dynamic body, {bool authRequired = true}) async {
    Uri uri = Uri.parse(endpoint);
    log(uri.toString());
    print(json.encode(body));

    final headers = await _getHeaders(authRequired: authRequired);

    var response = await http
        .put(uri, headers: headers, body: json.encode(body))
        .catchError((e) {
      if (context != null && context.mounted) {
        RequestHandler.errorRequest(context, message: e.toString());
      }
      log("catchError: ${e.toString()}");
      return http.Response(e.toString(), 500);
    });

    if (response.statusCode != 200) {
      log("statusCode: ${response.statusCode}");
      log("reasonPhrase: ${response.reasonPhrase}");
      log("body: ${response.body}");
    }
    return response;
  }

  // DELETE request
  Future<http.Response> delete(BuildContext? context, String endpoint, dynamic body, {bool authRequired = true}) async {
    Uri uri = Uri.parse(endpoint);
    log(uri.toString());
    log(body.toString());

    final headers = await _getHeaders(authRequired: authRequired);

    var response = await http
        .delete(uri, headers: headers, body: json.encode(body))
        .catchError((e) {
      if (context != null && context.mounted) {
        RequestHandler.errorRequest(context, message: e.toString());
      }
      log("catchError: ${e.toString()}");
      return http.Response(e.toString(), 500);
    });

    if (response.statusCode != 200) {
      log("statusCode: ${response.statusCode}");
      log("reasonPhrase: ${response.reasonPhrase}");
      log("body: ${response.body}");
    }
    return response;
  }
}
