/// User model for SyncUp app
class UserModel {
  final String id;
  final String name;
  final String email;
  final int age;
  final String bio;
  final String profileImageUrl;
  final List<String> goals;
  final String commitment; // Low, Medium, High
  final String interests; // comma-separated string

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.bio,
    required this.profileImageUrl,
    required this.goals,
    required this.commitment,
    required this.interests,
  });

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'goals': goals,
      'commitment': commitment,
      'interests': interests,
    };
  }

  /// Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      age: json['age'] ?? 0,
      bio: json['bio'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      goals: List<String>.from(json['goals'] ?? []),
      commitment: json['commitment'] ?? 'Medium',
      interests: json['interests'] ?? '',
    );
  }

  /// Create a copy of UserModel with optional new values
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    int? age,
    String? bio,
    String? profileImageUrl,
    List<String>? goals,
    String? commitment,
    String? interests,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      goals: goals ?? this.goals,
      commitment: commitment ?? this.commitment,
      interests: interests ?? this.interests,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, age: $age, commitment: $commitment)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
