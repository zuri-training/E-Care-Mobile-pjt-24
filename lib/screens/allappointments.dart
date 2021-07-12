import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/screens/book_appointment.dart';
import 'package:e_care_mobile/util/colors.dart';
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

    CollectionReference _apptStream =
        FirebaseFirestore.instance.collection('bookAppointment');
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Appointments'),
        centerTitle: true,
        backgroundColor: lightgreen,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _apptStream.doc(userid).get(),
        builder:
            // ignore: missing_return
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data.data() as Map<String, dynamic>;
            return new ListView(
              children: [
                Card(
                  elevation: 3,
                  color: lemon,
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
                          return await _showConfirmationDialog(
                                  context, 'Edit') ==
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
                        data.remove(data);
                      });
                      if (direction == DismissDirection.startToEnd) {
                        data.remove(data);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => EditNotes(document)));
                      }
                      if (direction == DismissDirection.endToStart) {
                        data.remove(data);
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
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightgreen,
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
