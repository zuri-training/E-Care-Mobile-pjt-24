import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/userData/user.dart';
import 'package:provider/provider.dart';

class BookAppointment {
  CollectionReference caredb =
      FirebaseFirestore.instance.collection('book-appointment');
  User user;

  Future bookAppointment(
    DateTime date,
    String doctor,
    String reason,
  ) async {
    await caredb.doc(user.patientId).set({
      'date': date,
      'doctor': doctor,
      'reason': reason,
    });
  }
}
