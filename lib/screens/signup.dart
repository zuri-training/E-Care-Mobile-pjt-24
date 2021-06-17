import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = new GlobalKey<FormState>();

  Color _purple = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildSignupForm())));
  }

  _buildSignupForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          SizedBox(height: 75.0),
          Container(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  Text('Signup',
                      style: TextStyle(fontFamily: 'Trueno', fontSize: 60.0)),
                  //Dot placement
                  Positioned(
                      top: 62.0,
                      left: 200.0,
                      child: Container(
                          height: 10.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: _purple)))
                ],
              )),
          SizedBox(height: 25.0),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'EMAIL',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 12.0,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _purple),
                )),
            /*onChanged: (value) {
    this.email = value;
    },
    validator: (value) =>
    value.isEmpty ? 'Email is required' : validateEmail(value)*/
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'PASSWORD',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 12.0,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _purple),
                )),
            obscureText: true,
            /*onChanged: (value) {
                this.password = value;
              },
              validator: (value) =>
              value.isEmpty ? 'Password is required' : null*/
          ),
          SizedBox(height: 50.0),
          GestureDetector(
            /*onTap: () {
          if (checkFields())
            AuthService().signUp(email, password).then((userCreds) {
              Navigator.of(context).pop();
            }).catchError((e) {
              ErrorHandler().errorDialog(context, e);
            });
        },*/
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.deepPurpleAccent,
                    color: _purple,
                    elevation: 7.0,
                    child: Center(
                        child: Text('SIGN UP',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go back',
                    style: TextStyle(
                        color: _purple,
                        fontFamily: 'Trueno',
                        decoration: TextDecoration.underline)))
          ])
        ],
      ),
    );
  }
}
