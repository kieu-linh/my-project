class Book {
  final int id;
  final String title;
  final String author;
  final String category;
  final int totalCopies;
  final int availableCopies;
  final String? coverUrl;
  final String? description;
  final DateTime createdAt;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.totalCopies,
    required this.availableCopies,
    this.coverUrl,
    this.description,
    required this.createdAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? '',
      totalCopies: json['totalCopies'] ?? 0,
      availableCopies: json['availableCopies'] ?? 0,
      coverUrl: json['coverUrl'],
      description: json['description'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'category': category,
      'totalCopies': totalCopies,
      'availableCopies': availableCopies,
      'coverUrl': coverUrl,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Book copyWith({
    int? id,
    String? title,
    String? author,
    String? category,
    int? totalCopies,
    int? availableCopies,
    String? coverUrl,
    String? description,
    DateTime? createdAt,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      category: category ?? this.category,
      totalCopies: totalCopies ?? this.totalCopies,
      availableCopies: availableCopies ?? this.availableCopies,
      coverUrl: coverUrl ?? this.coverUrl,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
