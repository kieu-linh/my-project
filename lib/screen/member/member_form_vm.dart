import 'package:flutter/material.dart';
import 'package:my_project/base/base_view_model.dart';
import 'package:my_project/models/member.dart';

class MemberFormVM extends BaseViewModel {
  @override
  void onInit() {}
  final formKey = GlobalKey<FormState>();

  String? name;
  String? email;
  String? phone;
  String? address;
  bool isActive = true;
  Member? editingMember;

  void initWithMember(Member member) {
    editingMember = member;
    name = member.name;
    email = member.email;
    phone = member.phone;
    address = member.address;
    isActive = member.isActive;
    notifyListeners();
  }

  void setName(String? value) => name = value;
  void setEmail(String? value) => email = value;
  void setPhone(String? value) => phone = value;
  void setAddress(String? value) => address = value;
  void setActive(bool value) => isActive = value;

  Future<void> saveMember() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoading();
      try {
        await Future.delayed(const Duration(seconds: 1));
        hideLoading();
        showNotification(editingMember != null ? 'memberUpdated' : 'memberCreated');
        notifyListeners();
      } catch (e) {
        hideLoading();
        showError(e.toString());
      }
    }
  }
}
