class UserModel {
  final String id; // UUID from Supabase Auth
  final String email; // User email
  final String? fullName; // User's full name (nullable)
  final String? avatarUrl; // URL to user's avatar (nullable)
  final DateTime createdAt; // Account creation timestamp

  UserModel({
    required this.id,
    required this.email,
    this.fullName,
    this.avatarUrl,
    required this.createdAt,
  });

  // Factory constructor to create a UserModel from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      fullName: map['full_name'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  // Convert a UserModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
