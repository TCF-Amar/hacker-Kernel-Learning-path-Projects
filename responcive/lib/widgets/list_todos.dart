import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytodoapp/controllers/todo_controller.dart';
import 'package:mytodoapp/model/todo.dart';
import 'package:mytodoapp/widgets/my_snack_bar.dart';
import 'package:mytodoapp/widgets/not_todo_exist.dart';
import 'package:mytodoapp/widgets/todo_details.dart';

class ListTodos extends StatefulWidget {
  final TodoController todoController;

  const ListTodos({super.key, required this.todoController});

  @override
  State<ListTodos> createState() => _ListTodosState();
}

class _ListTodosState extends State<ListTodos> {
  late TodoController _todoController;

  @override
  void initState() {
    super.initState();
    _todoController = widget.todoController;
  }

  void _openTodoDetails(Todo todo) async {
    final res = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return TodoDetails(todo: todo, todoController: _todoController);
      },
    );

    // If the bottom sheet returned a result indicating a deletion, show SnackBar
    if (res is Map && res["deleted"] == true) {
      final message = (res["message"] ?? "Todo deleted").toString();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _toggleTodoCompletion(Todo todo) async {
    final updatedTodo = Todo(
      task: todo.task,
      description: todo.description,
      isCompleted: !todo.isCompleted,
      dateTime: todo.dateTime,
      priority: todo.priority,
      pinned: todo.pinned,
    );
    _todoController.updateTodo(todo, updatedTodo);
    MySnackBar.show(
      context,
      message: updatedTodo.isCompleted
          ? "Task Completed"
          : "Checked Incomplete",
      textColor: updatedTodo.isCompleted ? Colors.green : Colors.red
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _todoController,
      builder: (context, _) {
        if (_todoController.filteredTodo.isEmpty) {
          return NotTodoExist();
        }

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: _todoController.filteredTodo.length,
          itemBuilder: (context, index) {
            final todo = _todoController.filteredTodo[index];

            String formatedDate = DateFormat(
              "dd MMM yyyy",
            ).format(todo.dateTime);
            String formatedTime = DateFormat("hh:mm a").format(todo.dateTime);
            String todayDate = DateFormat("dd MMM yyyy").format(DateTime.now());

            Color priorityColor = _getPriorityColor(todo.priority);

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              shadowColor: Colors.black26,
              child: ListTile(
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (_) => _toggleTodoCompletion(todo),
                ),
                title: Text(
                  (todo.task.isNotEmpty)
                      ? "${todo.task[0].toUpperCase()}${todo.task.substring(1)}"
                      : "Untitled Task",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "${formatedDate == todayDate ? "Today" : formatedDate} | $formatedTime",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        // color: priorityColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        todo.priority,
                        style: TextStyle(
                          fontSize: 11,
                          color: priorityColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () => _openTodoDetails(todo),
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                ),
                onTap: () => _openTodoDetails(todo),
              ),
            );
          },
        );
      },
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
