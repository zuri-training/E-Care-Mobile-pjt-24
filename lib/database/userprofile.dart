import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final CollectionReference _db =
      FirebaseFirestore.instance.collection('patients');
  Future displayUserProfile(String _id) async {
    _db.doc(_id).get();
  }

  Future updateUserProfile(String _id, String firstname, String surname,
      String gender, String location, String number) async {
    _db
        .doc(_id)
        .set({
          'firstname': firstname,
          'surname': surname,
          'gender': gender,
          'location': location,
          'number': number,
        })
        .then((value) => value)
        .onError((error, stackTrace) => print(error));
  }
}
