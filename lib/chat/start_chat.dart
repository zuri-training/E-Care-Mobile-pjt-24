import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:e_care_mobile/models/doctors._model.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/util/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'api/chat_api.dart';
import 'chart_page.dart';
import 'chatDetailPage.dart';

class StartChat extends StatefulWidget {
  const StartChat({Key key}) : super(key: key);

  @override
  _StartChatState createState() => _StartChatState();
}

class _StartChatState extends State<StartChat> {
  String specialization;
  String doctorId;
  String doctorName;
  String doctorSurname;

  // Thickness of Text fields
  double _textFieldBorderWidth = 1;

  // Text field container height
  double _textFieldHeight = 48;

  // Text size
  double _textSize = 14;

  // Text field box shadow
  Color _textFieldShadow = Color.fromRGBO(0, 0, 0, 0.5);
  Color _green = HexColor("#4BA54D");

  @override
  Widget build(BuildContext context) {
    UserProvider userDat = Provider.of<UserProvider>(context);
    final name = userDat.user.firstname;
    DropdownEditingController<String> _controller =
        DropdownEditingController<String>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 40,
          ),
          Container(
              child: Text(
            'Hi $name,\nLets get the right doctor for you.',
            style: TextStyle(
                color: _green, fontSize: 24, fontWeight: FontWeight.w600),
          )),
          SizedBox(
            height: 40,
          ),
          buildText('Which specialist would you like to chat with?'),
          SizedBox(height: 20),
          TextDropdownFormField(
            options: [
              "Cardiologist",
              "Dentist",
              "Dermatologist",
              "General Doctor",
              "Gynaecologist",
              "Neurologist",
              "Pediatrician",
              "Physician",
              "Psychiatrists",
              "Psychologist"
            ],
            decoration: InputDecoration(
              //border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.arrow_drop_down, color: _green),
              counterStyle: TextStyle(color: _green),
              border: OutlineInputBorder(
                  /*borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),*/
                  borderSide: BorderSide(
                      color: Color.fromRGBO(136, 136, 136, 1), //_purple,
                      style: BorderStyle.solid,
                      width: _textFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  /*borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),*/
                  borderSide: BorderSide(
                      color: Color.fromRGBO(136, 136, 136, 1), //_purple,
                      style: BorderStyle.solid,
                      width: _textFieldBorderWidth)),
              enabledBorder: OutlineInputBorder(
                  /*borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),*/
                  borderSide: BorderSide(
                      color: _green, //_purple,
                      style: BorderStyle.solid,
                      width: _textFieldBorderWidth)),
            ),
            onChanged: (dynamic specialize) {
              print(specialize);
              setState(() {
                specialization = specialize;
              });
            },
            controller: _controller,
            validator: (dynamic value) =>
                value.isEmpty ? 'Choose a specialist' : null,
            //dropdownHeight: 120,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: () async {
                /*if (checkFields()) {
                  login();
                }*/
                var specs = _controller.value;
                //print('specs: $specialization');
                List<Doctors> stream =
                    await FirebaseApi.getSpecialist(specialization);
                var aa = stream.where(
                    (element) => element.data.containsValue(specialization));
                //.contains('data[gender]');//[0].data['gender'];

                aa.forEach((element) {
                  print(element.id);
                  setState(() {
                    doctorId = element.id;
                    doctorName = element.data['name'];

                    ///doctorSurname = element.data['surname'];
                  });
                });
                //print('ss:$bb');
                //print(aa['specialization']);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatDetailPage(
                        receiverId: doctorId,
                        doctorName: doctorName,
                        doctorSurname: doctorSurname)));
              },
              child: signButton(
                  _textFieldHeight, _textFieldShadow, _textSize, 'CHAT')),
        ]),
      )),
    );
  }

  Widget buildText(String text) => Center(
        child: Container(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      );
  String dropDownValue;

  Widget dropDown() {
    return DropdownButton<String>(
      value: dropDownValue,
      //icon: const Icon(Icons.arrow_downward),
      //iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropDownValue = newValue;
        });
      },
      items:
          <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
