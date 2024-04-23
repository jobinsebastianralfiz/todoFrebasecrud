// blue print
// email, pass, id, name, mobile, createdat status

// methods

// to firebase
// from firebase

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  String?phone;

  String? role;
  int? status;
  DateTime? createdAt;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.password,
      this.createdAt,
      this.status,
        this.phone,
      this.role});



  // fromJson
// Convert DocumentSnapshot to UserModel object
  factory UserModel.fromJoson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      name: data['name'],
      email: data['email'],
      password: data['password'],
      role: data['role'],
      phone: data['phone'],
      status: data['status'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert UserModel object to Map
  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'status': status,
      'phone':phone,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }




// toMap



}
