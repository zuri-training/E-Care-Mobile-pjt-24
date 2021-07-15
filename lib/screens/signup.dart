import 'package:e_care_mobile/Authentication/error_handler.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/userData/user.dart';
import 'package:e_care_mobile/util/colors.dart';
import 'package:e_care_mobile/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:page_transition/page_transition.dart';
import 'package:e_care_mobile/models/signup_model.dart';
import 'package:e_care_mobile/providers/auth.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Future<SignUpModel> signUpData;
  final formKey = new GlobalKey<FormState>();

  //To check fields during submit
  /*checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    setState(() {
      _autoValidate = true;
    });
    return false;
  }*/

  String validateName(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter a Valid Email';
    else
      return null;
  }

  // Image variable
  File _image;
  final picker = ImagePicker();

  // variable to check if file was uploaded
  bool _isFileUploaded = false;

  // Method to get image from user
  Future getImage() async {
    final pickedFile = dropdownValue == 'Camera'
        ? await picker.getImage(source: ImageSource.camera)
        : await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isFileUploaded = true;
      } else {
        print('No image selected.');
      }
    });
  }

  // Store Patient date of birth
  DateTime _dob;

  // date format
  final df = new DateFormat('dd-MM-yyyy');

  // TextEditingController Instances
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _patientFirstNameController =
      TextEditingController();
  final TextEditingController _patientSurnameController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const double figureHeight = 250;

  String dropdownValue = 'One';

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

  // variable to store if password is visible or not
  bool _obscureText = true;
  double heightValue = 120;

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
  }

  @override
  void dispose() {
    // Clean up the controller when widget is removed from the widget tree
    _dateController.dispose();
    _patientFirstNameController.dispose();
    _patientSurnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    // TODO: implement build
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Opacity(
                  opacity: auth.loggedInStatus == Status.Authenticating ||
                          auth.loggedInStatus == Status.LoggedIn
                      ? 0.4
                      : 1,
                  child: AbsorbPointer(
                    absorbing: auth.loggedInStatus == Status.Authenticating ||
                        auth.loggedInStatus == Status.LoggedIn,
                    child: Form(
                        key: formKey,
                        autovalidateMode: auth.autoValidate //_autoValidate
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        child: _buildSignupForm(context)),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: auth.registeredInStatus == Status.Registering
                      ? Center(child: loadingSpinner(48.0, 2.0))
                      : auth.registeredInStatus == Status.Registered
                          ? Center(
                              child: onComplete(
                                  "SignUp Success",
                                  Icons.check_circle,
                                  Colors.green.shade700,
                                  heightValue))
                          /*: auth.registeredInStatus == Status.Error
                      ? Center(
                      child: onFailure(auth.failure.toString(),
                          Icons.cancel, Colors.red.shade700))*/
                          : /*Form(
                      key: formKey,
                      autovalidateMode:
                      auth.autoValidate //_autoValidate
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: _buildSignupForm(context))*/
                          null,
                )
              ],
            )));
  }

  _buildSignupForm(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    // Ensure correct data was entered
    checkFields() {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        return true;
      }
      // Set auto validate to true
      auth.autoValidated();
      return false;
    }

    var signUp = () async {
      final response = await auth.signUp(
        _emailController.text,
        _passwordController.text,
        _patientFirstNameController.text,
        _patientSurnameController.text,
        _dateController.text,
      );

      if (response != null) {
        print('it worked');
        User user = response['user'];
        Future.delayed(Duration.zero, () async {
          Provider.of<UserProvider>(context, listen: false).setUser(user);
        });
        Future.delayed(Duration(milliseconds: 6000)).then(
            (value) => Navigator.pushReplacementNamed(context, '/otpForm'));
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            heightValue = 200.0;
            //bottom = 100;
          });
        });
      } else {
        // Error Alert dialog
        ErrorHandler().errorDialog(context, auth.failure.toString());
        /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
          content: Text(auth.failure.toString()),
        ));
        Future.delayed(Duration(milliseconds: 4000)).then(
                (value) => auth.delay());*/
      }
    };
    return SingleChildScrollView(
      //width: MediaQuery.of(context).size.width,
      /*CustomPaint(
        size: MediaQuery.of(context).size,
        painter: CurvePainter(figureHeight: figureHeight),
      ),*/
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 24, 24.0, 24.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 32.0),
          Text('Sign Up',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: lightgreen,
                  fontWeight: FontWeight.w700,
                  fontSize: 40)),
          SizedBox(height: 40.0),
          textHeaders('First Name'),
          textSection('e.g Amaks', _patientFirstNameController, 'First name'),
          SizedBox(height: 25.0),
          textHeaders('Surname'),
          textSection('e.g Obi', _patientSurnameController, 'Surname'),
          SizedBox(height: 25.0),
          textHeaders('Date of Birth'),
          dateField(),
          SizedBox(height: 25.0),
          textHeaders('Email'),
          emailSection(),
          SizedBox(height: 25.0),
          textHeaders('Password'),
          passwordField(),
          SizedBox(height: 36.0),
          // TODO Create separate component for add image
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Add a Profile Picture',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.w500,
                          height: 1),
                    ),
                  ),
                  //SizedBox(width: 2.0),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: _isFileUploaded
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            topRight: Radius.circular(4),
                                            bottomLeft: Radius.circular(4),
                                            bottomRight: Radius.circular(4),
                                          ),
                                          color:
                                              Color.fromRGBO(206, 205, 205, 1)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Change Photo',
                                            //textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    23, 43, 77, 1),
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                letterSpacing:
                                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                                fontWeight: FontWeight.normal,
                                                height: 1)),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            topRight: Radius.circular(4),
                                            bottomLeft: Radius.circular(4),
                                            bottomRight: Radius.circular(4),
                                          ),
                                          color:
                                              Color.fromRGBO(206, 205, 205, 1)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Choose a photo',
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(23, 43, 77, 1),
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        ),
                                      ),
                                    ),
                              iconSize: 0,
                              isExpanded: true,
                              elevation: 16,
                              focusColor: _lightGold,
                              style: TextStyle(color: HexColor("#172B4D")),
                              /*underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                            ),*/
                              onChanged: (newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                                getImage();
                              },
                              items: <String>[
                                'Camera',
                                'Upload Picture',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ))),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: _isFileUploaded ? true : false,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _image = null;
                            _isFileUploaded = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Delete',
                              //textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              _isFileUploaded
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        backgroundImage: FileImage(_image),
                        backgroundColor: Colors.transparent,
                        radius: 64,
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    )
            ],
          ),
          SizedBox(height: _isFileUploaded ? 30.0 : 48.0),
          GestureDetector(
              onTap: () {
                if (checkFields()) {
                  signUp();
                }
              },
              child: Container(
                  height: _textFieldHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: _textFieldShadow,
                          offset: Offset(0, 4),
                          blurRadius: 4)
                    ],
                    color: lightgreen,
                    // gradient: LinearGradient(
                    //     begin: Alignment(6.123234262925839e-17, 1),
                    //     end: Alignment(-1, 6.123234262925839e-17),
                    //     colors: [HexColor("#4C15D3"), HexColor("#6305B1")]),
                  ),
                  child: Center(
                      child: Text('SIGN UP',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: _textSize,
                              fontWeight: FontWeight.w500))))),
          SizedBox(height: 25.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Already have an account?',
                style: TextStyle(
                  fontSize: _textSize,
                )),
            SizedBox(width: 5.0),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Login(),
                          duration: Duration(seconds: 3),
                          type: PageTransitionType.bottomToTop));
                },
                child: Text('Sign in',
                    style: TextStyle(
                      color: lightgreen,
                      fontSize: _textSize,
                      //decoration: TextDecoration.underline
                    )))
          ]),
        ]),
      ),
    );
  }

  // Container for patient's full name
  Container textSection(
      String hintText, TextEditingController controller, String title) {
    return Container(
        decoration: boxDecoration(),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Theme(
            data: Theme.of(context).copyWith(primaryColor: lightgreen),
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
<<<<<<< HEAD
              decoration: buildDecoration(_purple, _textFieldBorderWidth,
=======

              decoration: buildDecoration(lightgreen, _textFieldBorderWidth,

              decoration: buildDecoration(_purple, _textFieldBorderWidth,

>>>>>>> 823da3d046761197a5f254e7731da7dbbbe97fb3
                  _textSize, Icons.person, hintText, false),
              validator: (value) =>
                  value.isNotEmpty && value.contains(new RegExp(r'^[a-zA-Z]+$'))
                      ? null
                      : '$title is required',
              /*value.isEmpty ? 'Name is required' : value.contains(
                  new RegExp(r'^[a-zA-Z\-\s]+$')) ? null : "Enter a valid name",*/
              textAlign: TextAlign.start,
              maxLines: 1,
              maxLength: 20,
              // controller: _locationNameTextController,
            ),
          ),
        ));
  }

  // Container for patient's full name and email fields
  Container emailSection() {
    return Container(
        decoration: boxDecoration(),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Theme(
            data: Theme.of(context).copyWith(primaryColor: _purple),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: buildDecoration(_purple, _textFieldBorderWidth,
                  _textSize, Icons.email, 'myemail@gmail.com', false),
              validator: (value) => validateEmail(value),
              textAlign: TextAlign.start,
              maxLines: 1,
              //maxLength: 20,
            ),
          ),
        ));
  }

  // Container for password fields
  Container passwordField() {
    return Container(
      //height: _textFieldHeight,
      constraints: BoxConstraints(minHeight: _textFieldHeight),
      decoration: boxDecoration(),
      child: TextFormField(
        controller: _passwordController,
        textInputAction: TextInputAction.done,
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
        // controller: _locationNameTextController,
      ),
    );
  }

  // Container for date field
  Container dateField() {
    return Container(
        //height: _textFieldHeight,
        width: MediaQuery.of(context).size.width,
        decoration: boxDecoration(),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            //focusNode: AlwaysDisabledFocusNode(),
            controller: _dateController,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            decoration: buildDecoration(_purple, _textFieldBorderWidth,
                _textSize, Icons.date_range, 'e.g 2021-June-19', false),
            onTap: () {
              _selectDate(context);
            },
            onChanged: (value) {
              this._dob = value as DateTime;
            },
            validator: (value) =>
                value.isEmpty ? 'Date of Birth is required' : null,
            textAlign: TextAlign.start,
            maxLines: 1,
            maxLength: 20,
            // controller: _locationNameTextController,
          ),
        ));
  }

  // Date picker
  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: DateTime.now(), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      _dob = date;
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);

    print(newSelectedDate);
    if (newSelectedDate != null) {
      _dob = newSelectedDate;
      _dateController
        ..text = DateFormat.yMMMd().format(_dob)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _dateController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
