import 'package:my_project/base/base_view_model.dart';
import 'package:my_project/models/member.dart';

class MemberListVM extends BaseViewModel {
  @override
  void onInit() {
    loadMembers();
  }

  List<Member> members = [];
  List<Member> filteredMembers = [];
  String searchQuery = '';

  Future<void> loadMembers() async {
    showLoading();
    try {
      await Future.delayed(const Duration(seconds: 1));
      members = _getMockMembers();
      filteredMembers = members;
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
      filteredMembers = members;
    } else {
      filteredMembers = members.where((member) =>
        member.name.toLowerCase().contains(query.toLowerCase()) ||
        member.email.toLowerCase().contains(query.toLowerCase()) ||
        member.phone.contains(query)
      ).toList();
    }
    notifyListeners();
  }

  Future<void> deleteMember(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      members.removeWhere((member) => member.id == id);
      filteredMembers = members;
      showNotification('memberDeleted');
      notifyListeners();
    } catch (e) {
      showError(e.toString());
    }
  }

  List<Member> _getMockMembers() {
    return [
      Member(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        phone: '0123456789',
        address: '123 Main St',
        memberSince: DateTime.now().subtract(const Duration(days: 30)),
      ),
      Member(
        id: '2',
        name: 'Jane Smith',
        email: 'jane@example.com',
        phone: '0987654321',
        address: '456 Oak Ave',
        memberSince: DateTime.now().subtract(const Duration(days: 60)),
      ),
      Member(
        id: '3',
        name: 'Bob Wilson',
        email: 'bob@example.com',
        phone: '0123456780',
        memberSince: DateTime.now().subtract(const Duration(days: 90)),
      ),
    ];
  }

  void refresh() => loadMembers();
}
