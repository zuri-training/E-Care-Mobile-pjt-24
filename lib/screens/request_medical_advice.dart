import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestMedicalAdvice extends StatefulWidget {
  const RequestMedicalAdvice({Key key}) : super(key: key);

  @override
  _RequestMedicalAdviceState createState() => _RequestMedicalAdviceState();
}

class _RequestMedicalAdviceState extends State<RequestMedicalAdvice> {
  TextEditingController textEditingController = TextEditingController();
  DateTime _selectedDate;
  List<String> _doctors = [
    'Dr. Emma',
    'Dr. John',
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
              top: 0,
              bottom: 8,
            ),
            child: InkWell(
              child: Icon(
                CarbonIcons.menu,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 15,
          top: 15,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5, top: 20),
            ),
            Row(
              children: [
                Text(
                  'Hello Susan! Tell Us How You Feel',
                  style: TextStyle(
                    color: Color(0xff6305B1),
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
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
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                ),
                Text(
                  'ILLNESS/SYMPTOMS',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 40,
                    top: 10,
                  ),
                  child: TextField(
                    minLines: 4,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Tell us how you feel',
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff6305B1), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff6305B1), width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff6305B1),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                ),
                Text(
                  'CHOOSE A DOCTOR',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22, right: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: DropdownButton(
                      isExpanded: true,
                      dropdownColor: Color(0xffF7D9B4),
                      hint: Text('Pick a doctor'), // Not necessary for Option 1
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
              height: MediaQuery.of(context).size.height / 16,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                ),
                Text(
                  'DATE',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
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
                      padding: const EdgeInsets.only(left: 20, right: 30),
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
                  padding: EdgeInsets.only(left: 60),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 13,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      primary: Color(0xff6305B1),
                    ),
                    onPressed: () {},
                    child: Text(
                      'SEND',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
