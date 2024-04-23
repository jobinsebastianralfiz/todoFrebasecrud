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

      final usermodel=UserModel(
          role: user.role,

          email:user.email,
          uid: userResponse.user!.uid,
          password:user.password,
          name: user.name, phone: user.phone,

        );


      FirebaseFirestore.instance
          .collection('login')
          .doc(userResponse.user!.uid)
          .set({

        'uid':usermodel.uid,
        'role':usermodel.role,
        'email':usermodel.email
      });

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


}
