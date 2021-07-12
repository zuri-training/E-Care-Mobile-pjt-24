import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care_mobile/userData/user.dart';
import 'package:e_care_mobile/util/AppException.dart';
import 'package:e_care_mobile/util/shared_preference.dart';

class Book {
  CollectionReference _db =
      FirebaseFirestore.instance.collection('bookAppointment');

  User user;

  Future<dynamic> bookAppt(
    String _id,
    String date,
    String doctor,
    String reason,
  ) async {
    try {
      await _db.doc(_id).set({
        'Date': date,
        'Doctor': doctor,
        'Reason': reason,
      });
    } on FirebaseException catch (e) {
      throw FireStoreException(e.message);
    }
  }
}
