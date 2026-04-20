import 'package:my_project/base/base_view_model.dart';
import 'package:flutter/material.dart';

class LoginVM extends BaseViewModel {
  @override
  void onInit() {}
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  String? email, password;

  void visiblePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }
}
