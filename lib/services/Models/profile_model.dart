class ProfileModel {
  final String id; // References the user ID (UUID)
  final String? bio; // Bio (nullable)
  final String? phoneNumber; // Phone number (nullable)
  final DateTime createdAt; // Profile creation timestamp

  ProfileModel({
    required this.id,
    this.bio,
    this.phoneNumber,
    required this.createdAt,
  });

  // Factory constructor to create a ProfileModel from a Map
  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      bio: map['bio'] as String?,
      phoneNumber: map['phone_number'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  // Convert a ProfileModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bio': bio,
      'phone_number': phoneNumber,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
