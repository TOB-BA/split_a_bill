class Admin {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final int creditCardNumber;

  const Admin(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.address,
      required this.creditCardNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'creditCardNumber': creditCardNumber,
    };
  }

  @override
  String toString() {
    return 'Admin{id: $id, firstName: $firstName, lastName: $lastName}';
  }
}
