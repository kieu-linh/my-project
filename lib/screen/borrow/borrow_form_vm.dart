import 'package:my_project/base/base_view_model.dart';
import 'package:my_project/models/book.dart';

class BorrowFormVM extends BaseViewModel {
  @override
  void onInit() {}

  List<Book> availableBooks = [];
  Book? selectedBook;
  int durationDays = 14;

  void init() async {
    showLoading();
    try {
      final result = await api.bookRepo.getBooks(page: 1, limit: 100);
      availableBooks = result['books'] as List<Book>;
      hideLoading();
      notifyListeners();
    } catch (e) {
      hideLoading();
      showError(e.toString());
    }
  }

  void setSelectedBook(Book? book) {
    selectedBook = book;
    notifyListeners();
  }

  void setDuration(int days) {
    durationDays = days;
    notifyListeners();
  }

  Future<void> borrowBook() async {
    if (selectedBook == null) {
      showError('Please select a book');
      return;
    }
    showLoading();
    try {
      await api.borrowRepo.createBorrow(selectedBook!.id);
      showNotification('bookBorrowedSuccessfully');
      hideLoading();
      notifyListeners();
    } catch (e) {
      hideLoading();
      showError(e.toString());
    }
  }
}
