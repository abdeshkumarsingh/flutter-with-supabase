class UserDataModel {
  final int id; // Auto-incremented serial ID
  final String userId; // User ID (foreign key to users.id)
  final String title; // Title of the user data
  final String? content; // Content (nullable)
  final DateTime createdAt; // Data entry creation timestamp

  UserDataModel({
    required this.id,
    required this.userId,
    required this.title,
    this.content,
    required this.createdAt,
  });

  // Factory constructor to create a UserDataModel from a Map
  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      id: map['id'] as int,
      userId: map['user_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  // Convert a UserDataModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
