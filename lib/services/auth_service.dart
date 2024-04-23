import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tododemoapp/models/user_model.dart';

class AuthService {
  // register
  //login
  // logout
  //alrady logined



  Future<DocumentSnapshot> loginUser(String? email, String password) async {
    UserCredential userData = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email.toString(), password: password.toString());

    final teacherSnap = await FirebaseFirestore.instance
        .collection('login')
        .doc(userData!.user!.uid)
        .get();
    var token = await userData.user!.getIdToken();

    if(teacherSnap['role']=="teacher"){

      final teacherSnap = await FirebaseFirestore.instance
          .collection('teacher')
          .doc(userData!.user!.uid)
          .get();

      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString('token', token!);
      _pref.setString('name', teacherSnap['name']);
      _pref.setString('email', teacherSnap['email']);
      _pref.setString('phone', teacherSnap['phone']);
      _pref.setString('dept', teacherSnap['department']);

      _pref.setString('role', teacherSnap['role']);

    }else if(teacherSnap['role']=='user'){


      final teacherSnap = await FirebaseFirestore.instance
          .collection('user')
          .doc(userData!.user!.uid)
          .get();
      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString('token', token!);
      _pref.setString('name', teacherSnap['name']);
      _pref.setString('email', teacherSnap['email']);
      _pref.setString('phone', teacherSnap['phone']);


      _pref.setString('role', teacherSnap['role']);


    }



    return teacherSnap;
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
