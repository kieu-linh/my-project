import 'package:dio/dio.dart';
import 'package:my_project/models/member.dart';

class MemberRepo {
  final Dio _dio;

  MemberRepo(this._dio);

  Future<List<Member>> getMembers() async {
    try {
      final response = await _dio.get('/members');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => Member.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Member> getMember(String id) async {
    try {
      final response = await _dio.get('/members/$id');
      return Member.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<Member> createMember(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/members', data: data);
      return Member.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<Member> updateMember(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/members/$id', data: data);
      return Member.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteMember(String id) async {
    try {
      await _dio.delete('/members/$id');
    } catch (e) {
      rethrow;
    }
  }
}
