import 'package:my_project/base/base_view_model.dart';
import 'package:my_project/models/borrow_record.dart';

class BorrowListVM extends BaseViewModel {
  @override
  void onInit() {
    loadBorrows();
  }

  List<BorrowRecord> borrows = [];
  List<BorrowRecord> filteredBorrows = [];
  String filterStatus = 'all';

  Future<void> loadBorrows() async {
    showLoading();
    try {
      final result = await api.borrowRepo.getMyBorrows();
      final List<dynamic> data = result is List ? result : (result['data'] ?? []);
      borrows = data.map((json) => BorrowRecord.fromJson(json)).toList();
      applyFilter();
      hideLoading();
      notifyListeners();
    } catch (e) {
      hideLoading();
      showError(e.toString());
    }
  }

  void setFilter(String status) {
    filterStatus = status;
    applyFilter();
    notifyListeners();
  }

  void applyFilter() {
    if (filterStatus == 'all') {
      filteredBorrows = borrows;
    } else {
      filteredBorrows = borrows.where((b) => b.status.name == filterStatus).toList();
    }
  }

  Future<void> returnBook(String recordId) async {
    showLoading();
    try {
      final res = await api.borrowRepo.returnBook(int.parse(recordId));
      hideLoading();
      // Kiểm tra response có thành công không
      if (res['error'] != null) {
        showError(res['error'].toString());
      } else {
        showNotification('bookReturnedSuccessfully');
        loadBorrows();
      }
    } catch (e) {
      hideLoading();
      showError(e.toString());
    }
  }

  void refresh() => loadBorrows();
}
