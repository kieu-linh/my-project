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
      // Mock data - replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      books = _getMockBooks();
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
        book.isbn.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

  Future<void> deleteBook(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      books.removeWhere((book) => book.id == id);
      filteredBooks = books;
      showNotification('bookDeleted');
      notifyListeners();
    } catch (e) {
      showError(e.toString());
    }
  }

  List<Book> _getMockBooks() {
    return [
      Book(
        id: '1',
        title: 'Clean Code',
        author: 'Robert C. Martin',
        isbn: '978-0132350884',
        quantity: 5,
        availableQuantity: 3,
        description: 'A Handbook of Agile Software Craftsmanship',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      Book(
        id: '2',
        title: 'The Pragmatic Programmer',
        author: 'David Thomas',
        isbn: '978-0135957059',
        quantity: 3,
        availableQuantity: 2,
        description: 'From Journeyman to Master',
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
      ),
      Book(
        id: '3',
        title: 'Design Patterns',
        author: 'Gang of Four',
        isbn: '978-0201633610',
        quantity: 4,
        availableQuantity: 4,
        description: 'Elements of Reusable Object-Oriented Software',
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
      ),
      Book(
        id: '4',
        title: 'Introduction to Algorithms',
        author: 'Thomas H. Cormen',
        isbn: '978-0262033848',
        quantity: 2,
        availableQuantity: 1,
        description: 'A Comprehensive Foundation for Algorithms',
        createdAt: DateTime.now().subtract(const Duration(days: 120)),
      ),
      Book(
        id: '5',
        title: 'Refactoring',
        author: 'Martin Fowler',
        isbn: '978-0134757599',
        quantity: 3,
        availableQuantity: 2,
        description: 'Improving the Design of Existing Code',
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
      ),
    ];
  }

  void refresh() => loadBooks();
}
