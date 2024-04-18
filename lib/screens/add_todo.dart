import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tododemoapp/common/form_validator.dart';
import 'package:tododemoapp/models/todo_model.dart';
import 'package:tododemoapp/services/todo_service.dart';
import 'package:uuid/uuid.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _decController = TextEditingController();

  final _todoKey = GlobalKey<FormState>();

  String? uid;

  getData() async{

    uid=await FirebaseAuth.instance.currentUser!.uid;
    print("***********************");
    print(uid);
    print("***********************");
  }
  @override
  void initState() {


    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _todoKey,
          child: Column(
            children: [
              Text("Add New Todo"),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(hintText: "Enter Title"),
                validator: (value) {
                  return Validator.validateString(value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Enter Description"),
                controller: _decController,
                validator: (value) {
                  return Validator.validateString(value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              InkResponse(
                splashColor: Colors.purple.withOpacity(0.2),
                onTap: () async {
                  if (_todoKey.currentState!.validate()) {

                    var todoid=Uuid().v1();

                    TodoModel _todo = TodoModel(
                        title: _titleController.text,
                        desc: _decController.text,
                        status: 1,
                        uid: uid,
                        id: todoid,
                        createdAt: DateTime.now());

                    TodoService _todoService = TodoService();

                    await _todoService
                        .addTodo(_todo)
                        .then((value) => Navigator.pop(context));
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
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
