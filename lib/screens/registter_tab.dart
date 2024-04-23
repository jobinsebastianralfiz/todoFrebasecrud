import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:tododemoapp/screens/register_page.dart';
import 'package:tododemoapp/screens/teacher_registeration.dart';

class RegisterTab extends StatelessWidget {
  const RegisterTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(

            bottom: const TabBar(
              padding: EdgeInsets.all(20),
              labelPadding: EdgeInsets.all(10),
              indicatorColor: Colors.orange,
              labelStyle: TextStyle(color: Colors.orange),
              tabs: [
              Text("User Registration"),
                Text("Teacher Registration"),

              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
             RegisterPage(),
              TeacherRegister()

            ],
          ),
        ),
      ),
    );
  }
}