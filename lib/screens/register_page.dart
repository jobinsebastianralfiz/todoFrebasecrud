// email password name phone user role

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tododemoapp/common/form_validator.dart';
import 'package:tododemoapp/models/user_model.dart';
import 'package:tododemoapp/services/user_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final _regKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> roles = [
    'user',
    'moderator',
  ];

  String? selectedRole;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _regKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Create an account"),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  return Validator.validateEmail(value!);
                },
                controller: _emailController,
                decoration: InputDecoration(hintText: "Enter Email"),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  return Validator.validatePassword(value!);
                },
                controller: _passwordController,
                decoration: InputDecoration(hintText: "Enter Passwod"),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  return Validator.validateString(value!);
                },
                controller: _nameController,
                decoration: InputDecoration(hintText: "Enter Name"),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  return Validator.validatePhoneNumber(value!);
                },
                controller: _phoneController,
                decoration: InputDecoration(hintText: "Enter Mobile"),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                value: selectedRole, // Assign selectedRole to value
                items: roles
                    .map((item) =>
                        DropdownMenuItem(value: item, child: Text(item)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRole = value
                        as String; // Cast value to String and assign to selectedRole
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  // validate
                  // do thelogic

                  if (_regKey.currentState!.validate()) {


                    try{


                      UserModel user = UserModel(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          phone: _phoneController.text,
                          role: selectedRole,
                          createdAt: DateTime.now(),
                          status: 1);

                      UserService userService = UserService();
                      final res = await userService.registerUser(user);

                      if (res == "") {
                        Navigator.pushReplacementNamed(context, 'login');
                      }
                    }on FirebaseAuthException catch (e) {
                      // Handle FirebaseAuthException here
                      print('Firebase Auth Exception: ${e.message}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Firebase Auth Error: ${e.message}"),
                        ),
                      );
                    } catch (e) {
                      // Catch any other type of exception
                      print('Error: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Error: $e"),
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  height: 55,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account"),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'login');
                      },
                      icon: Icon(Icons.arrow_forward))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
