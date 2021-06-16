import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key key}) : super(key: key);

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  TextEditingController textEditingController = TextEditingController();
  DateTime _selectedDate;
  List<String> _doctors = [
    'Dr. Emma',
    'Dr. Johns',
  ];
  String _selectedDoctors; // Option 2
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white12,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              top: 4,
            ),
            child: InkWell(
              child: Icon(
                CarbonIcons.search,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Book Top Doctor \nnear me',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 80,
                ),
                Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 4.6,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Card(
                        elevation: 10,
                        color: Color(0xff6305B1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                ),
                                Text(
                                  'Book an Appointment',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 50,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                ),
                                Text(
                                  'Feeling awful, Book an \nappointment and get help \nfrom professional practitioners.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12),
                    ),
                    Text(
                      'Time',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 80,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 0),
                        child: new TextField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff6305B1), width: 4.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff6305B1), width: 3.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff6305B1),
                                    width: 4.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: EdgeInsets.all(20))),
                      ),
                    ),
                    new Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 0),
                        child: new TextField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff6305B1), width: 4.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff6305B1), width: 3.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Color(0xff6305B1),
                                    width: 4.0,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(20))),
                      ),
                    ),
                    new Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 0),
                        child: new TextField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff6305B1), width: 4.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff6305B1), width: 3.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Color(0xff6305B1),
                                    width: 4.0,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(20))),
                      ),
                    ),
                    new Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 0),
                        child: new TextField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff6305B1), width: 4.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff6305B1), width: 3.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Color(0xff6305B1),
                                    width: 4.0,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(20))),
                      ),
                    ),
                    new Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 40, left: 0, top: 0),
                        child: Text(
                          'HRS',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12),
                    ),
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: _selectDate,
                      child: AbsorbPointer(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 20),
                          child: TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              hintText: 'Tap to pick date',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12),
                    ),
                    Text(
                      'Choose a Doctor',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: DropdownButton(
                          isExpanded: true,
                          dropdownColor: Color(0xffF7D9B4),
                          hint: Text(
                              'Pick a doctor'), // Not necessary for Option 1
                          value: _selectedDoctors,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedDoctors = newValue;
                            });
                          },
                          items: _doctors.map((doctor) {
                            return DropdownMenuItem(
                              child: new Text(
                                doctor,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              value: doctor,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12),
                    ),
                    Text(
                      'Reason for Appointment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 14,
                        child: TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff6305B1), width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff6305B1), width: 1.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xff6305B1),
                              ),
                            ),
                            hintText: 'Tell us how you feel',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 8, right: 40, top: 60, bottom: 30),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 13,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          primary: Color(0xff6305B1),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Book Appointment',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectDate() async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    maximumDate: DateTime.now().add(Duration(days: 2)),
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        textEditingController.text = pickedDate.toString();
      });
    }
  }
}
