import 'package:e_care_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'reset_password.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:page_transition/page_transition.dart';
import 'package:e_care_mobile/services/api.dart';
import 'package:e_care_mobile/models/signup_model.dart';
import 'package:dio/dio.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Future<SignUpModel> signUpData;
  final formKey = new GlobalKey<FormState>();

  // Variable for email and password
  String email, password, fullName;

  // Network request ongoing
  bool _isLoading = false;

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

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

  /*@override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final String text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: 'dob.toString()',
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
      print(_dob);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
*/
  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    // TODO Implement listeners on controllers
    /*_dateController.addListener();
    _patientNameController.addListener();
    _emailController.addListener();
    _passwordController.addListener();*/
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _dateController.dispose();
    _patientFirstNameController.dispose();
    _patientSurnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: _buildSignupForm())));
  }

  _buildSignupForm() {
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
          Center(
            child: Text('Sign Up',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 56)),
          ),
          /*SizedBox(height: 32.0),
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
                      child: Text('Sign Up with Google',
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
          ]),*/
          SizedBox(height: 40.0),
          textHeaders('First Name'),
          textSection('e.g Amaks', _patientFirstNameController, 'First name'),
          SizedBox(height: 25.0),
          textHeaders('Surname'),
          textSection('e.g Amaks', _patientSurnameController, 'Surname'),
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
                  setState(() {
                    _isLoading = true;
                  });
                  createUser(
                      _patientFirstNameController.text,
                      _patientSurnameController.text,
                      _emailController.text,
                      _dateController.text,
                      _passwordController.text,
                      _image);
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
                                  child: Text('SIGN UP',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: _textSize,
                                          fontWeight: FontWeight.w500))))),*/
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
                    color: Color.fromRGBO(99, 5, 177, 1),
                    gradient: LinearGradient(
                        begin: Alignment(6.123234262925839e-17, 1),
                        end: Alignment(-1, 6.123234262925839e-17),
                        colors: [HexColor("#4C15D3"), HexColor("#6305B1")]),
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
                      color: _purple,
                      fontSize: _textSize,
                      //decoration: TextDecoration.underline
                    )))
          ]),
        ]),
      ),
    );
  }

  /*FutureBuilder<SignUpModel> buildFutureBuilder() {
    return FutureBuilder<SignUpModel>(
      //future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }*/
  // Container for patient's full name and email fields
  Container textSection(
      String hintText, TextEditingController controller, String title) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Theme(
            data: Theme.of(context).copyWith(primaryColor: _purple),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: hintText,
                //labelText: 'Email',
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.2), fontSize: _textSize),
                isDense: true,
                counterText: "",
                contentPadding: EdgeInsets.all(10.0),
                filled: true,
                fillColor: Colors.white,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  borderSide: BorderSide(
                      color: Colors.red, width: _textFieldBorderWidth),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    borderSide: BorderSide(
                        color: _purple,
                        style: BorderStyle.solid,
                        width: _textFieldBorderWidth)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    borderSide: BorderSide(
                        color: _purple,
                        style: BorderStyle.solid,
                        width: _textFieldBorderWidth)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    borderSide: BorderSide(
                        color: _purple,
                        style: BorderStyle.solid,
                        width: _textFieldBorderWidth)),
              ),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Theme(
            data: Theme.of(context).copyWith(primaryColor: _purple),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                hintText: 'myemail@gmail.com',
                //labelText: 'Email',
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.2), fontSize: _textSize),
                isDense: true,
                counterText: "",
                contentPadding: EdgeInsets.all(10.0),
                filled: true,
                fillColor: Colors.white,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  borderSide: BorderSide(
                      color: Colors.red, width: _textFieldBorderWidth),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    borderSide: BorderSide(
                        color: _purple,
                        style: BorderStyle.solid,
                        width: _textFieldBorderWidth)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    borderSide: BorderSide(
                        color: _purple,
                        style: BorderStyle.solid,
                        width: _textFieldBorderWidth)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    borderSide: BorderSide(
                        color: _purple,
                        style: BorderStyle.solid,
                        width: _textFieldBorderWidth)),
              ),
              validator: (value) => validateEmail(value),
              textAlign: TextAlign.start,
              maxLines: 1,
              maxLength: 20,
              // controller: _locationNameTextController,
            ),
          ),
        ));
  }

  // Container for password fields
  Container passwordField() {
    return Container(
      //height: _textFieldHeight,
      constraints: BoxConstraints(minHeight: _textFieldHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscureText,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: const Icon(Icons.lock),
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
              color: Colors.black.withOpacity(0.2), fontSize: _textSize),
          isDense: true,
          counterText: "",
          contentPadding: EdgeInsets.all(10.0),
          filled: true,
          fillColor: Colors.white,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
            borderSide:
                BorderSide(color: Colors.red, width: _textFieldBorderWidth),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
              borderSide: BorderSide(
                  color: _purple,
                  style: BorderStyle.solid,
                  width: _textFieldBorderWidth)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
              borderSide: BorderSide(
                  color: _purple,
                  style: BorderStyle.solid,
                  width: _textFieldBorderWidth)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
              borderSide: BorderSide(
                  color: _purple,
                  style: BorderStyle.solid,
                  width: _textFieldBorderWidth)),
        ),
        onChanged: (value) {
          this.email = value;
        },
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(8),
          ),
          /*boxShadow: [
            BoxShadow(
                color: _textFieldShadow,
                offset: Offset(0, 4),
                blurRadius: 4)
          ],
          color: Color.fromRGBO(255, 255, 255, 1),
          border: Border.all(
            color: /*Color.fromRGBO(77, 77, 77, 1)*/ _purple,
            width: _textFieldBorderWidth,
          ),*/
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            focusNode: AlwaysDisabledFocusNode(),
            controller: _dateController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.date_range),
              hintText: 'e.g 2021-June-19',
              //labelText: 'Email',
              hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.2), fontSize: _textSize),
              isDense: true,
              counterText: "",
              contentPadding: EdgeInsets.all(10.0),
              filled: true,
              fillColor: Colors.white,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                borderSide:
                    BorderSide(color: Colors.red, width: _textFieldBorderWidth),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  borderSide: BorderSide(
                      color: _purple,
                      style: BorderStyle.solid,
                      width: _textFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  borderSide: BorderSide(
                      color: _purple,
                      style: BorderStyle.solid,
                      width: _textFieldBorderWidth)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  borderSide: BorderSide(
                      color: _purple,
                      style: BorderStyle.solid,
                      width: _textFieldBorderWidth)),
            ),
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

  // Component for header of respective fields
  Padding textHeaders(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title,
          style: TextStyle(fontSize: _textSize, fontWeight: FontWeight.w500)),
    );
  }

  createUser(String firstname, String lastname, String email, String dob,
      String password,
      [File file]) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //String fileName = file.path.split('/').last;
    var dio = Dio();
    var formData = FormData.fromMap({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'dob': dob,
      'password': password,
      //'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var response = await dio.post(
        'https://harvest-rigorous-bambiraptor.glitch.me/api/v1/patient/create',
        data: formData);

    var jsonResponse;
    print(response.statusCode);
    if (response.statusCode == 200) {
      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      jsonResponse = response.data;
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        print(jsonResponse['data']['token']);
        // Store token in shared prefs to keep user signed in
        //sharedPreferences.setString("token", jsonResponse['data']['token']);
        //print(sharedPreferences.get(key));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Login()),
            (Route<dynamic> route) => false);
      }
    } else {
      // TODO HANDLE ERROR AND DISPLAY MESSAGE TO UI
      print('404 there');
      setState(() {
        _isLoading = false;
      });
      print(response.data);
    }
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
