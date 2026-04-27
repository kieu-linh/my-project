import 'package:my_project/base/base_view_model.dart';

class ProfileVM extends BaseViewModel {
  @override
  void onInit() {
    _loadUserData();
    fetchBookStats();
  }

  String name = 'Admin User';
  String email = 'admin@library.com';
  String role = 'Administrator';
  int totalBooks = 0;

  void _loadUserData() {
    final user = prefs.user;
    if (user != null) {
      name = user.name ?? 'Admin User';
      email = user.email ?? 'admin@library.com';
      role = user.role ?? 'Administrator';
    }
    totalBooks = prefs.bookStats;
    notifyListeners();
  }

  Future<void> fetchBookStats() async {
    try {
      final result = await api.bookRepo.getBooks(page: 1, limit: 1);
      final total = result['total'] as int;
      prefs.bookStats = total;
      totalBooks = total;
      notifyListeners();
    } catch (e) {
      // Keep existing value on error
    }
  }

  void refresh() {
    notifyListeners();
  }
}
