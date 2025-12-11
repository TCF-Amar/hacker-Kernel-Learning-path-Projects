import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytodoapp/model/todo.dart';
import 'package:mytodoapp/widgets/todo_details.dart';

import '../controllers/todo_controller.dart';
import '../widgets/not_todo_exist.dart';

class HomeTab extends StatefulWidget {
  final TodoController todoController;
  const HomeTab({super.key, required this.todoController});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late TodoController _todoController;
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _todoController = widget.todoController;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _todoController,
      builder: (context, _) {
        if (_todoController.todos.isEmpty) {
          return NotTodoExist();
        }
        final pinned = _todoController.isPinned;
        final completed = _todoController.completedTodos;
        final inCompleted = _todoController.inCompletedTodos;

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (pinned.isNotEmpty) ...[
                Text(
                  'Pinned Tasks',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: pinned.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final todo = pinned[index];
                      final title = _displayTitle(todo.task);
                      return GestureDetector(
                        onTap: () => _openTodoDetails(todo),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            width: 220,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(Icons.push_pin, size: 18),
                                ),
                                Text(todo.description)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
              if (inCompleted.isNotEmpty) ...[
                const SizedBox(height: 10),
                if (inCompleted.isNotEmpty)
                  Text(
                    'Incompleted',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                Expanded(
                  // flex: 1,
                  child: ListView.builder(
                    itemCount: _todoController.inCompletedTodos.length,
                    itemBuilder: (context, index) {
                      final todo = _todoController.inCompletedTodos[index];
                      String formatedDate = DateFormat(
                        "dd MMM yyyy",
                      ).format(todo.dateTime);
                      String formatedTime = DateFormat(
                        "hh:mm a",
                      ).format(todo.dateTime);
                      String todayDate = DateFormat(
                        "dd MMM yyyy",
                      ).format(DateTime.now());
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(_displayTitle(todo.task)),
                          subtitle: Text(
                            "${formatedDate == todayDate ? "Today" : formatedDate} | $formatedTime",
                            style: TextStyle(fontSize: 10),
                          ),
                          onTap: () => _openTodoDetails(todo),
                        ),
                      );
                    },
                  ),
                ),
              ],

              if (completed.isNotEmpty) ...[
                Text(
                  'Completed Tasks',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _todoController.completedTodos.length,
                    itemBuilder: (context, index) {
                      final todo = _todoController.completedTodos[index];
                      String formatedDate = DateFormat(
                        "dd MMM yyyy",
                      ).format(todo.dateTime);
                      String formatedTime = DateFormat(
                        "hh:mm a",
                      ).format(todo.dateTime);
                      String todayDate = DateFormat(
                        "dd MMM yyyy",
                      ).format(DateTime.now());
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.check_circle,
                            color: Colors.greenAccent,
                          ),
                          title: Text(_displayTitle(todo.task)),
                          subtitle: Text(
                            "${formatedDate == todayDate ? "Today" : formatedDate} | $formatedTime",
                            style: TextStyle(fontSize: 10),
                          ),
                          onTap: () => _openTodoDetails(todo),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _openTodoDetails(Todo todo) {
    () async {
      final res = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => TodoDetails(todo: todo, todoController: _todoController),
      );

      if (res is Map && res["deleted"] == true) {
        final message = (res["message"] ?? "Todo deleted").toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }();
  }

  String _displayTitle(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return 'Untitled Task';
    return trimmed.length == 1
        ? trimmed.toUpperCase()
        : '${trimmed[0].toUpperCase()}${trimmed.substring(1)}';
  }
}
