import 'package:my_project/base/base_view_model.dart';
import 'package:my_project/models/book.dart';

class BookListVM extends BaseViewModel {
  @override
  void onInit() {
    loadBooks();
  }

  List<Book> books = [];
  List<Book> filteredBooks = [];
  String searchQuery = '';

  Future<void> loadBooks() async {
    showLoading();
    try {
      final result = await api.bookRepo.getBooks(page: 1, limit: 10);
      print('Books loaded: ${result['books']}');
      books = result['books'] as List<Book>;
      filteredBooks = books;
      hideLoading();
      notifyListeners();
    } catch (e) {
      hideLoading();
      showError(e.toString());
    }
  }

  void search(String query) {
    searchQuery = query;
    if (query.isEmpty) {
      filteredBooks = books;
    } else {
      filteredBooks = books.where((book) =>
        book.title.toLowerCase().contains(query.toLowerCase()) ||
        book.author.toLowerCase().contains(query.toLowerCase()) ||
        book.category.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

  Future<void> deleteBook(int id) async {
    try {
      await api.bookRepo.deleteBook(id.toString());
      books.removeWhere((book) => book.id == id);
      filteredBooks = books;
      showNotification('bookDeleted');
      notifyListeners();
    } catch (e) {
      showError(e.toString());
    }
  }

  void refresh() => loadBooks();
}
