class User {
  String patientId;
  String firstname;
  String surname;
  String email;
  String dob;
  //bool isVerified;
  String token;

  User({
    this.patientId,
    this.firstname,
    this.surname,
    this.email,
    this.dob,
    //this.isVerified,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      patientId: responseData['_id'],
      firstname: responseData['firstname'],
      surname: responseData['lastname'],
      email: responseData['email'],
      dob: responseData['dob'],
      //isVerified: responseData['isVerified'],
      token: responseData['token'],
    );
  }
}
