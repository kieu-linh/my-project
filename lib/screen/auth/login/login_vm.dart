import 'package:dio/dio.dart';
import 'package:my_project/base/base_view_model.dart';
import 'package:my_project/router/app_router.dart';
import 'package:my_project/utils/messages.dart';
import 'package:flutter/material.dart';

class LoginVM extends BaseViewModel {
  @override
  void onInit() {}
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  String? email, password;

  VoidCallback? onLoginSuccess;

  void visiblePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoading();
      try {
        // Mock login - replace with actual API call
        await Future.delayed(const Duration(seconds: 1));

        // Simulate success
        prefs.token = 'mock_token';
        hideLoading();
        showNotification('Login successful');
        onLoginSuccess?.call();
      } catch (e) {
        hideLoading();
        if (e is DioError && e.response?.statusCode == 401) {
          showError('Invalid credentials');
        } else {
          showError(Messages.serverError);
        }
      }
    }
  }
}
