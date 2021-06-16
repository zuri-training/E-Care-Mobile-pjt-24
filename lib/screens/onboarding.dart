import 'package:e_care_mobile/models/onboarding_model.dart';
import 'package:e_care_mobile/screens/book_appointment.dart';
import 'package:e_care_mobile/screens/patient_dashboard.dart';
import 'package:e_care_mobile/screens/request_medical_advice.dart';
import 'package:e_care_mobile/screens/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<OnboardingModel> contents = [
    OnboardingModel(
      title: 'Hospital Record Management',
      description:
          'This software application will utilize modern technology to improve health records management ',
      image: 'assets/images/screenone.svg',
    ),
    OnboardingModel(
      title: 'Rural-connect',
      description:
          'healthcare professionals can share requests for medical advice amongst one another.',
      image: 'assets/images/screentwo.svg',
    ),
    OnboardingModel(
      title: 'Book Appointments',
      description:
          ' patients can see the time when a particular doctor will be available and then, book an appointment with that doctor',
      image: 'assets/images/screenthree.svg',
    ),
  ];

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
    _controller.addListener(() {
      currentIndex = _controller.page.toInt();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int currentIndex = 0;
  PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: contents.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SvgPicture.asset(
                          contents[index].image,
                          height: MediaQuery.of(context).size.height / 2.3,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Text(
                        contents[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        contents[index].description,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDots(index, context),
              ),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff041337),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                ),
              ),
              onPressed: () {
                // if (currentIndex == contents.length - 1) {
                //   Navigator.of(context).push(
                //       MaterialPageRoute(builder: (context) => ResetPassword()));
                // }
                _controller.nextPage(
                  duration: Duration(
                    microseconds: 10,
                    milliseconds: 100,
                  ),
                  curve: Curves.bounceInOut,
                );
              },
              child: Text(
                currentIndex == contents.length - 1 ? 'continue' : 'next',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDots(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(
        right: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff041337),
      ),
    );
  }
}
