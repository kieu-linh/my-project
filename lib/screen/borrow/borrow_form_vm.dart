import 'package:my_project/base/base_view_model.dart';
import 'package:my_project/models/book.dart';
import 'package:my_project/models/member.dart';

class BorrowFormVM extends BaseViewModel {
  @override
  void onInit() {}

  List<Book> availableBooks = [];
  List<Member> members = [];
  Book? selectedBook;
  Member? selectedMember;
  int durationDays = 14;

  void init() async {
    showLoading();
    try {
      await Future.delayed(const Duration(seconds: 1));
      availableBooks = _getMockBooks();
      members = _getMockMembers();
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

  void setSelectedMember(Member? member) {
    selectedMember = member;
    notifyListeners();
  }

  void setDuration(int days) {
    durationDays = days;
    notifyListeners();
  }

  Future<void> borrowBook() async {
    if (selectedBook == null || selectedMember == null) {
      showError('Please select both book and member');
      return;
    }
    showLoading();
    try {
      await Future.delayed(const Duration(seconds: 1));
      showNotification('bookBorrowedSuccessfully');
      hideLoading();
      notifyListeners();
    } catch (e) {
      hideLoading();
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
        createdAt: DateTime.now(),
      ),
      Book(
        id: '2',
        title: 'The Pragmatic Programmer',
        author: 'David Thomas',
        isbn: '978-0135957059',
        quantity: 3,
        availableQuantity: 2,
        createdAt: DateTime.now(),
      ),
      Book(
        id: '3',
        title: 'Design Patterns',
        author: 'Gang of Four',
        isbn: '978-0201633610',
        quantity: 4,
        availableQuantity: 0,
        createdAt: DateTime.now(),
      ),
    ];
  }

  List<Member> _getMockMembers() {
    return [
      Member(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        phone: '0123456789',
        memberSince: DateTime.now(),
      ),
      Member(
        id: '2',
        name: 'Jane Smith',
        email: 'jane@example.com',
        phone: '0987654321',
        memberSince: DateTime.now(),
      ),
    ];
  }
}
