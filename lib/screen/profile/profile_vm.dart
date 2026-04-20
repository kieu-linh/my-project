import 'package:my_project/base/base_view_model.dart';

class ProfileVM extends BaseViewModel {
  @override
  void onInit() {}

  String name = 'Admin User';
  String email = 'admin@library.com';
  String role = 'Administrator';

  void refresh() {
    notifyListeners();
  }
}
