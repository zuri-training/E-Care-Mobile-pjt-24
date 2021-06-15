import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({Key key}) : super(key: key);

  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 26, top: 40),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffF8B25A),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          size: MediaQuery.of(context).size.width / 10,
                        ),
                        onPressed: () {},
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
                          left: 5,
                        ),
                      ),
                      Text(
                        'Hello,',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          color: Color(0xff6305B1),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Susan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xff6305B1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 14,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  top: 1,
                                ),
                                child: Icon(
                                  Icons.search_sharp,
                                  size: 27,
                                  color: Colors.black,
                                ),
                              ),
                              hintText: 'search your symptoms..',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                  ),
                  Row(
                    children: [
                      Text(
                        'How can we help you?',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        helpbuilder(
                          context,
                          Icon(
                            CarbonIcons.reminder_medical,
                            size: 40,
                            color: Color(0xff6305B1),
                          ),
                          Text(
                            'Book an',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Appointment',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 20,
                        ),
                        helpbuilder(
                          context,
                          Icon(
                            FontAwesomeIcons.handHoldingMedical,
                            color: Color(0xff6305B1),
                            size: 40,
                          ),
                          Text(
                            'Request',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Medical Advice',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 20,
                        ),
                        helpbuilder(
                          context,
                          Icon(
                            FontAwesomeIcons.fileMedical,
                            color: Color(0xff6305B1),
                            size: 40,
                          ),
                          Text(
                            'View',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Medical Advice',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Text(
                        'Top Doctors',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.9,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        doctorsbuilder(
                          context,
                          Text(
                            'Dr. Paul',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Availability :',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            'Tue, 28 May at 9:30',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 40,
                        ),
                        doctorsbuilder(
                          context,
                          Text(
                            'Dr. Racheal',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Availability :',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            'Wed, 14 July at 12:15',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff6305B1),
        selectedLabelStyle: TextStyle(
          fontSize: 16,
        ),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Icon(
                CarbonIcons.home,
                color: Colors.white,
                size: MediaQuery.of(context).size.height / 20,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Icon(
                CarbonIcons.chat_bot,
                color: Colors.white,
                size: MediaQuery.of(context).size.height / 20,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Icon(
                CarbonIcons.settings,
                color: Colors.white,
                size: MediaQuery.of(context).size.height / 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row helpbuilder(
      BuildContext context, Icon icon, Text firstLine, Text SecondLine) {
    return Row(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 2.4,
          child: GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Color(0xffFFE5C4),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 20, 20, 0),
                    child: Row(
                      children: [
                        icon,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        firstLine,
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        SecondLine,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Row doctorsbuilder(
  BuildContext context,
  Text doctorname,
  Text availability,
  Text timeanddate,
) {
  return Row(
    children: [
      Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width / 2,
        child: GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Color(0xffFFE5C4),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 40, 20, 0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 54),
                  child: Row(
                    children: [
                      doctorname,
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 20),
                  child: Row(
                    children: [
                      availability,
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Row(
                    children: [
                      timeanddate,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
