// User model class
class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String avatarUrl;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.avatarUrl,
    required this.createdAt,
  });

  // Convert a JSON map to a User instance
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '', // Default to an empty string if null
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at']) ?? DateTime.now() // Handle invalid or null dates
          : DateTime.now(), // Default to the current date/time if null
    );
  }

  // Convert a User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }
}