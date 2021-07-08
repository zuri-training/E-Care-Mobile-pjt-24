import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class Authentication {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    final firestoreInstance = FirebaseFirestore.instance;
    // TODO: Add auto login logic

    return firebaseApp;
  }

  /*static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }*/

  //Signup a new user
  static Future<UserCredential> signUp(String email, String password,
      String firstname, String surname, String dob, context) async {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print('user: $result');

    User user = result.user;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
    await FirebaseFirestore.instance.collection('patients').doc(user.uid).set({
      'firstName': firstname,
      'surname': surname,
      'email': email,
      'dob': dob
    });

    try {} on FirebaseException catch (e) {
      //throw FireStoreException(e.message);
    }

    return result;
  }

  //Sign In
  static login(String email, String password, context) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((val) {
      print('signed in');
    });
  }
}
