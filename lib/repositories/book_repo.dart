import 'package:dio/dio.dart';
import 'package:my_project/models/book.dart';

class BookRepo {
  final Dio _dio;

  BookRepo(this._dio);

  Future<Map<String, dynamic>> getBooks({int page = 1, int limit = 10}) async {
    try {
      final response = await _dio.get('api/books', queryParameters: {
        'page': page,
        'limit': limit,
      });
      final List<dynamic> data = response.data['data'] ?? [];
      final books = data.map((json) => Book.fromJson(json)).toList();
      final total = response.data['total'] ?? 0;
      return {
        'books': books,
        'total': total,
      };
    } catch (e) {
      rethrow;
    }
  }

  Future<Book> getBook(String id) async {
    try {
      final response = await _dio.get('api/books/$id');
      return Book.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<Book> createBook(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('api/books', data: data);
      return Book.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<Book> updateBook(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('api/books/$id', data: data);
      return Book.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteBook(String id) async {
    try {
      await _dio.delete('api/books/$id');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Book>> searchBooks(String query) async {
    try {
      final response = await _dio.get('api/books/search', queryParameters: {'q': query});
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => Book.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
