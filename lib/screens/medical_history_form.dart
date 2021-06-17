import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

class MedicalHistoryForm extends StatefulWidget {
  const MedicalHistoryForm({Key key}) : super(key: key);

  @override
  _MedicalHistoryFormState createState() => _MedicalHistoryFormState();
}

class _MedicalHistoryFormState extends State<MedicalHistoryForm> {
  int colorGroupValue = -1;
  int exerciseGroupValue = -1;
  int smokeGroupValue = -1;
  int alcoholGroupValue = -1;
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 60),
                  ),
                  Text(
                    'MEDICAL HISTORY',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 50,
                    ),
                  ),
                  Text(
                    'ANY DRUG ALLERGIES?',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 90,
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
                      left: 50,
                      right: 20,
                      top: 0,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
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
                height: MediaQuery.of(context).size.height / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 50,
                    ),
                  ),
                  Text(
                    'HAVE YOU HAD ANY ILLNESS BEFORE?',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 90,
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
                      left: 50,
                      right: 20,
                      top: 0,
                    ),
                    child: TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
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
                  Padding(padding: EdgeInsets.only(left: 50, right: 0)),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                        ),
                      ),
                      Text(
                        'HAVE YOU HAD AN \nOPERATION BEFORE?',
                        textAlign: TextAlign.justify,
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
                          left: 50,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Color(0xff6305B1),
                            value: 0,
                            groupValue: colorGroupValue,
                            onChanged: (val) {
                              setState(() {
                                colorGroupValue = val;
                              });
                            },
                          ),
                          Text('Yes')
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Color(0xff6305B1),
                            value: 1,
                            groupValue: colorGroupValue,
                            onChanged: (val) {
                              colorGroupValue = val;
                              setState(() {});
                            },
                          ),
                          Text('No')
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 50,
                    ),
                  ),
                  Text(
                    'CURRENT MEDICATION IF ANY?',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 90,
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
                      left: 50,
                      right: 20,
                      top: 0,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
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
                height: MediaQuery.of(context).size.height / 30,
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 50, right: 0)),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                        ),
                      ),
                      Text(
                        'DO YOU EXERCISE?',
                        textAlign: TextAlign.justify,
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
                          left: 50,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Color(0xff6305B1),
                            value: 0,
                            groupValue: exerciseGroupValue,
                            onChanged: (val) {
                              setState(() {
                                exerciseGroupValue = val;
                              });
                            },
                          ),
                          Text('Yes')
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Color(0xff6305B1),
                            value: 1,
                            groupValue: exerciseGroupValue,
                            onChanged: (val) {
                              exerciseGroupValue = val;
                              setState(() {});
                            },
                          ),
                          Text('No')
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 50, right: 0)),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                        ),
                      ),
                      Text(
                        'DO YOU SMOKE?',
                        textAlign: TextAlign.justify,
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
                          left: 50,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Color(0xff6305B1),
                            value: 0,
                            groupValue: smokeGroupValue,
                            onChanged: (val) {
                              setState(() {
                                smokeGroupValue = val;
                              });
                            },
                          ),
                          Text('Yes')
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Color(0xff6305B1),
                            value: 1,
                            groupValue: smokeGroupValue,
                            onChanged: (val) {
                              smokeGroupValue = val;
                              setState(() {});
                            },
                          ),
                          Text('No')
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 50, right: 0)),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                        ),
                      ),
                      Text(
                        'DO YOU DRINK ALCOHOL?',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 40,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Color(0xff6305B1),
                            value: 0,
                            groupValue: alcoholGroupValue,
                            onChanged: (val) {
                              setState(() {
                                alcoholGroupValue = val;
                              });
                            },
                          ),
                          Text('Yes')
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Color(0xff6305B1),
                            value: 1,
                            groupValue: alcoholGroupValue,
                            onChanged: (val) {
                              alcoholGroupValue = val;
                              setState(() {});
                            },
                          ),
                          Text('No')
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 50,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'TELL US MORE ABOUT YOUR MEDICAL \nHISTORY? (OPTIONAL)',
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 90,
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
                      left: 50,
                      right: 20,
                      top: 0,
                    ),
                    child: TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
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
                height: MediaQuery.of(context).size.height / 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 90),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 13,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        primary: Color(0xff6305B1),
                      ),
                      // onPressed: () {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => CheckYourEmail()));
                      // },
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
