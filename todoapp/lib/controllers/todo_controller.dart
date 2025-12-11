import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/todo.dart';

class TodoController extends ChangeNotifier {

  List<Todo> todos = [];
  List<Todo> filteredTodos = [];
  String _filter = '';

  void applyFilter(String query) {
    _filter = query;
    if (_filter.trim().isEmpty) {
      filteredTodos = [...todos];
    } else {
      filteredTodos = todos.where((item) => item.task.toLowerCase().contains(_filter.toLowerCase())).toList();
    }
    notifyListeners();
  }

  void saveTodos() async {
    var pref = await SharedPreferences.getInstance();

    var todosJson = todos.map((todo) => todo.toJson()).toList();
    await pref.setString("todos", jsonEncode(todosJson));
    await loadTodos();
    notifyListeners();
  }

  Future<void> loadTodos() async {
    var pref = await SharedPreferences.getInstance();
    var data = pref.getString("todos");

    if (data != null) {
      List decodedList = jsonDecode(data);
      todos = decodedList.map((e) => Todo.fromJson(e)).toList();
      applyFilter(_filter);
      notifyListeners();
    }
  }

  void addTodo(String task, DateTime dt, String description) {
    final newTodo = Todo(task: task, dateTime: dt, description:description );
    todos.add(newTodo);
    applyFilter(_filter);
    notifyListeners();
    saveTodos();
  }

  void toggleCompleteByTodo(Todo todo) {
    final idx = todos.indexOf(todo);
    if (idx != -1) {
      todos[idx].isComplete = !todos[idx].isComplete;
      applyFilter(_filter);
      saveTodos();
    }
  }

  void removeTodoByTodo(Todo todo) {
    final idx = todos.indexOf(todo);
    if (idx != -1) {
      todos.removeAt(idx);
      applyFilter(_filter);
      saveTodos();
    }
  }

  // ---------- UPDATE TODO ----------
  void updateTodo(int index, String newTask, DateTime dt, String des) {
    if (index >= 0 && index < todos.length) {
      todos[index].task = newTask;
      todos[index].dateTime = dt;
      todos[index].description = des;
      applyFilter(_filter);
      saveTodos();
    }
  }

  // Update by Todo object (works with filtered lists)
  void updateTodoByTodo(Todo todo, String newTask, DateTime dt, String des) {
    final idx = todos.indexOf(todo);
    if (idx != -1) {
      todos[idx].task = newTask;
      todos[idx].dateTime = dt;
      todos[idx].description = des;
      applyFilter(_filter);
      saveTodos();
    }
  }

  List<Todo> completedTodos() {
    return todos.where((todo) => todo.isComplete == true).toList();
  }

  List<Todo> inCompletedTodos() {
    return todos.where((todo) => todo.isComplete == false).toList();
  }
}
 