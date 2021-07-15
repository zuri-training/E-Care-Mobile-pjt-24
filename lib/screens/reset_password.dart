import 'package:carbon_icons/carbon_icons.dart';
import 'package:e_care_mobile/Authentication/error_handler.dart';
import 'package:e_care_mobile/providers/auth.dart';
import 'package:e_care_mobile/screens/checkyouremail.dart';
import 'package:e_care_mobile/services/api.dart';
import 'package:e_care_mobile/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _email = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    /// Valid Email
    _validEmail() {
      var _validateEmail = validateEmail(_email.text);
      if (_validateEmail == null) {
        return true;
      }
      setState(() {
        _validate = true;
      });
      return false;
    }

    /// Reset Password
    resetPassword() async {
      // Reset request
      final response = await auth.forgotPassword(
        _email.text,
      );

      if (response['status']) {
        // Navigate to check email page
        Future.delayed(Duration(milliseconds: 4000)).then((value) =>
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CheckYourEmail())));
      } else {
        // Error Alert dialog
        ErrorHandler().errorDialog(context, auth.failure.toString());
      }
    }

    ;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white12,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              top: 0,
              bottom: 8,
            ),
            child: InkWell(
              child: Icon(
                CarbonIcons.menu,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: auth.passwordStatus == Status.Loading
              ? Center(child: CircularProgressIndicator())
              : auth.passwordStatus == Status.Completed
                  ? Center(
                      child: onComplete("Password Reset Successful",
                          Icons.check_circle, Colors.green.shade700, 0))
                  : SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 40),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Color(0xff6305B1),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Icon(
                                      CarbonIcons.locked,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'RESET PASSWORD',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 5, right: 1)),
                                Flexible(
                                  child: Container(
                                    padding: new EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      'Enter the email associated with your account and we\'ll \nsend '
                                      'an email with instructions to reset your password.',
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                  left: 10,
                                  right: 20,
                                  top: 30,
                                )),
                                Flexible(
                                  child: Text(
                                    'Email address',
                                    maxLines: 3,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    right: 20,
                                    top: 0,
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _email,
                                    decoration: InputDecoration(
                                      hintText: 'Enter email address',
                                      errorText: _validate == true
                                          ? validateEmail(_email.text)
                                          : null,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff6305B1),
                                            width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff6305B1),
                                            width: 1.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xff6305B1),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 10,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 70),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height:
                                      MediaQuery.of(context).size.height / 13,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      primary: Color(0xff6305B1),
                                    ),
                                    onPressed: () {
                                      if (_validEmail()) {
                                        resetPassword();
                                      }
                                    },
                                    child: Text(
                                      'SEND INSTRUCTIONS',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  // TODO ADD THIS TO SEND INSTRUCTION BUTTON TO MAKE REQUEST TO SERVER
  forgotPassword(String email) async {
    AuthService authInfo = AuthService();
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var response = await authInfo.forgotPassword(email);
    print(response);
    if (response != null) {
      setState(() {
        //_isLoading = false;
      });
      print(response['data']['token']);

      /*if (_stayLoggedIn == true) {
          // Store token in shared prefs to keep user signed in
          sharedPreferences.setString("token", jsonResponse['data']['token']);
        }*/
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => CheckYourEmail()),
          (Route<dynamic> route) => false);
    }
  }
}
