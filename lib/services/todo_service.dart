import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo_model.dart';

class TodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'todos';

  Future<void> addTodo(TodoModel todo) async {
    try {
      await _firestore.collection(_collectionName).doc(todo.id).set({
        'title': todo.title,
        'desc': todo.desc,
        'id':todo.id,
        'status': todo.status,
        'createdAt': todo.createdAt,
        'img': "",
        'uid': todo.uid,
        'updatedAt': todo.createdAt
      });
    } catch (e) {
      print("Error adding todo: $e");
    }
  }

  Future<void> updateTodo(TodoModel todo) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(todo.title) // Assuming title is unique
          .update(todo.toMap());
    } catch (e) {
      print("Error updating todo: $e");
    }
  }

  Future<void> deleteTodo(String title) async {
    try {
      await _firestore.collection(_collectionName).doc(title).delete();
    } catch (e) {
      print("Error deleting todo: $e");
    }
  }

  Stream<List<TodoModel>> getTodos(String uid) {
    try {
      return _firestore.collection(_collectionName).where('uid',isEqualTo:uid ).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => TodoModel.fromJson(doc.data()))
              .toList());
    } catch (e) {
      print("Error getting todos: $e");
      return Stream.empty();
    }
  }





  Future<List<TodoModel>> getAllTodosUser(String uid) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(_collectionName)
          .where('uid', isEqualTo: uid)
          .get();

      List<TodoModel> todos = querySnapshot.docs
          .map((doc) => TodoModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return todos;
    } catch (e) {
      print("Error getting todos: $e");
      return []; // or throw an error if needed
    }
  }

}
