import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_project/api/api_config.dart';
import 'package:my_project/api/auth_services.dart';
import 'package:my_project/repositories/book_repo.dart';
import 'package:my_project/repositories/borrow_repo.dart';
import 'package:my_project/repositories/member_repo.dart';
import 'package:my_project/utils/locator.dart';
import 'package:my_project/utils/share_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {
        HttpHeaders.acceptHeader: "application/json",
      },
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );
  late AuthRepo authRepo;
  late BookRepo bookRepo;
  late MemberRepo memberRepo;
  late BorrowRepo borrowRepo;
  VoidCallback? onUnauthorized;

  ApiClient() {
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          responseHeader: true,
          requestHeader: true,
          requestBody: true,
          request: true,
        ),
      );
    }
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options,
            RequestInterceptorHandler requestInterceptorHandler) async {
          final prefs = locator<SharedPrefs>();
          if (prefs.token != null) {
            options.headers['Authorization'] = 'Bearer ${prefs.token}';
          }
          return requestInterceptorHandler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          if (response.data is String) {
            final jsonResponse = jsonDecode(response.data);
            response.data = jsonResponse;
          }
          if (response.statusCode == 401 &&
              response.data['message'] == "Unauthenticated.") {
            try {
              final prefs = locator<SharedPrefs>();
              prefs.removeAll();
              onUnauthorized?.call();
            } catch (e) {
              log("error Logout", error: e);
            }
          } else {
            return handler.next(response);
          }
        },
        onError: (
          DioError error,
          ErrorInterceptorHandler handler,
        ) async {
          log('DioError, $error');
          return handler.next(error);
        },
      ),
    );

    authRepo = AuthRepo(_dio);
    bookRepo = BookRepo(_dio);
    memberRepo = MemberRepo(_dio);
    borrowRepo = BorrowRepo(_dio);
  }
}
