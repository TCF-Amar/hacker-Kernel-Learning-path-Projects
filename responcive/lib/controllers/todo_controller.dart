import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mytodoapp/model/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoController extends ChangeNotifier {
  List<Todo> todos = [];
  List<Todo> filteredTodo = [];
  List<Todo> completedTodos = [];
  List<Todo> inCompletedTodos = [];
  List<Todo> isPinned = [];

  String _filter = "";
  final key = "todos";
  Map<String, int> priorityOrder = {"High": 1, "Medium": 2, "Low": 3};

  Future<SharedPreferences> getPref() {
    return SharedPreferences.getInstance();
  }

  Future<void> loadTodo() async {
    final pref = await getPref();
    final dataList = pref.getStringList(key);

    if (dataList != null) {
      todos = dataList
          .map((jsonString) => Todo.fromJson(jsonDecode(jsonString)))
          .toList();
      applyFilter(_filter);
    }
  }

  Future<void> saveTodo() async {
    final pref = await getPref();
    final todoJson = todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await pref.setStringList(key, todoJson);
    await loadTodo();
  }

  bool addTodo(
    String task,
    String description,
    String priority,
    DateTime dateTime,
  ) {
    if (task.isEmpty || description.isEmpty || priority.isEmpty) return false;

    final newTodo = Todo(
      task: task,
      description: description,
      isCompleted: false,
      dateTime: dateTime,
      priority: priority,
    );

    todos.add(newTodo);
    saveTodo();
    // applyFilter(_filter);
    notifyListeners();
    return true;
  }

  void removeTodo(Todo todo) {
    todos.remove(todo);
    // applyFilter(_filter);
    saveTodo();
    notifyListeners();
  }

  void updateTodo(Todo oldTodo, Todo newTodo) {
    final index = todos.indexWhere((t) => t.task == oldTodo.task);
    if (index != -1) {
      todos[index] = newTodo;
      // applyFilter(_filter);
      saveTodo();
      notifyListeners();
    }
  }

  void insertTodoAt(int index, Todo todo) {
    if (index < 0 || index > todos.length) {
      todos.add(todo);
    } else {
      todos.insert(index, todo);
    }
    applyFilter(_filter);
    notifyListeners();
  }

  void applyFilter(String query) {
    _filter = query.trim();

    if (_filter.isEmpty) {
      todos.sort(
        (a, b) =>
            priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!),
      );
      filteredTodo = [...todos];
    } else {
      filteredTodo = todos
          .where(
            (item) => item.task.toLowerCase().startsWith(_filter.toLowerCase()),
          )
          .toList();
    }

    updateTodoStates();
    notifyListeners();
  }

  void sortItems(String text) {
    List<Todo> data = [...todos];

    switch (text.toLowerCase()) {
      case "all":
        data.sort(
          (a, b) =>
              priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!),
        );
        break;

      case "high":
      case "medium":
      case "low":
        data = todos
            .where((t) => t.priority.toLowerCase() == text.toLowerCase())
            .toList();
        break;

      case "a-z":
        data.sort(
          (a, b) => a.task.toLowerCase().compareTo(b.task.toLowerCase()),
        );
        break;

      case "z-a":
        data.sort(
          (a, b) => b.task.toLowerCase().compareTo(a.task.toLowerCase()),
        );
        break;
    }

    filteredTodo = data;
    updateTodoStates();
    notifyListeners();
  }

  void updateTodoStates() {
    completedTodos = filteredTodo.where((t) => t.isCompleted == true).toList();

    inCompletedTodos = filteredTodo
        .where((t) => t.isCompleted == false)
        .toList();

    isPinned = filteredTodo
        .where((t) => t.pinned == true && t.isCompleted == false)
        .toList();
  }
}
