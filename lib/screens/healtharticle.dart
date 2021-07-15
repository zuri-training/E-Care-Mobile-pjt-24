
import 'package:e_care_mobile/screens/articlescreen.dart';
import 'package:e_care_mobile/util/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'availabledocs.dart';

class HealthArticles extends StatelessWidget {
  const HealthArticles({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => ArticleScreen(),
      child: Padding(
        padding: const EdgeInsets.only(right: 23),
        child: GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.width / 0.2,
            height: MediaQuery.of(context).size.height / 2.92,
            child: GestureDetector(
              onTap: () => ArticleScreen(),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: lightgreen,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 0.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 0, left: 0),
                            child: Image.asset('assets/images/littlegirl.png'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 160),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 25, bottom: 10),
                            child: Text(
                              'Health Articles',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Stay up to date. \nRead the lastest health development in Nigeria',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 140, top: 20),
                            child: Column(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ArticleScreen()))),
                              ],
                            ),
                          )

    return Padding(
      padding: const EdgeInsets.only(right: 23),
      child: Container(
        width: MediaQuery.of(context).size.width / 0.2,
        height: MediaQuery.of(context).size.height / 2.92,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: lightgreen,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 0.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0, left: 0),
                      child: Image.asset('assets/images/littlegirl.png'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 160),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25, bottom: 10),
                      child: Text(
                        'Health Articles',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Stay up to date. \nRead the lastest health development in Nigeria',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 140, top: 20),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Image.asset(
                              'assets/images/Group.png',
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),

              ),
            ),

              )
            ],

          ),
        ),
      ),
    );
  }
}
