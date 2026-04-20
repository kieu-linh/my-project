import 'package:flutter/material.dart';
import 'package:my_project/base/base_view_model.dart';
import 'package:my_project/models/book.dart';

class BookFormVM extends BaseViewModel {
  @override
  void onInit() {}
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  String? title;
  String? author;
  String? isbn;
  int quantity = 1;
  String? description;
  Book? editingBook;

  void initWithBook(Book book) {
    editingBook = book;
    title = book.title;
    author = book.author;
    isbn = book.isbn;
    quantity = book.quantity;
    description = book.description;
    notifyListeners();
  }

  void setTitle(String? value) => title = value;
  void setAuthor(String? value) => author = value;
  void setIsbn(String? value) => isbn = value;
  void setQuantity(int value) => quantity = value;
  void setDescription(String? value) => description = value;

  void toggleObscure() {
    obscureText = !obscureText;
    notifyListeners();
  }

  Future<void> saveBook() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoading();
      try {
        await Future.delayed(const Duration(seconds: 1));
        hideLoading();
        showNotification(editingBook != null ? 'bookUpdated' : 'bookCreated');
        notifyListeners();
      } catch (e) {
        hideLoading();
        showError(e.toString());
      }
    }
  }
}
