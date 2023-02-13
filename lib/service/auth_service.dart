import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterchatapp/helper/helper_function.dart';
import 'package:flutterchatapp/service/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login with email and password
  Future loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      User user = (await FirebaseAuth.instance
          .signInWithEmailAndPassword(password: password, email: email))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }


  // register with fullName and email and password
  Future registerUserWithEmailAndPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await FirebaseAuth.instance
          .createUserWithEmailAndPassword(password: password, email: email))
          .user!;
      if (user != null) {
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  // sign out
  Future signOut() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserEmailSF("");
      await HelperFunction.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}

