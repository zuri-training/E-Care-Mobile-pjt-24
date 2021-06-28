import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/services/api.dart';
import 'package:e_care_mobile/userData/user.dart';
import 'package:e_care_mobile/util/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup.dart';
import 'reset_password.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'patient_dashboard.dart';
import 'package:e_care_mobile/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:e_care_mobile/util/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  static const double figureHeight = 250;

  // Network request ongoing
  bool _isLoading = false;

  bool _hasLoaded = false;

  // User wants to remain logged in app
  bool _stayLoggedIn = true;

  // auto validate text fields
  bool _autoValidate = false;

  // Text form field controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Colors
  Color _purple = HexColor("#6305B1");
  Color _purpleText = HexColor("#8237C1");
  Color _gold = HexColor("#F8B25A");
  Color _lightGold = HexColor("#FFE5C4");
  Color _darkGrey = HexColor("#4F4F4F");
  Color _grey = HexColor("#828282");
  Color _lightGrey = HexColor("#BDBDBD");

  // Text field container height
  double _textFieldHeight = 48;

  // Thickness of Text fields
  double _textFieldBorderWidth = 2;

  // Text size
  double _textSize = 14;

  // Text field box shadow
  Color _textFieldShadow = Color.fromRGBO(0, 0, 0, 0.5);

  // Hide password
  bool _obscureText = true;

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    setState(() {
      _autoValidate = true;
    });
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter a Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
    // TODO: implement build
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: auth.state ==
                Status.Loading //auth.loggedInStatus == Status.Authenticating
            ? Center(child: CircularProgressIndicator())
            : auth.state ==
                    Status.Completed //auth.loggedInStatus == Status.LoggedIn
                ? Center(
                    child: onComplete("Login Success", Icons.check_circle,
                        Colors.green.shade700))
                : auth.state ==
                        Status.Error //auth.loggedInStatus == Status.Error
                    ? Center(
                        child: Form(
                            key: formKey,
                            autovalidateMode: _autoValidate
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            child: _buildLoginForm(context)))
                    : Form(
                        key: formKey,
                        autovalidateMode: _autoValidate
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        child: _buildLoginForm(context)),
      ),
    ));
  }

  _buildLoginForm(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var usersLogin = () async {
      //var authService = new AuthService();
      final response = await auth.signIn(
        _emailController.text,
        _passwordController.text,
      );
      print('response: $response');

      if (response != null) {
        User user = response['user'];
        /*String token = response['user'];
        User use = Provider.of<UserProvider>(context, listen: false).user;
        Map<String, dynamic> userData= {
          'patientId': use.patientId,
          'firstname': use.firstname,
          'surname': use.surname,
          'email': use.email,
          'dob': use.dob,
          'token': token
        };
        User user = User.fromJson(userData);*/
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        //print(user.token);
        //print(user.email);

        Future.delayed(Duration(milliseconds: 4000)).then(
            (value) => Navigator.pushReplacementNamed(context, '/dashboard'));
        //
      } else {
        print('response');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
          content: Text(auth.failure.toString()),
        ));
      }
    };
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 24, 24.0, 24.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 32.0),
          Center(
            child: Text('Sign In',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 56)),
          ),
          SizedBox(height: 60.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Email',
                style: TextStyle(
                    fontSize: _textSize, fontWeight: FontWeight.w500)),
          ),
          Container(
            //height: _textFieldHeight,
              decoration: boxDecoration(),
              child: Theme(
                data: Theme.of(context).copyWith(primaryColor: _purple),
                child: TextFormField(
                  controller: _emailController,
                  decoration: buildDecoration(_purple, _textFieldBorderWidth,
                      _textSize, Icons.email, 'myemail@gmail.com', false),
                  validator: (value) => validateEmail(value),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  maxLength: 20,
                ),
              )),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Password',
                style: TextStyle(
                    fontSize: _textSize, fontWeight: FontWeight.w500)),
          ),
          Container(
            //height: _textFieldHeight,
            decoration: boxDecoration(),
            child: Theme(
              data: Theme.of(context).copyWith(primaryColor: _purple),
              child: TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                enableSuggestions: false,
                autocorrect: false,
                decoration: buildDecoration(
                  _purple,
                  _textFieldBorderWidth,
                  _textSize,
                  Icons.lock,
                  'Password',
                  true,
                  IconButton(
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
                ),
                validator: (value) => value.isEmpty
                    ? 'Password is required'
                    : value.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
                textAlign: TextAlign.start,
                maxLines: 1,
                maxLength: 20,
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Checkbox(
                  checkColor: Colors.white,
                  activeColor: _purple,
                  value: _stayLoggedIn,
                  onChanged: (bool newValue) {
                    setState(() {
                      print(newValue);
                      _stayLoggedIn = newValue;
                    });
                  }),
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
          auth.loggedInStatus == Status.Authenticating
              ? loading
              : GestureDetector(
                  onTap: () {
                    print(_emailController.text);
                    print(_passwordController.text);
                    if (/*_emailController.text != '' &&
                    _passwordController.text != ''*/
                        checkFields()) {
                      /*setState(() {
                    _isLoading = true;
                  });*/

                      //loginUser(_emailController.text, _passwordController.text);
                      // userLogin();
                      usersLogin();
                    }
                  },
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
                  child: signButton(_textFieldHeight, _textFieldShadow,
                      _textSize, 'SIGN IN')),
          SizedBox(height: 30.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Forgot Password?',
                style: TextStyle(
                  fontSize: _textSize,
                )),
            SizedBox(width: 5.0),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: ResetPassword(),
                          duration: Duration(seconds: 3),
                          type: PageTransitionType.bottomToTop));
                },
                child: Text('Here',
                    style: TextStyle(
                      color: _purple,
                      fontSize: _textSize,
                    )))
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
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Signup(),
                          duration: Duration(seconds: 3),
                          type: PageTransitionType.rightToLeftWithFade));
                },
                child: Text('Sign up',
                    style: TextStyle(
                      color: _purple,
                      fontSize: _textSize,
                    )))
          ])
        ]),
      ),
    );
  }

  loginUser(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var dio = Dio();
    var formData = FormData.fromMap({
      'email': email,
      'password': password,
    });
    dio.options.connectTimeout = 50000;
    dio.options.receiveTimeout = 30000;
    dio.options.sendTimeout = 30000;

    var response = await dio.post(
        'https://harvest-rigorous-bambiraptor.glitch.me/api/v1/patient/login',
        data: {
          'email': email,
          'password': password,
        });
    var jsonResponse;

    if (response.statusCode == 200) {
      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      jsonResponse = response.data;
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        print(jsonResponse['data']['token']);

        if (_stayLoggedIn == true) {
          // Store token in shared prefs to keep user signed in
          sharedPreferences.setString("token", jsonResponse['data']['token']);
          sharedPreferences.setString(
              "patientId", jsonResponse['data']['patientId']);
        }
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => PatientDashboard()),
            (Route<dynamic> route) => false);
      } else {
        // TODO HANDLE ERROR AND DISPLAY MESSAGE TO UI
        setState(() {
          _isLoading = false;
        });
        print(response.data);
      }
    }
  }

  userLogin() async {
    var authService = new AuthService();

    // login user request
    var response = await authService.login(
      _emailController.text,
      _passwordController.text,
    );
    // Shared preference instance
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // if there is response
    if (response != null) {
      setState(() {
        _isLoading = false;
      });
      print(response['data']['token']);

      if (_stayLoggedIn == true) {
        // Store token in shared prefs to keep user signed in
        sharedPreferences.setString("token", response['data']['token']);
        sharedPreferences.setString("patientId", response['data']['patientId']);
      }
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => PatientDashboard()),
          (Route<dynamic> route) => false);
    }
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
