import 'package:e_care_mobile/util/colors.dart';
import 'package:flutter/material.dart';

class AvailableDocs extends StatelessWidget {
  const AvailableDocs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 1,
        height: MediaQuery.of(context).size.height / 4,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Image.asset('assets/images/doc.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dr. Anne',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        Text('Pediatrician', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 40,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: yellow,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('4.5'),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.timer,
                                  color: lightblue,
                                ),
                                Text('Wed, 12:15PM'),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
