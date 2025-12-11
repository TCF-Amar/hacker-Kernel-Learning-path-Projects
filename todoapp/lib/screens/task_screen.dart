import 'package:flutter/material.dart';
import 'package:todoapp/controllers/todo_controller.dart';
import 'package:todoapp/widgets/list_todos.dart';

const List<String> list = <String>[
  'none',
  'completed',
  'incompleted',
  'A-Z',
  'Z-A',
  "By Date",
];

class TaskScreen extends StatefulWidget {
  final TodoController todoController;
  const TaskScreen({super.key, required this.todoController});

  @override
  State<TaskScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TaskScreen> {
  late TodoController todoController;
  String dropdownValue = list.first;
  String searchQuery = ''; 
  void _onControllerChanged() {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    todoController = widget.todoController;
    // Ensure applyFilter is not called during the build phase where it would notify other listeners.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      todoController.applyFilter('');
    });
    todoController.addListener(_onControllerChanged);

  }

  @override
  void dispose() {
    todoController.removeListener(_onControllerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Todos',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  todoController.applyFilter(value);
                });
              },
            ),

            Expanded(child: ListTodos(todoController: todoController, searchQuery: searchQuery)),
          ],
        ),
      );




  }
}
