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
      await Future.delayed(const Duration(seconds: 1));
      borrows = _getMockBorrows();
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
      await Future.delayed(const Duration(seconds: 1));
      final index = borrows.indexWhere((b) => b.id == recordId);
      if (index != -1) {
        borrows[index] = borrows[index].copyWith(
          status: BorrowStatus.returned,
          returnDate: DateTime.now(),
        );
        applyFilter();
      }
      showNotification('bookReturnedSuccessfully');
      hideLoading();
      notifyListeners();
    } catch (e) {
      hideLoading();
      showError(e.toString());
    }
  }

  List<BorrowRecord> _getMockBorrows() {
    return [
      BorrowRecord(
        id: '1',
        bookId: '1',
        memberId: '1',
        bookTitle: 'Clean Code',
        memberName: 'John Doe',
        borrowDate: DateTime.now().subtract(const Duration(days: 5)),
        dueDate: DateTime.now().add(const Duration(days: 9)),
        status: BorrowStatus.borrowed,
      ),
      BorrowRecord(
        id: '2',
        bookId: '2',
        memberId: '2',
        bookTitle: 'The Pragmatic Programmer',
        memberName: 'Jane Smith',
        borrowDate: DateTime.now().subtract(const Duration(days: 20)),
        dueDate: DateTime.now().subtract(const Duration(days: 6)),
        status: BorrowStatus.overdue,
      ),
      BorrowRecord(
        id: '3',
        bookId: '3',
        memberId: '1',
        bookTitle: 'Design Patterns',
        memberName: 'John Doe',
        borrowDate: DateTime.now().subtract(const Duration(days: 30)),
        dueDate: DateTime.now().subtract(const Duration(days: 16)),
        returnDate: DateTime.now().subtract(const Duration(days: 17)),
        status: BorrowStatus.returned,
      ),
    ];
  }

  void refresh() => loadBorrows();
}
