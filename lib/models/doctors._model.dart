import 'package:cloud_firestore/cloud_firestore.dart';

class Doctors {
  Doctors({this.id, this.data});

  factory Doctors.fromFireStore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data();

    return Doctors(id: doc.id, data: data['data'] ?? <dynamic>{});
  }

  String id;
  Map<dynamic, dynamic> data;
}
