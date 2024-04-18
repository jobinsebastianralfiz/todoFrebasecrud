import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tododemoapp/models/user_model.dart';

class UserService {
  // register
  //login
  // logout
  //alrady logined

  Future<String?> registerUser(UserModel user) async {
    try {
      UserCredential userResponse = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email.toString(), password: user.password.toString());

      user.uid = userResponse.user!.uid;
      print(user.uid);
      print(user.name);

      FirebaseFirestore.instance
          .collection('user')
          .doc(userResponse.user!.uid)
          .set(user.toMap());

      return "";
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Exception: ${e.message}');
      return e.message; // Return Firebase Auth error message
    } catch (e) {
      print('Error: $e');
      return 'Registration failed: $e'; // Return generic error message
    }
  }

  Future<DocumentSnapshot> loginUser(String? email, String password) async {
    UserCredential userData = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.toString(), password: password.toString());

    final userSnap = await FirebaseFirestore.instance
        .collection('user')
        .doc(userData!.user!.uid)
        .get();
    var token = await userData.user!.getIdToken();

    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('token', token!);
    _pref.setString('name', userSnap['name']);
    _pref.setString('email', userSnap['email']);
    _pref.setString('phone', userSnap['phone']);

    _pref.setString('role', userSnap['role']);



    return userSnap;
  }

  Future<void>logout()async{

    SharedPreferences _pref=await SharedPreferences.getInstance();
    _pref.clear();

    await FirebaseAuth.instance.signOut();


  }



  Future<bool> isLoggedin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? _token = await pref.getString('token');

    // checking if there a token
    if (_token == null) {
      return false;
    } else {
      return true;
    }
  }
}
