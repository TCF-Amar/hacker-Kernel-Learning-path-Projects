import 'package:uuid/uuid.dart';

class Todo {
  static const uuid = Uuid();
  final String id;
  final String task;
  final String description;
  final bool isCompleted;
  final DateTime dateTime;
  final String priority;
  final bool pinned;

  Todo({
    String? id,
    required this.task,
    required this.description,
    this.isCompleted = false,
    required this.dateTime,
    required this.priority,
    this.pinned = false,
  }) : id = id ?? uuid.v1();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': task,
      'description': description,
      'isCompleted': isCompleted,
      'dateTime': dateTime.toIso8601String(),
      'priority': priority,
      'pinned': pinned,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json["id"],
      task: json["task"],
      description: json["description"],
      isCompleted: json["isCompleted"],
      dateTime: DateTime.parse(json["dateTime"]),
      priority: json["priority"],
      pinned: json["pinned"],
    );
  }
}
