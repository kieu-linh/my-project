import 'package:dio/dio.dart';
import 'package:my_project/base/base_view_model.dart';
import 'package:my_project/utils/messages.dart';
import 'package:flutter/material.dart';

class SignupVM extends BaseViewModel {
  @override
  void onInit() {}
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  String? name, email, password, phone, address;

  VoidCallback? onRegisterSuccess;

  void visiblePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoading();
      try {
        // Mock register - replace with actual API call
        await Future.delayed(const Duration(seconds: 1));

        // Simulate success
        hideLoading();
        showNotification('memberCreated');
        onRegisterSuccess?.call();
      } catch (e) {
        hideLoading();
        if (e is DioError && e.response?.statusCode == 422) {
          showError('Email already exists');
        } else {
          showError(Messages.serverError);
        }
      }
    }
  }
}
