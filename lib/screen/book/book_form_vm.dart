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
  String? category;
  int totalCopies = 1;
  int availableCopies = 1;
  String? description;
  String? coverUrl;
  Book? editingBook;

  void initWithBook(Book book) {
    editingBook = book;
    title = book.title;
    author = book.author;
    category = book.category;
    totalCopies = book.totalCopies;
    availableCopies = book.availableCopies;
    description = book.description;
    coverUrl = book.coverUrl;
    notifyListeners();
  }

  void setTitle(String? value) => title = value;
  void setAuthor(String? value) => author = value;
  void setCategory(String? value) => category = value;
  void setTotalCopies(int value) => totalCopies = value;
  void setAvailableCopies(int value) => availableCopies = value;
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
        if (editingBook != null) {
          await api.bookRepo.updateBook(editingBook!.id.toString(), {
            'title': title,
            'author': author,
            'category': category,
            'totalCopies': totalCopies,
            'availableCopies': availableCopies,
            'description': description,
          });
        } else {
          await api.bookRepo.createBook({
            'title': title,
            'author': author,
            'category': category,
            'totalCopies': totalCopies,
            'availableCopies': availableCopies,
            'description': description,
          });
        }
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
