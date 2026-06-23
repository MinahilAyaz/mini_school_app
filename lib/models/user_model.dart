/// User model representing an authenticated user
class User {
  final String id;
  final String email;
  final String token;
  final String? name;
  final String? avatar;

  User({
    required this.id,
    required this.email,
    required this.token,
    this.name,
    this.avatar,
  });

  /// Convert JSON from API to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
      name: json['name'],
      avatar: json['avatar'],
    );
  }

  /// Convert User object to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'token': token,
      'name': name,
      'avatar': avatar,
    };
  }

  /// Create a copy with modified fields
  User copyWith({
    String? id,
    String? email,
    String? token,
    String? name,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }
}
