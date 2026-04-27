import 'package:my_project/base/base_view_model.dart';

class DashboardVM extends BaseViewModel {
  @override
  void onInit() {
    loadDashboard();
  }

  // Mock data for demonstration - replace with actual API calls
  int totalBooks = 0;
  int totalMembers = 0;
  int borrowedBooks = 0;
  int overdueBooks = 0;

  Future<void> loadDashboard() async {
    showLoading();
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock data - replace with actual API calls
      totalBooks = 1250;
      totalMembers = 320;
      borrowedBooks = 45;
      overdueBooks = 5;

      hideLoading();
      notifyListeners();
    } catch (e) {
      hideLoading();
      showError(e.toString());
    }
  }

  void refresh() {
    loadDashboard();
  }
}
