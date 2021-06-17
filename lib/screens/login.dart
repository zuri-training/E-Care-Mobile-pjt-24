import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signup.dart';
import 'reset_password.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  static const double figureHeight = 250;

  Color _purple = HexColor("#6305B1");
  Color _purpleText = HexColor("#8237C1");
  Color _gold = HexColor("#F8B25A");
  Color _lightGold = HexColor("#FFE5C4");
  Color _darkGrey = HexColor("#4F4F4F");
  Color _grey = HexColor("#828282");
  Color _lightGrey = HexColor("#BDBDBD");

  // Text size
  double _textSize = 16;

  // variable to store if password is visible or not
  bool _obscureText = true;

  //final String assetName = 'assets/images/vector.svg';
  /*final Widget svg =
      SvgPicture.asset('assets/images/vector.svg', semanticsLabel: 'Acme Logo');*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Form(key: formKey, child: _buildLoginForm(context)),
    ));
  }

  _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
        //width: MediaQuery.of(context).size.width,
        /*CustomPaint(
        size: MediaQuery.of(context).size,
        painter: CurvePainter(figureHeight: figureHeight),

      ),*/

            child:Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 24, 24.0, 24.0),
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 32.0),
                Center(
                  child: Text('Sign In',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 56)
                  ),
                ),
                SizedBox(height: 32.0),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(8),
                      ),
                      color: Color.fromRGBO(99, 5, 177, 1),
                      gradient: LinearGradient(
                          begin: Alignment(6.123234262925839e-17, 1),
                          end: Alignment(-1, 6.123234262925839e-17),
                          colors: [
                            Color.fromRGBO(76, 21, 211, 1),
                            Color.fromRGBO(96, 8, 182, 1)
                          ]),
                    ),
                    child: OrientationBuilder(
                        builder: (BuildContext context, Orientation orientation) {
                          return Row(
                            mainAxisAlignment: orientation == Orientation.portrait
                                ? MainAxisAlignment.spaceEvenly
                                : MainAxisAlignment.center,
                            children: [
                              //Image(image: AssetImage('images/google.png')),
                              Image.asset(
                                ('assets/images/google.png'),
                                height: 24,
                                width: 24,
                              ),
                              Padding(
                                padding: orientation == Orientation.portrait
                                    ? const EdgeInsets.only(left: 0.0)
                                    : const EdgeInsets.only(left: 24.0),
                                child: Text('Sign In with Google',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: _textSize)),
                              ),
                            ],
                          );
                        })),
                SizedBox(height: 40.0),
                Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                        endIndent: 24,
                        color: Colors.black,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                    child: Text("OR",
                        style: TextStyle(
                            fontSize: _textSize, fontWeight: FontWeight.w500)),
                  ),
                  Expanded(
                      child: Divider(
                        indent: 24,
                        color: Colors.black,
                      )),
                ]),
                SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Email',
                      style: TextStyle(
                          fontSize: _textSize, fontWeight: FontWeight.w500)),
                ),
                Container(
                    height: 48.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(8),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            offset: Offset(0, 4),
                            blurRadius: 4)
                      ],
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'myemail@gmail.com',
                          //labelText: 'Email',
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.2),
                              fontSize: _textSize),
                          isDense: true,
                          counterText: "",
                          contentPadding: EdgeInsets.all(10.0),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            /*borderRadius:
                                new BorderRadius.circular(10.0),*/
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              borderSide: BorderSide.none)),
                      /*onChanged: (value) {
                          this.email = value;
                        },
                        validator: (value) =>
                        value.isEmpty ? 'Email is required' : validateEmail(value)*/
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      maxLength: 20,
                      // controller: _locationNameTextController,
                    )),
                SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Password',
                      style: TextStyle(
                          fontSize: _textSize, fontWeight: FontWeight.w500)),
                ),
                Container(
                  height: 48.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          offset: Offset(0, 4),
                          blurRadius: 4)
                    ],
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: TextField(
                    obscureText: _obscureText,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        //icon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _obscureText == true
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 24.0,
                              color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        //labelText: 'Email',
                        hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.2),
                            fontSize: _textSize),
                        isDense: true,
                        counterText: "",
                        contentPadding: EdgeInsets.all(10.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          /*borderRadius:
                                new BorderRadius.circular(10.0),*/
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                            borderSide: BorderSide.none)),
                    /*onChanged: (value) {
                          this.email = value;
                        },
                        validator: (value) =>
                        value.isEmpty ? 'Email is required' : validateEmail(value)*/
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    maxLength: 20,
                    // controller: _locationNameTextController,
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Checkbox(checkColor: _purple, value: false),
                  ),
                  Expanded(
                    child: Text("Stay logged In",
                        style: TextStyle(
                            fontSize: _textSize,
                            fontWeight: FontWeight.w500,
                            color: _purple)),
                  ),
                ]),
                SizedBox(height: 40.0),
                GestureDetector(
                  /*onTap: () {
                        if (checkFields()) AuthService().signIn(email, password, context);
                      },*/
                  /*child: Container(
                          height: 48.0,
                          child: Material(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              color: _purple,
                              elevation: 7.0,
                              child: Center(
                                  child: Text('SIGN IN',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: _textSize,
                                          fontWeight: FontWeight.w500))))),*/
                    child: Container(
                        height: 48.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Color.fromRGBO(99, 5, 177, 1),
                          gradient: LinearGradient(
                              begin: Alignment(6.123234262925839e-17, 1),
                              end: Alignment(-1, 6.123234262925839e-17),
                              colors: [HexColor("#4C15D3"), HexColor("#6305B1")]),
                        ),
                        child: Center(
                            child: Text('SIGN IN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _textSize,
                                    fontWeight: FontWeight.w500))))),
                SizedBox(height: 25.0),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Forgot Password?',
                      style: TextStyle(
                        fontSize: _textSize,
                      )),
                  SizedBox(width: 5.0),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResetPassword()));
                      },
                      child: Text('Here',
                          style: TextStyle(
                              color: _purple,
                              fontSize: _textSize,
                              decoration: TextDecoration.underline)))
                ]),
                SizedBox(height: 20.0),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Do not have an account?',
                      style: TextStyle(
                        fontSize: _textSize,
                      )),
                  SizedBox(width: 5.0),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text('Sign up',
                          style: TextStyle(
                            color: _purple,
                            fontSize: _textSize,
                            //decoration: TextDecoration.underline
                          )))
                ])
              ]),
            ),

      );

  }
}


class CurvePainter extends CustomPainter {
  CurvePainter({@required this.figureHeight});

  static const double _margin = 6;

  final double figureHeight;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color.fromRGBO(99, 5, 177, 1); //Colors.green[800];
    paint.style = PaintingStyle.fill; // Change this to fill
    final colors = [HexColor("#4C15D3"), HexColor("#6305B1")];
    final gradient = LinearGradient(
        begin: Alignment(6.123234262925839e-17, 1),
        end: Alignment(-1, 6.123234262925839e-17),
        //stops: [0.0,0.2,0.3],
        colors: [HexColor("#4C15D3"), HexColor("#6305B1")]);
    paint
      ..shader = gradient.createShader(Rect.fromCircle(
        center: Offset(0, 2 * 5 / 7),
        radius: 2 / 9,
      ));
    var path = Path();

    path.moveTo(0, size.height * 0.125);
    path.quadraticBezierTo(
        size.width / 1.6, figureHeight, size.width, size.height * 0.0625);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);

    // draw text
    final paragraphStyle = ParagraphStyle(textAlign: TextAlign.center);
    final textStyle = TextStyle(
        color: Colors.white, fontSize: 48, fontWeight: FontWeight.w700);
    final paragraphBuilder = ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle.getTextStyle())
      ..addText('Sign In');
    final paragraph = paragraphBuilder.build()
      ..layout(ParagraphConstraints(width: 250));
    canvas.drawParagraph(
        paragraph, Offset(paragraph.width * 2, paragraph.height));
    print(size.height);
  }

  @override
  bool shouldRepaint(CurvePainter oldDelegate) {
    return false;
  }
}

/*class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children : <Widget>[GradientAppBar("Custom Gradient App Bar"), Container()],);
  }
}


/class GradientAppBar extends StatelessWidget {

  final String title;
  final double barHeight = 50.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
        ),
      ),
    );
  }
}*/

/*class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: Container(
            child: AppBar(
              title: Text(widget.title),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.pinkAccent,
                  Colors.white,
                ],
              ),
            ),
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 45),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 1200),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter text",
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}*/
