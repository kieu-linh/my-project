class Member {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? address;
  final DateTime memberSince;
  final bool isActive;

  Member({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    required this.memberSince,
    this.isActive = true,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'],
      memberSince: json['member_since'] != null
          ? DateTime.parse(json['member_since'])
          : DateTime.now(),
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'member_since': memberSince.toIso8601String(),
      'is_active': isActive,
    };
  }

  Member copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    DateTime? memberSince,
    bool? isActive,
  }) {
    return Member(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      memberSince: memberSince ?? this.memberSince,
      isActive: isActive ?? this.isActive,
    );
  }
}
