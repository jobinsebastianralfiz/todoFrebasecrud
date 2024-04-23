import 'package:flutter/material.dart';
import 'package:tododemoapp/common/form_validator.dart';
import 'package:tododemoapp/models/teacher_model.dart';
import 'package:tododemoapp/services/teacher_service.dart';

class TeacherRegister extends StatefulWidget {
  const TeacherRegister({super.key});

  @override
  State<TeacherRegister> createState() => _TeacherRegisterState();
}

class _TeacherRegisterState extends State<TeacherRegister> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _deptController = TextEditingController();
  TextEditingController _qualifiController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                return Validator.validateEmail(value!);
              },
              controller: _emailController,
              decoration: InputDecoration(hintText: "Enter Email"),
            ),
            TextFormField(
              validator: (value) {
                return Validator.validateEmail(value!);
              },
              controller: _passController,
              decoration: InputDecoration(hintText: "Enter Password"),
            ),
            TextFormField(
              validator: (value) {
                return Validator.validateEmail(value!);
              },
              controller: _nameController,
              decoration: InputDecoration(hintText: "Enter Name"),
            ),
            TextFormField(
              validator: (value) {
                return Validator.validateEmail(value!);
              },
              controller: _phoneController,
              decoration: InputDecoration(hintText: "Enter Phone"),
            ),
            TextFormField(
              validator: (value) {
                return Validator.validateEmail(value!);
              },
              controller: _deptController,
              decoration: InputDecoration(hintText: "Enter department"),
            ),
            TextFormField(
              validator: (value) {
                return Validator.validateEmail(value!);
              },
              controller: _qualifiController,
              decoration: InputDecoration(hintText: "Enter Qualification"),
            ),
            ElevatedButton(
                onPressed: () async {
                  Teacher teacher = Teacher(
                      role: "teacher",
                      email: _emailController.text,
                      password: _passController.text,
                      name: _nameController.text,
                      phone: _phoneController.text,
                      department: _deptController.text,
                      qualification: _qualifiController.text);

                  TeacherService _teacherService = TeacherService();

                  await _teacherService.registerUser(teacher).then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'login', (route) => false));
                },
                child: Text("Register"))
          ],
        ),
      ),
    );
  }
}
