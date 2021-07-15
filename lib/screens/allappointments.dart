import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/screens/book_appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllAppointments extends StatefulWidget {
  const AllAppointments({Key key}) : super(key: key);

  @override
  _AllAppointmentsState createState() => _AllAppointmentsState();
}

class _AllAppointmentsState extends State<AllAppointments> {
  @override
  Widget build(BuildContext context) {
    UserProvider userDat = Provider.of<UserProvider>(context);
    //var as = user.firstname;
    var userid = userDat.user.patientId;

    Stream _apptStream =
        FirebaseFirestore.instance.collection('bookAppointment').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Appointments'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(99, 5, 177, 1),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _apptStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return SnackBar(content: Text('No Appointments to Load'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.purple,
                strokeWidth: 5,
              ),
            );
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Card(
                elevation: 3,
                color: Color.fromRGBO(255, 209, 150, 0.800000011920929),
                child: Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Color.fromRGBO(99, 5, 177, 1),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: Icon(
                      CupertinoIcons.delete,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  confirmDismiss: (DismissDirection dismissDirection) async {
                    switch (dismissDirection) {
                      case DismissDirection.endToStart:
                        //whatHappened = 'ARCHIVED';
                        return await _showConfirmationDialog(
                                context, 'Delete') ==
                            true;
                      case DismissDirection.startToEnd:
                        //whatHappened = 'DELETED';
                        return await _showConfirmationDialog(context, 'Edit') ==
                            true;

                      case DismissDirection.horizontal:
                      case DismissDirection.vertical:
                      case DismissDirection.up:
                      case DismissDirection.down:
                        assert(false);
                    }
                    return false;
                  },
                  onDismissed: (direction) {
                    setState(() {
                      data.remove(document);
                    });
                    if (direction == DismissDirection.startToEnd) {
                      data.remove(document);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => EditNotes(document)));
                    }
                    if (direction == DismissDirection.endToStart) {
                      data.remove(document);
                      // FireDb().deleteNotes(document.id);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text('Note has been deleted!')));
                    }
                  },
                  child: new ListTile(
                    isThreeLine: true,
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => NotesDetail(document)));
                    },
                    leading: Icon(
                      CupertinoIcons.calendar,
                      size: 30,
                      color: Colors.black,
                    ),
                    title: new Text(
                      'Date: ${data['Date']}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: new Text(
                      'Doctor: ${data['Doctor']} \nReason: ${data['Reason']}',
                      maxLines: 4,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.grey),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(99, 5, 177, 1),
        child: Icon(
          Icons.add,
        ),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BookAppointment())),
      ),
    );
  }
}

Future<bool> _showConfirmationDialog(BuildContext context, String action) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Do you want to $action this note?'),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context, true); // showDialog() returns true
            },
          ),
          ElevatedButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context, false); // showDialog() returns false
            },
          ),
        ],
      );
    },
  );
}
