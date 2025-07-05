import 'dart:convert';
import 'dart:developer';
import 'package:app/services/request_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import 'api_service.dart';

class HttpService {

  HttpService._privateConstructor();
  static final HttpService _instance = HttpService._privateConstructor();
  static HttpService get instance => _instance;

  final String userToken = AppConfig.userToken;

  Future<http.Response> get(BuildContext? context, String endpoint) async {
    Uri uri = Uri.parse(endpoint);
    log(uri.toString());
    var response = await http.get(uri).catchError((e) {
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

  Future<http.Response> post(
    BuildContext? context,
    String endpoint,
    dynamic body,
  ) async {
    Uri uri = Uri.parse(endpoint);
    log(uri.toString());
    log(body.toString());
    var response = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body),
        )
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

  Future<http.Response> put(
    BuildContext? context,
    String endpoint,
    dynamic body,
  ) async {
    Uri uri = Uri.parse(endpoint);
    log(uri.toString());
    // log(body.toString());
    print(json.encode(body));
    var response = await http
        .put(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': userToken,
          },
          body: json.encode(body),
        )
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

  Future<http.Response> delete(
    BuildContext? context,
    String endpoint,
    dynamic body,
  ) async {
    Uri uri = Uri.parse(endpoint);
    log(uri.toString());
    log(body.toString());
    var response = await http
        .delete(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': userToken,
          },
          body: json.encode(body),
        )
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
