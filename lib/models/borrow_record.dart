enum BorrowStatus { borrowed, returned, overdue }

class BorrowRecord {
  final String id;
  final String bookId;
  final String memberId;
  final String bookTitle;
  final String? coverUrl;
  final String memberName;
  final DateTime borrowDate;
  final DateTime dueDate;
  final DateTime? returnDate;
  final BorrowStatus status;

  BorrowRecord({
    required this.id,
    required this.bookId,
    required this.memberId,
    required this.bookTitle,
    this.coverUrl,
    required this.memberName,
    required this.borrowDate,
    required this.dueDate,
    this.returnDate,
    required this.status,
  });

  factory BorrowRecord.fromJson(Map<String, dynamic> json) {
    return BorrowRecord(
      id: json['id']?.toString() ?? '',
      bookId: json['book_id'] ?? '',
      memberId: json['member_id'] ?? '',
      bookTitle: json['book_title'] ?? '',
      coverUrl: json['cover_url'],
      memberName: json['member_name'] ?? '',
      borrowDate: json['borrow_date'] != null
          ? DateTime.parse(json['borrow_date'])
          : DateTime.now(),
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'])
          : DateTime.now().add(const Duration(days: 14)),
      returnDate: json['return_date'] != null
          ? DateTime.parse(json['return_date'])
          : null,
      status: _parseStatus(json['status']),
    );
  }

  static BorrowStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'returned':
        return BorrowStatus.returned;
      case 'overdue':
        return BorrowStatus.overdue;
      default:
        return BorrowStatus.borrowed;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book_id': bookId,
      'member_id': memberId,
      'book_title': bookTitle,
      'cover_url': coverUrl,
      'member_name': memberName,
      'borrow_date': borrowDate.toIso8601String(),
      'due_date': dueDate.toIso8601String(),
      'return_date': returnDate?.toIso8601String(),
      'status': status.name,
    };
  }

  BorrowRecord copyWith({
    String? id,
    String? bookId,
    String? memberId,
    String? bookTitle,
    String? coverUrl,
    String? memberName,
    DateTime? borrowDate,
    DateTime? dueDate,
    DateTime? returnDate,
    BorrowStatus? status,
  }) {
    return BorrowRecord(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      memberId: memberId ?? this.memberId,
      bookTitle: bookTitle ?? this.bookTitle,
      coverUrl: coverUrl ?? this.coverUrl,
      memberName: memberName ?? this.memberName,
      borrowDate: borrowDate ?? this.borrowDate,
      dueDate: dueDate ?? this.dueDate,
      returnDate: returnDate ?? this.returnDate,
      status: status ?? this.status,
    );
  }
}
