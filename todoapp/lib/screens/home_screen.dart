import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/todo_controller.dart';
import 'package:todoapp/models/todo.dart';

class HomeScreen extends StatefulWidget {
  final TodoController todoController;

  const HomeScreen({super.key, required this.todoController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> incomplete = [];
  List<Todo> complete = [];

  void _updateLists() {
    incomplete = widget.todoController.todos
        .where((t) => !t.isComplete)
        .toList();

    complete = widget.todoController.todos
        .where((t) => t.isComplete)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _updateLists();
    widget.todoController.addListener(_controllerListener);
  }

  void _controllerListener() {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _updateLists();
      });
    });
  }

  @override
  void dispose() {
    widget.todoController.removeListener(_controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool noTasks = incomplete.isEmpty && complete.isEmpty;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: noTasks
          ? _buildEmptyUI()
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Incomplete Section
            if (incomplete.isNotEmpty) ...[
              const Text(
                "Pending Tasks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...incomplete.map((t) => _buildCard(t)),
              const SizedBox(height: 20),
            ],

            // Completed Section
            if (complete.isNotEmpty) ...[
              const Text(
                "Completed Tasks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 12),
              ...complete.map((t) => _buildCard(t)),
            ],
          ],
        ),
      ),
    );
  }


  Widget _buildEmptyUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt_rounded, size: 90, color: Colors.grey.shade400),
          const SizedBox(height: 20),
          Text(
            "No tasks yet!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Add your first task using the + button.",
            style: TextStyle(color: Colors.grey.shade500),
          )
        ],
      ),
    );
  }


  Widget _buildCard(Todo todo) {
    String title = todo.task.isNotEmpty
        ? "${todo.task[0].toUpperCase()}${todo.task.substring(1)}"
        : "";

    String date = DateFormat("dd MMM yyyy").format(todo.dateTime);
    String time = DateFormat("hh:mm a").format(todo.dateTime);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: todo.isComplete
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  todo.isComplete ? "Completed" : "Pending",
                  style: TextStyle(
                    color: todo.isComplete ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 6),
              Text("$date • $time",
                  style:
                  TextStyle(fontSize: 13, color: Colors.grey.shade700)),
            ],
          ),


        ],
      ),
    );
  }
}
