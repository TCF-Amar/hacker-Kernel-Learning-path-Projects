import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/todo_controller.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/widgets/todo_form.dart';

class Task extends StatefulWidget {
  final Todo todo;
  final int idx;
  final TodoController todoController;

  const Task({
    super.key,
    required this.idx,
    required this.todo,
    required this.todoController,
  });

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    final todo = widget.todo;

    String formattedDate = DateFormat("dd/MM/yyyy").format(todo.dateTime);
    String formattedTime = DateFormat("hh:mm a").format(todo.dateTime);

    String displayTask = todo.task.isNotEmpty
        ? "${todo.task[0].toUpperCase()}${todo.task.substring(1)}"
        : "";

    return AlertDialog(
      title: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.blue),
          ),
          const Text(
            "Task Details",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),

      content: SizedBox(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Top Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        displayTask,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Edit Button
                    IconButton(
                      onPressed: () async {
                        final res = await showDialog(
                          context: context,
                          builder: (_) => TodoForm(
                            task: todo.task,
                            title: "Edit Task",
                            buttonTitle: "Save",
                            dateTime: todo.dateTime, // OLD DATE
                            description: todo.description ?? "",
                          ),
                        );

                        if (res != null && res is Map) {
                          // Use update by Todo so updates work when viewing a filtered list
                          widget.todoController.updateTodoByTodo(
                            widget.todo,
                            res["task"].toString(),
                            res["dateTime"] is DateTime ? res["dateTime"] as DateTime : DateTime.now(),
                            res["description"].toString(),
                          );
                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.edit_note, size: 30),
                    )
                  ],
                ),

                const SizedBox(height: 6),

                // Date & Time
                Text(
                  "$formattedDate  |  $formattedTime",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 10),
                Divider(thickness: 1),

                const SizedBox(height: 20),

                // Description
                Text(
                  todo.description?.isNotEmpty == true
                      ? todo.description!
                      : "(No description)",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),

            // Bottom: Done + Delete Buttons (responsive layout)
            Row(
              children: [
                // Done / Complete
                Expanded(
                  child: SizedBox(
                    height: 70,
                    child: TextButton(
                      onPressed: () {
                        widget.todoController.toggleCompleteByTodo(todo);
                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            todo.isComplete
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            todo.isComplete ? "Completed" : "Done",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Delete
                Expanded(
                  child: SizedBox(
                    height: 70,
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (c) => AlertDialog(
                            title: const Text("Delete Task"),
                            content: const Text("Are you sure you want to delete this?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(c),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  widget.todoController.removeTodoByTodo(todo);
                                  Navigator.pop(c);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.delete_forever, color: Colors.redAccent),
                          SizedBox(height: 4),
                          Text("Delete", style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
