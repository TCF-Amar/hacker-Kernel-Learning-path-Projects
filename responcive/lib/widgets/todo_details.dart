import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytodoapp/controllers/todo_controller.dart';
import 'package:mytodoapp/model/todo.dart';
import 'package:mytodoapp/widgets/my_snack_bar.dart';

import '../model/todo.dart';
import 'bottom_todo_form.dart';
import 'my_snack_bar.dart';

class TodoDetails extends StatefulWidget {
  final Todo todo;
  final TodoController todoController;

  const TodoDetails({
    super.key,
    required this.todo,
    required this.todoController,
  });

  @override
  State<TodoDetails> createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  late TodoController _todoController;
  late Todo _todo;

  @override
  void initState() {
    super.initState();
    _todoController = widget.todoController;
    _todo = widget.todo;
  }

  void _deleteTodo() {
    final deletedTodo = _todo;
    final deletedTodoIndex = _todoController.todos.indexOf(_todo);

    _todoController.removeTodo(_todo);
    Navigator.pop(context);

    MySnackBar.show(
      context,
      message: "Todo Deleted",
      actionLabel: "Undo",
      onAction: () {
        _todoController.insertTodoAt(deletedTodoIndex, deletedTodo);
      },
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white,
      textColor: Colors.red,
    );
  }

  void _toggleCompletion() {
    final updatedTodo = Todo(
      task: _todo.task,
      description: _todo.description,
      isCompleted: !_todo.isCompleted,
      dateTime: _todo.dateTime,
      priority: _todo.priority,
      pinned: _todo.pinned,
    );
    _todoController.updateTodo(_todo, updatedTodo);
    setState(() {
      _todo = updatedTodo;
    });
    MySnackBar.show(
      context,
      message: _todo.isCompleted ? "Task Completed" : "Checked Incompleted",
      backgroundColor: Colors.white,
      textColor: _todo.isCompleted? Colors.green : Colors.red,
    );
  }

  void _togglePinned() {
    final updatedTodo = Todo(
      task: _todo.task,
      description: _todo.description,
      isCompleted: _todo.isCompleted,
      dateTime: _todo.dateTime,
      priority: _todo.priority,
      pinned: !_todo.pinned,
    );
    _todoController.updateTodo(_todo, updatedTodo);
    setState(() {
      _todo = updatedTodo;
    });
    MySnackBar.show(
      context,
      message: _todo.pinned ? "Pinned" : "UnPinned",
      backgroundColor: Colors.white,
      textColor: Colors.blueAccent,
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

  @override
  Widget build(BuildContext context) {
    String formatedDate = DateFormat("dd MMM yyyy").format(_todo.dateTime);
    String formatedTime = DateFormat("hh:mm a").format(_todo.dateTime);

    return SafeArea(
      child: AnimatedBuilder(
        animation: _todoController,
        builder: (context, _) {
          return Padding(
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: .start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new_outlined),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Task Details",
                        style: TextStyle(
                          // fontSize:3 0 ,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          (_todo.task.isNotEmpty)
                              ? "${_todo.task[0].toUpperCase()}${_todo.task.substring(1)}"
                              : "Untitled Task",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            decoration: _todo.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final res = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (_) => BottomTodoForm(
                              task: _todo.task,
                              description: _todo.description,
                              dateTime: _todo.dateTime,
                              priority: _todo.priority,
                              btnText: 'Save',
                            ),
                          );
                          if (res != null) {
                            final updatedTodo = Todo(
                              task: res["task"],
                              description: res["description"],
                              dateTime: res["dateTime"],
                              priority: res["priority"],
                              isCompleted: _todo.isCompleted,
                              pinned: _todo.pinned,

                            );

                            setState(() {
                              _todoController.updateTodo(_todo, updatedTodo);
                              _todo = updatedTodo;
                            });
                            MySnackBar.show(context, message: "Todo Updated",backgroundColor: Colors.white, textColor: Colors.green);

                          }
                        },
                        icon: Icon(Icons.edit_note, size: 35),
                      ),
                    ],
                  ),
                  // SizedBox(height: 16),
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    decoration: BoxDecoration(
                      // color: _getPriorityColor(_todo.priority).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _todo.priority,
                      style: TextStyle(
                        fontSize: 14,
                        color: _getPriorityColor(_todo.priority),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Date & Time',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '$formatedDate at $formatedTime',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _todo.description,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Expanded(
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white10,
                          ),
                          onPressed: () {
                            _toggleCompletion();
                          },
                          icon: Icon(
                            _todo.isCompleted
                                ? Icons.check_circle
                                : Icons.check_circle_outline_outlined,
                            size: 30,
                            color: _todo.isCompleted
                                ? Colors.greenAccent
                                : Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white10,
                          ),
                          onPressed: _deleteTodo,
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white10,
                          ),
                          onPressed: _togglePinned,
                          icon: Icon(
                            _todo.pinned
                                ? Icons.push_pin
                                : Icons.push_pin_outlined,
                            color: Colors.blueAccent,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
