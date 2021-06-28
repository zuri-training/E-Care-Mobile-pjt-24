class User {
  String patientId;
  String firstname;
  String surname;
  String email;
  String dob;
  String token;

  User({
    this.patientId,
    this.firstname,
    this.surname,
    this.email,
    String dob,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      patientId: responseData['patientId'],
      firstname: responseData['firstname'],
      surname: responseData['surname'],
      email: responseData['email'],
      dob: responseData['dob'],
      token: responseData['token'],
    );
  }
}
