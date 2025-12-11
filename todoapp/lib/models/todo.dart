class Todo {
  String task;
  bool isComplete;
  DateTime dateTime;
  String? description;
  Todo({
    required this.task,
    this.isComplete = false,
    required this.dateTime,
     this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      "task": task,
      "dateTime": dateTime.toIso8601String(),
      "isComplete": isComplete,
      "description": description,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      task: json["task"],
      dateTime: DateTime.parse(json["dateTime"]),
      isComplete: json["isComplete"],
      description: json["description"],
    );
  }
}
