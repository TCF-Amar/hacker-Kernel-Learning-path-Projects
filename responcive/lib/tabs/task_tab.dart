import 'package:flutter/material.dart';

import '../controllers/todo_controller.dart';
import '../widgets/list_todos.dart';

class TaskTab extends StatefulWidget {
  final TodoController todoController;

  const TaskTab({super.key, required this.todoController});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  late TodoController todoController;
  late TextEditingController searchController;

  List<String> sortItem = ["All", "High", "Medium", "Low", "A-Z", "Z-A"];

  @override
  void initState() {
    super.initState();
    todoController = widget.todoController;
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        // Search Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            autofocus: false,
            controller: searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Search",
              hintText: "Search here todos",
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              todoController.applyFilter(value);
            },
          ),
        ),

        SizedBox(
          width: 100,
          child: DropdownButtonFormField<String>(
            value: sortItem.first,
            decoration: const InputDecoration(
              labelText: 'Sort',
              hintText: "Sort",
            ),
            items: sortItem
                .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                .toList(),
            onChanged: (value) {
              todoController.sortItems(value!);
            },
          ),
        ),
        const SizedBox(height: 10),
        // Todos List
        Expanded(child: ListTodos(todoController: todoController)),
      ],
    );
  }
}
