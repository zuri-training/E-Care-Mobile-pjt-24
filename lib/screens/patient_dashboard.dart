import 'package:e_care_mobile/chat/chart_page.dart';
import 'package:e_care_mobile/medical/view_medical_advice.dart';
import 'package:e_care_mobile/screens/book_appointment.dart';
import 'package:e_care_mobile/screens/profile/profile_page.dart';
import 'package:e_care_mobile/screens/request_medical_advice.dart';
import 'package:e_care_mobile/userData/user.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:provider/provider.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({Key key}) : super(key: key);

  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    var as = user.firstname;
    print('widg: $as');
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 24, bottom: 16),
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
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.menu,
                      //     size: MediaQuery.of(context).size.width / 10,
                      //   ),
                      //   onPressed: () {
                      //
                      //   },
                      // ),
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
                        user.firstname,
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
                              contentPadding: EdgeInsets.all(10.0),
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
                        GestureDetector(
                          onTap: () {
                            _move();
                          },
                          child: card('Book an Appointment',
                              CarbonIcons.reminder_medical),
                        ),
                        /*GestureDetector(
                          child: helpbuilder(
                            context,
                            IconButton(
                              icon: Icon(
                                CarbonIcons.reminder_medical,
                                size: 40,
                              ),
                              onPressed: _move,
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
                        ),*/
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            _requestmedic();
                          },
                          child: card('Request Medical Advice',
                              FontAwesomeIcons.handHoldingMedical),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewMedicalAdvice()));
                          },
                          child: card('View Medical Advice',
                              FontAwesomeIcons.fileMedical),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Top Doctors',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  DoctorsList(),
                  /*SingleChildScrollView(
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
                  ),*/
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
                size: 24,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ChatPage()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Icon(
                  CarbonIcons.chat_bot,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Icon(
                  CarbonIcons.settings,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row helpbuilder(BuildContext context, IconButton iconButton, Text firstLine,
      Text SecondLine) {
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
                    padding: const EdgeInsets.fromLTRB(54, 20, 20, 0),
                    child: Row(
                      children: [
                        iconButton,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48),
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

  Card card(String text, IconData iconData) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Container(
          width: 120,
          height: 112,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: Color.fromRGBO(255, 209, 150, 0.800000011920929),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Icon(
                      iconData,
                      color: Color(0xff6305B1),
                      size: 40,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 14,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.1428571428571428),
                    ),
                  )
                ]),
          )),
    );
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
              clipBehavior: Clip.hardEdge,
              elevation: 0,
              shape: StadiumBorder(
                  // borderRadius: BorderRadius.circular(30),
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

  void _move() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => BookAppointment()));
  }

  void _requestmedic() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RequestMedicalAdvice()));
  }
}

final _containerHeight = 154.0;
final _borderRadius = BorderRadius.circular(_containerHeight / 2);

class DoctorsListItem extends StatelessWidget {
  final String doctorName;
  final IconData iconLocation;
  final String date;
  final ColorSwatch color;

  /// Creates a [DoctorsListItem].
  ///
  /// A [DoctorsListItem] saves the name of the Doctor (e.g. 'Dr. Paul'), date,
  ///  availibility of doctor, and the profile picture.
  // While the @required checks for whether a named parameter is passed in,
  // it doesn't check whether the object passed in is null. We check that
  // in the assert statement.
  const DoctorsListItem({
    Key key,
    @required this.doctorName,
    @required this.iconLocation,
    @required this.date,
    @required this.color,
  })  : assert(doctorName != null),
        assert(iconLocation != null),
        assert(date != null),
        assert(color != null),
        super(key: key);

  /// Builds a custom widget that shows [Doctor] information.
  ///
  /// This information includes the icon, name, and color for the [Doctor].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Card(
        //margin: EdgeInsets.only(right:16.0),
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Container(
            width: 156,
            height: 154,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              color: Color.fromRGBO(255, 209, 150, 0.800000011920929),
            ),
            child: InkWell(
              borderRadius: _borderRadius,
              highlightColor: color,
              splashColor: color,
              // We can use either the () => function() or the () { function(); }
              // syntax.
              // TODO onTap: () => _navigateToConverter(context),
              child: Column(children: [
                SizedBox(height: 16.0),
                Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/Ellipse11.png'),
                          fit: BoxFit.fitWidth),
                      borderRadius: BorderRadius.all(Radius.elliptical(36, 36)),
                    )),
                SizedBox(height: 10.0),
                Text(
                  doctorName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Availability:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontFamily: 'Inter',
                      fontSize: 16,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Text(
                  date,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 14,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.1428571428571428),
                )
              ]),
            )),
      ),
    ));
  }
}

class DoctorsList extends StatelessWidget {
  const DoctorsList();

  // Dummy data
  static const _doctorNames = <String>[
    'Dr. Paul',
    'Dr. James',
    'Dr. Rachel',
    'Dr. Amaka',
    'Dr. Tosin',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  /// Makes the correct number of rows for the list view.
  ///
  /// For portrait, we use a [ListView].
  Widget _buildCategoryWidgets(List<Widget> categories) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) => categories[index],
      itemCount: categories.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = <DoctorsListItem>[];
    // TODO USE CORRECT DATA
    for (var i = 0; i < _doctorNames.length; i++) {
      categories.add(DoctorsListItem(
        doctorName: _doctorNames[i],
        iconLocation: Icons.cake,
        date: 'Tue, 26 May at 9:30',
        color: _baseColors[i],
      ));
    }

    final listView = Container(
      height: 200.0,
      //color: _backgroundColor,
      //padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryWidgets(categories),
    );

    return listView;
  }
}
