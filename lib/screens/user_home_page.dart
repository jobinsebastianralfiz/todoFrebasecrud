import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tododemoapp/models/todo_model.dart';
import 'package:tododemoapp/services/user_services.dart';

import 'package:tododemoapp/services/todo_service.dart'; // Import your TodoService

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var name;
  final TodoService _todoService = TodoService(); // Instantiate TodoService

  String? uid;

  getData() async {
    uid = await FirebaseAuth.instance.currentUser!.uid;
    print("***********************");
    print(uid);

    print("***********************");

    setState(() {

    });
  }

  @override
  void initState() {



      getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'addtodo');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title: Text("User Home"),
        actions: [
          IconButton(
            onPressed: () {
              UserService().logout().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'login', (route) => false));
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Expanded(
              //     child: StreamBuilder(
              //         stream: _todoService.getTodos(uid!),
              //         builder: (context, snapshot) {
              //           if (snapshot.connectionState ==
              //               ConnectionState.waiting) {
              //             return Center(
              //               child: CircularProgressIndicator(),
              //             );
              //           } else if (snapshot.hasError) {
              //             return Text('Error: ${snapshot.error}');
              //           }else{
              //
              //
              //             List<TodoModel> todos = snapshot.data ?? [];
              //
              //             if(todos.isEmpty){
              //
              //               return Center(
              //                 child: Text("No Todos Added"),
              //               );
              //
              //             }else{
              //
              //               return ListView.builder(
              //                   itemCount: todos.length,
              //                   itemBuilder: (context,index){
              //                     return ListTile(
              //                       title: Text(todos[index].title),
              //                       subtitle: Text(todos[index].desc),
              //                     );
              //                   }
              //
              //               );
              //
              //
              //             }
              //
              //
              //
              //           }
              //         }))

              // Expanded(
              //   child: StreamBuilder<List<Todo>>(
              //     stream: _todoService.getTodos(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return CircularProgressIndicator();
              //       } else if (snapshot.hasError) {
              //         return Text('Error: ${snapshot.error}');
              //       } else {
              //         List<Todo> todos = snapshot.data ?? [];
              //         if (todos.isEmpty) {
              //           return Text('No todos available.');
              //         } else {
              //           return ListView.builder(
              //             itemCount: todos.length,
              //             itemBuilder: (context, index) {
              //               return ListTile(
              //                 title: Text(todos[index].title),
              //                 subtitle: Text(todos[index].desc),
              //                 // You can display more todo details here if needed
              //               );
              //             },
              //           );
              //         }
              //       }
              //     },
              //   ),
              // ),






              Expanded(
                child: FutureBuilder(
                  future: _todoService.getAllTodosUser(uid!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<TodoModel> todos = snapshot.data ?? [];
                      if (todos.isEmpty) {
                        return Center(
                          child: Text("No Todos Added"),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(todos[index].title),
                              subtitle: Text(todos[index].desc),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Implement edit functionality here
                                      // For example, navigate to edit screen
                                      // and pass todo uid to edit
                                      Navigator.pushNamed(context, 'addtodo',
                                          arguments: todos[index]);
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // Implement delete functionality here
                                     _todoService.deleteTodo(todos[index].id.toString());
                                     setState(() {

                                     });

                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
