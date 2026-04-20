import 'package:dio/dio.dart';
import 'package:my_project/models/borrow_record.dart';

class BorrowRepo {
  final Dio _dio;

  BorrowRepo(this._dio);

  Future<List<BorrowRecord>> getBorrowRecords() async {
    try {
      final response = await _dio.get('/borrow-records');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => BorrowRecord.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BorrowRecord>> getActiveBorrows() async {
    try {
      final response = await _dio.get('/borrow-records/active');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => BorrowRecord.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<BorrowRecord> borrowBook(String bookId, String memberId, int durationDays) async {
    try {
      final response = await _dio.post('/borrow-records', data: {
        'book_id': bookId,
        'member_id': memberId,
        'duration_days': durationDays,
      });
      return BorrowRecord.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<BorrowRecord> returnBook(String recordId) async {
    try {
      final response = await _dio.post('/borrow-records/$recordId/return');
      return BorrowRecord.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BorrowRecord>> getMemberBorrowHistory(String memberId) async {
    try {
      final response = await _dio.get('/members/$memberId/borrows');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => BorrowRecord.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
