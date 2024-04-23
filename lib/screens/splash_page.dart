import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tododemoapp/services/auth_service.dart';
import 'package:tododemoapp/services/user_services.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
 AuthService _authService = AuthService();
  bool isLogin = false;
  var role;

  checkLogin() async {
    isLogin = await _authService.isLoggedin();

    if (isLogin == true) {
      if (role == 'user') {
        Navigator.pushNamedAndRemoveUntil(
            context, 'userhome', (route) => false);
      } else if (role == 'teacher') {
        Navigator.pushNamedAndRemoveUntil(context, 'modhome', (route) => false);
      } else if (role == 'admin') {
        Navigator.pushNamedAndRemoveUntil(
            context, 'adminhome', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
      }
    }else {
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    }
  }

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    role = await _pref.getString('role');
  }

  @override
  void initState() {
    getData();
    Future.delayed(Duration(seconds:5), () {
     checkLogin();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("TodoApp"),
      ),
    );
  }
}
