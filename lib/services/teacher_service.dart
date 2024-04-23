import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tododemoapp/models/teacher_model.dart';

class TeacherService{


  Future<String?> registerUser(Teacher user) async {
    try {
      UserCredential userResponse = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: user.email.toString(), password: user.password.toString());

     final teacher=Teacher(
         role: user.role,
         email:user.email,
         id: userResponse.user!.uid,
         password:user.password,
         name: user.name, phone: user.phone,
         department: user.department,
         qualification: user.qualification);

      FirebaseFirestore.instance
          .collection('login')
          .doc(userResponse.user!.uid)
          .set({

        'uid':teacher.id,
        'role':teacher.role,
        'email':teacher.email
      });


      FirebaseFirestore.instance
          .collection('teacher')
          .doc(userResponse.user!.uid)
          .set(teacher.toJson());

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