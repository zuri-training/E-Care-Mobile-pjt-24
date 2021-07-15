import 'package:e_care_mobile/screens/articlescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HealthArticles extends StatelessWidget {
  const HealthArticles({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ArticleScreen())),
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        width: MediaQuery.of(context).size.width,
        height: 194,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.207182884216309)),
          color: Color.fromRGBO(75, 165, 77, 1),
        ),
        child: Stack(clipBehavior: Clip.none, children: [
          //AssetImage('assets/images/littlegirl.png),
          Positioned(
            top: 0,
            bottom: 0,
            left: -32,
            child: Container(
                width: 226,
                height: 226,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/littlegirl.png'),
                      fit: BoxFit.fitHeight),
                )
                //child: AssetImage('assets/images/littlegirl.png')
                ),
          ),
          Positioned(
            top: 194 / 4,
            left: MediaQuery.of(context).size.width / 2.75,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      width: 160,
                      //color:Colors.yellow,
                      child: Text(
                        'Health Articles',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(246, 246, 246, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          width: 160,
                          child: Text(
                            'Stay up to date.\nRead the lastest health development in Nigeria',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromRGBO(246, 246, 246, 1),
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 12,
                      )
                    ],
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}
