import 'package:dio/dio.dart';
import 'package:my_project/api/api_config.dart';
import 'package:my_project/models/borrow_record.dart';

class BorrowRepo {
  final Dio _dio;

  BorrowRepo(this._dio);

  Future<Map<String, dynamic>> createBorrow(int bookId) async {
    try {
      final response = await _dio.post(ApiConfig.borrows, data: {
        'bookId': bookId,
      });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> returnBook(int id) async {
    try {
      final response = await _dio.put(ApiConfig.returnBook(id));
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getMyBorrows() async {
    try {
      final response = await _dio.get(ApiConfig.myBorrows);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BorrowRecord>> getBorrowRecords() async {
    try {
      final response = await _dio.get('api/borrow-records');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => BorrowRecord.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BorrowRecord>> getActiveBorrows() async {
    try {
      final response = await _dio.get('api/borrow-records/active');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => BorrowRecord.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<BorrowRecord> borrowBook(String bookId, String memberId, int durationDays) async {
    try {
      final response = await _dio.post('api/borrow-records', data: {
        'book_id': bookId,
        'member_id': memberId,
        'duration_days': durationDays,
      });
      return BorrowRecord.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BorrowRecord>> getMemberBorrowHistory(String memberId) async {
    try {
      final response = await _dio.get('api/members/$memberId/borrows');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => BorrowRecord.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
