class User {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email; // While email is in auth.users, we might want it here for convenience

  User({required this.id, this.firstName, this.lastName, this.phoneNumber, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
    );
  }
}