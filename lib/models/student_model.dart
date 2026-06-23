/// Student model representing a student in the system
class Student {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;
  final String? company;
  final String? address;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
    this.company,
    this.address,
  });

  /// Convert JSON from API to Student object
  /// Using JSONPlaceholder API structure
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Unknown',
      email: json['email'] as String? ?? 'N/A',
      phone: json['phone'] as String? ?? 'N/A',
      website: json['website'] as String? ?? 'N/A',
      company: json['company'] != null
          ? (json['company'] as Map)['name'] as String?
          : null,
      address: json['address'] != null
          ? '${json['address']['street']}, ${json['address']['city']}'
          : null,
    );
  }

  /// Convert Student object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'website': website,
      'company': company,
      'address': address,
    };
  }

  /// Create a copy with modified fields
  Student copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? website,
    String? company,
    String? address,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      company: company ?? this.company,
      address: address ?? this.address,
    );
  }

  @override
  String toString() => 'Student(id: $id, name: $name, email: $email)';
}
