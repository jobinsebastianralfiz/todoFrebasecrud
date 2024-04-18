// email password

import 'package:flutter/material.dart';
import 'package:tododemoapp/common/form_validator.dart';
import 'package:tododemoapp/services/user_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login to your accoun"),
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
              InkWell(
                onTap: () async {
                  // validate
                  // do thelogic

                  if (_loginKey.currentState!.validate()) {
                    UserService _userService = UserService();

                    final userData = await _userService.loginUser(
                        _emailController.text, _passwordController.text);

                    if (userData != null) {
                      if (userData['role'] == 'user') {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'userhome',
                          (route) => false,
                        );
                      } else if (userData['role'] == "moderator") {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'modhome',
                          (route) => false,
                        );
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'adminhome',
                          (route) => false,
                        );
                      }
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
                      "Login",
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
                  Text("Create Account"),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
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
