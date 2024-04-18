import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tododemoapp/firebase_options.dart';
import 'package:tododemoapp/screens/add_todo.dart';
import 'package:tododemoapp/screens/admin_home.dart';
import 'package:tododemoapp/screens/aoderator_home.dart';
import 'package:tododemoapp/screens/login_page.dart';
import 'package:tododemoapp/screens/register_page.dart';
import 'package:tododemoapp/screens/splash_page.dart';
import 'package:tododemoapp/screens/user_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {


        '/':(context)=>SplashPage(),
        'login':(context)=>LoginPage(),
        'register':(context)=>RegisterPage(),
        'userhome':(context)=>UserHome(),
        'modhome':(context)=>ModeratorHome(),
        'adminhome':(context)=>AdminHome(),

        'addtodo':(context)=>AddTodo()
      },
    debugShowCheckedModeBanner: false,

    );
  }
}
