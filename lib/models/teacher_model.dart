import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  String? id;
  final String email;
  final String password;
  final String name;
  final String phone;
  final String department;
  final String qualification;
  final String role;

  Teacher({
    this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.department,
    required this.qualification,
    required this.role
  });

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'department': department,
      'qualification': qualification,
      'role':role
    };
  }

  factory Teacher.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Teacher(
      role: json['role'],
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phone: json['phone'],
      department: json['department'],
      qualification: json['qualification'],
    );
  }
}
