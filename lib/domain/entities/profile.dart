class Profile {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
  });
}