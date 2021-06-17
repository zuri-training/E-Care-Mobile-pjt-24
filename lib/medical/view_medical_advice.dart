import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'models/prescriptionModel.dart';

class ViewMedicalAdvice extends StatefulWidget {
  @override
  _ViewMedicalAdviceState createState() => _ViewMedicalAdviceState();
}

class _ViewMedicalAdviceState extends State<ViewMedicalAdvice> {
  /// list of messages to display in chat screen
  List<DoctorsFeedback> doctorsFeedback = [
    DoctorsFeedback(
      patientName: "Susan",
      prescription: 'Flagyl,Fluconazole, Ciprotab',
      dosage: 'Take one tablet of flagyl, every eight hours for five days',
      doctorsAdvice:
          'Avoid using public toilets as much possible and keep to strict hygiene practices',
    ),
  ];

  //String names=doctorsFeedback[0].patientName;

  Color _purple = HexColor("#6305B1");
  Color _purpleText = HexColor("#8237C1");
  Color _gold = HexColor("#F8B25A");
  Color _lightGold = HexColor("#FFD197"); //FFE5C4
  Color _darkGrey = HexColor("#4F4F4F");
  Color _grey = HexColor("#828282");
  Color _lightGrey = HexColor("#BDBDBD");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
              child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        //color: Color.fromRGBO(255, 255, 255, 0.0001),
                        size: 32.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                      Icon(
                        Icons.menu,
                        //color: Colors.pink,
                        size: 32.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    ],
                  ))),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _buildContent(),
        ));
  }

  _buildContent() {
    return (Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: ListView(
        children: [
          SizedBox(height: 50.0),
          Text(
            'Hi ${doctorsFeedback[0].patientName}, Dr Racheal has a prescription for you. Get Well Soon!',
            //'Hello, $_name! How are you?',
            textAlign: TextAlign.start,
            //overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: _purple, fontSize: 24.0),
          ),
          SizedBox(height: 50.0),
          Text(
            'Prescription'.toUpperCase(),
            textAlign: TextAlign.center,
            //overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 25.0),
          //SizedBox(height: 150.0, width: double.infinity,color:_gold,),
          Container(
            padding: EdgeInsets.all(24.0),
            width: double.infinity,
            height: 240.0,
            decoration: BoxDecoration(
                color: _lightGold,
                borderRadius: BorderRadius.all(Radius.circular(32))),
            child: Stack(children: [
              Center(
                child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(
                        doctorsFeedback[0].prescription,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'View more',
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: _purpleText,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ])),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Download',
                  textAlign: TextAlign.end,
                  //overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _purpleText,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 50.0),
          Text(
            'Dosage'.toUpperCase(),
            textAlign: TextAlign.center,
            //overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 25.0),
          Container(
            padding: EdgeInsets.all(24.0),
            width: double.infinity,
            height: 240.0,
            decoration: BoxDecoration(
                color: _lightGold,
                borderRadius: BorderRadius.all(Radius.circular(32))),
            child: Center(
              child: Text(
                doctorsFeedback[0].dosage,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 50.0),
          Text(
            'Doctors prescription'.toUpperCase(),
            textAlign: TextAlign.center,
            //overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 25.0),
          Container(
            padding: EdgeInsets.all(24.0),
            width: double.infinity,
            height: 240.0,
            decoration: BoxDecoration(
                color: _lightGold,
                borderRadius: BorderRadius.all(Radius.circular(32))),
            child: Center(
              child: Text(
                doctorsFeedback[0].doctorsAdvice,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
