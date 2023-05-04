// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sterling/repository/APIBase/api_response.dart';

import 'package:sterling/repository/APIBase/api_url.dart';

class ApiFunction {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  //base function for all api function this function return Future of API Response
  // static Dio getDio() {
  //   Dio dio = Dio(BaseOptions(
  //     baseUrl: ApiUrl.apiBaseUrl,
  //   ));
  //   /*..interceptors.add(LogInterceptor(
  //       request: true,
  //       responseBody: true,
  //       requestHeader: true,
  //       responseHeader: true,
  //     ))
  //     ..interceptors
  //         .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
  //       return options;
  //     }, onResponse: (Response response) {
  //       if (response?.statusCode == 401) {
  //         navigateToLoginScreen();
  //       } else if (response?.statusCode == 423) {
  //         navigateToSubscriptionScreen();
  //       }
  //       return response; // continue
  //     }, onError: (DioError e) {
  //       if (e?.response?.statusCode == 401) {
  //         navigateToLoginScreen();
  //       } else if (e?.response?.statusCode == 423) {
  //         navigateToSubscriptionScreen();
  //       }
  //       return e;
  //     }))*/

  //   return dio;
  // }

  ApiFunction(this.ref) {
    dio = Dio();
    dio.options.baseUrl = ApiUrl.apiBaseUrl;
    dio.options.sendTimeout = 30000;
    dio.options.connectTimeout = 30000;
    dio.options.receiveTimeout = 30000;

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  ///
  /// VARIABLES
  ///
  late final ProviderRef ref;
  late final Dio dio;

  static Future<APIResponse> baseFunction(ResponseCallback callback) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Response resp = await callback();
        if (resp.statusCode == 200) {
          return APIResponse(
              success: true, data: resp.data, message: "Succesfull");
        } else {
          return APIResponse(
            success: false,
            data: resp.data,
            message: resp.data['title'] ?? "No Message",
          );
        }
      } else {
        return APIResponse(message: "Something went wrong", success: false);
      }
    } on SocketException {
      return APIResponse(
          message: "Check your internet connection", success: false);
      // ignore: nullable_type_in_catch_clause
    } on DioError catch (error) {
      return APIResponse(
          message: (error.response?.data ?? {})['message'] ?? error.message,
          data: (error.response?.data ?? {})['data'],
          success: false);
    } catch (error) {
      return APIResponse(message: "Something went wrong", success: false);
    }
  }

  Future<APIResponse> get(String url,
      {required Map<String, dynamic> headers,
      required Map<String, dynamic> query}) async {
    return baseFunction(() async {
      //final dio = getDio();
      final response = await dio.get(url, queryParameters: query);
      return response;
    });
  }

  // function which return post request
  Future<APIResponse> post(String url,
      {Map<String, dynamic>? headers, required dynamic body}) async {
    return baseFunction(() async {
      // final dio = getDio();
      final response = await dio.post(url,
          data: body,
          options: Options(headers: {
            'accept': 'text/plain',
            'Content-Type': 'application/json'
          }));
      return response;
    });
  }

  // function which return put request
  Future<APIResponse> put(String url,
      {required Map<String, dynamic> headers,
      required Map<String, dynamic> body}) async {
    return baseFunction(() async {
      // final dio = getDio();
      final response = await dio.put(url, data: body);
      return response;
    });
  }

  //  function which return delete request
  Future<APIResponse> delete(String url,
      {required Map<String, dynamic> headers,
      required Map<String, dynamic> body}) async {
    return baseFunction(() async {
      //  final dio = getDio();
      final response = await dio.delete(url, data: body);
      return response;
    });
  }

  // make function which return patch request
  Future<APIResponse> patch(String url,
      {required Map<String, dynamic> headers,
      required Map<String, dynamic> body}) async {
    return baseFunction(() async {
      //   final dio = getDio();
      final response = await dio.patch(url, data: body);
      return response;
    });
  }
}

typedef ResponseCallback = Future<Response> Function();
