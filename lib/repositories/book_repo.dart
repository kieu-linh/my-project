import 'package:dio/dio.dart';
import 'package:my_project/models/book.dart';

class BookRepo {
  final Dio _dio;

  BookRepo(this._dio);

  Future<List<Book>> getBooks() async {
    try {
      final response = await _dio.get('/books');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => Book.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Book> getBook(String id) async {
    try {
      final response = await _dio.get('/books/$id');
      return Book.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<Book> createBook(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/books', data: data);
      return Book.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<Book> updateBook(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/books/$id', data: data);
      return Book.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteBook(String id) async {
    try {
      await _dio.delete('/books/$id');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Book>> searchBooks(String query) async {
    try {
      final response = await _dio.get('/books/search', queryParameters: {'q': query});
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => Book.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
