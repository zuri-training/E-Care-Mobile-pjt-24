import 'package:e_care_mobile/chat/chart_page.dart';
import 'package:e_care_mobile/chat/start_chat.dart';
import 'package:e_care_mobile/medical/view_medical_advice.dart';
import 'package:e_care_mobile/models/doctors._model.dart';
import 'package:e_care_mobile/providers/auth.dart';
import 'package:e_care_mobile/screens/allappointments.dart';
import 'package:e_care_mobile/screens/book_appointment.dart';
import 'package:e_care_mobile/screens/healtharticle.dart';
import 'package:e_care_mobile/screens/profile/profile_page.dart';
import 'package:e_care_mobile/screens/request_medical_advice.dart';
import 'package:e_care_mobile/userData/user.dart';
import 'package:e_care_mobile/util/shared_preference.dart';
import 'package:e_care_mobile/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'articlescreen.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({Key key}) : super(key: key);

  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  @override
  Widget build(BuildContext context) {
    UserProvider userDat = Provider.of<UserProvider>(context);
    //var as = user.firstname;
    var userFirstname = userDat.user.firstname;
    print('widg: $userFirstname');
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 24, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xffF8B25A),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 1.5),
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
                    height: 30,
                  ),
                  Text(
                    'Hello,',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 18,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    userFirstname + '!',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 30,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 24),
                  HealthArticles(),
                  SizedBox(height: 36),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                      color: Color.fromRGBO(255, 255, 255, 1),
                      border: Border.all(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 8),
                          SvgPicture.asset('assets/images/search_icon.svg',
                              semanticsLabel: 'search icon'),
                          SizedBox(width: 12),
                          Text(
                            'How can I help you?',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.w300,
                                height: 1),
                          )
                        ]),
                  ),
                  SizedBox(height: 60),
                  Text(
                    'What do you need?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 14),
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
                  SizedBox(height: 60),
                  Text(
                    'Available Doctors',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 18),
                  DoctorsList(),
                  TextButton(
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(99, 5, 177, 1),
        child: Icon(
          Icons.chat,
        ),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => StartChat())),
      ),
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
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            color: Color.fromRGBO(243, 239, 130, 1),
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
                      color: HexColor('#4BA54D'),
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

  void _move() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AllAppointments()));
  }

  void _requestmedic() {
    UserPreferences().removeUser();
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
  final String specialization;

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
    @required this.specialization,
  })
      : assert(doctorName != null),
        assert(iconLocation != null),
        assert(date != null),
        assert(color != null),
        assert(specialization != null),
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
    /*return Material(
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
    ));*/
    return Container(
      margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
      width: MediaQuery.of(context).size.width,
      height: 158,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(5, 4),
              blurRadius: 6)
        ],
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            //left: -32,
            child: Container(
                width: 152,
                height: 141,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/doc.png'),
                      fit: BoxFit.fill),
                )
                //child: AssetImage('assets/images/littlegirl.png')
                ),
          ),
          Positioned(
            left: 158,
            top: 141 / 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    width: 160,
                    child: Text(doctorName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                        width: 160,
                        child: Text(specialization,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)))),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.yellow //yellow,
                        ),
                    SizedBox(
                      width: 4,
                    ),
                    Text('4.5'),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.timer, color: Colors.lightBlue //lightblue,
                        ),
                    Text('Wed, 12:15PM',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
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

  Widget builds(BuildContext context) {
    //AuthProvider auth = Provider.of<AuthProvider>(context);
    return StreamBuilder<List<Doctors>>(
      stream: AuthProvider.getDoctors(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: loadingSpinner(48.0, 2.0));
          default:
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Try later');
            } else {
              final doctors = snapshot.data;
              //var as= (messages.length);
              //print('messages.length $as');
              return doctors.isEmpty
                  ? buildText('Sorry, No doctor available at the moment..')
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: doctors.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      //physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final doctor = doctors[index].data;
                        //String formattedTime = DateFormat.Hm().format(message.createdAt);
                        return DoctorsListItem(
                            doctorName:
                                doctor['firstname'] + ' ' + doctor['surname'],
                            iconLocation: Icons.cake,
                            date: 'Tue, 26 May at 9:30',
                            color: Colors.blue,
                            specialization: doctor['specialization']);
                      },
                    );
            }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /*final categories = <DoctorsListItem>[];
    // TODO USE CORRECT DATA
    for (var i = 0; i < _doctorNames.length; i++) {
      categories.add(DoctorsListItem(
        doctorName: _doctorNames[i],
        iconLocation: Icons.cake,
        date: 'Tue, 26 May at 9:30',
        color: _baseColors[i],
      ));
    }*/
    return StreamBuilder<List<Doctors>>(
      stream: AuthProvider.getDoctors(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: loadingSpinner(48.0, 2.0));
          default:
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Try later');
            } else {
              final doctors = snapshot.data;
              //var as= (messages.length);
              //print('messages.length $as');
              return doctors.isEmpty
                  ? buildText('Sorry, No doctors available at the moment..')
                  : ListView.builder(
                      itemCount: doctors.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final doctor = doctors[index].data;
                        //String formattedTime = DateFormat.Hm().format(message.createdAt);
                        return DoctorsListItem(
                            doctorName:
                                doctor['firstname'] + ' ' + doctor['surname'],
                            iconLocation: Icons.cake,
                            date: 'Tue, 26 May at 9:30',
                            color: Colors.blue,
                            specialization: doctor['specialization']);
                      },
                    );
            }
        }
      },
    );

    /*final listView = Container(
      height: 200.0,
      //color: _backgroundColor,
      //padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: builds(context)//_buildCategoryWidgets(categories),
    );

    return listView;*/
  }
}
