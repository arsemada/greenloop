class Admin {
  final String id;
  final String? fullName;
  final String? email; // For convenience

  Admin({required this.id, this.fullName, this.email});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'] as String,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
    );
  }
}