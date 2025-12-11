import 'package:flutter/material.dart';
import 'package:todoapp/controllers/todo_controller.dart';
import 'package:todoapp/widgets/task.dart';

class ListTodos extends StatefulWidget {
  final TodoController todoController;
  final String searchQuery;
  const ListTodos({
    super.key,
    required this.todoController,
    this.searchQuery = '',
  });

  @override
  State<ListTodos> createState() => _ListTodosState();
}

class _ListTodosState extends State<ListTodos> {
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
    widget.todoController.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.todoController.removeListener(_onControllerChanged);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final todoController = widget.todoController;
    // final searchQuery = widget.searchQuery; // not used here

    if (todoController.filteredTodos.isEmpty && todoController.todos.isEmpty) {
      return const Center(child: Text('No todos yet'));
    }

    return ListView.builder(
      itemCount: todoController.filteredTodos.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    spreadRadius: 2,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  (() {
                    final t = todoController.filteredTodos[index].task;
                    if (t.isEmpty) return '';
                    return '${t[0].toUpperCase()}${t.substring(1)}';
                  })(),
                  style: TextStyle(
                    decoration: todoController.filteredTodos[index].isComplete
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${todoController.filteredTodos[index].dateTime.day}-"
                      "${todoController.filteredTodos[index].dateTime.month}-"
                      "${todoController.filteredTodos[index].dateTime.year} | "
                      "${todoController.filteredTodos[index].dateTime.hour}:"
                      "${todoController.filteredTodos[index].dateTime.minute}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final _ = await showDialog(
                      context: context,
                      builder: (_) => Task(
                        idx: index,
                        todo: todoController.filteredTodos[index],
                        todoController: todoController,
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios, size: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
