import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class TodoForm extends StatefulWidget {
  String task;
  String title;
  String buttonTitle;
  DateTime dateTime;
  String description;

  TodoForm({
    super.key,
    required this.task,
    required this.dateTime,
    required this.title,
    required this.description,
    required this.buttonTitle,
  });

  @override
  State<TodoForm> createState() => _TodoAddFormState();
}

class _TodoAddFormState extends State<TodoForm> {
  late TextEditingController taskEdit;
  late TextEditingController descController;
  DateTime? dt;

  @override
  void initState() {
    super.initState();
    taskEdit = TextEditingController(text: widget.task);
    descController = TextEditingController(text: widget.description);
    dt = widget.dateTime;
  }

  @override
  void dispose() {
    taskEdit.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),

      content: SizedBox(
        height: 350,
        child: Column(
          children: [
            // --- taskEdit TextField ---
            TextField(
              controller: taskEdit,
              decoration: const InputDecoration(
                hintText: "Enter Task here...",
              ),
            ),

            const SizedBox(height: 20),

            // --- Description TextField (Added) ---
            TextField(
              controller: descController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: "Enter Description...",
              ),
            ),

            const SizedBox(height: 20),

            // --- DateTime Picker ---
            DateTimeFormField(
              decoration: const InputDecoration(
                labelText: "Select Date",
              ),
              initialValue: dt,
              onChanged: (value) {
                dt = value;
              },
            ),
          ],
        ),
      ),

      actions: [
        // Cancel Button
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.red.shade900),
          ),
        ),

        // Submit Button
        ElevatedButton(
          onPressed: () {
            if (taskEdit.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Task cannot be empty")),
              );
              return;
            }

            if (dt == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please select date")),
              );
              return;
            }

            Navigator.pop(context, {
              "task": taskEdit.text,
              "description": descController.text,
              "dateTime": dt,
            });
          },
          child: Text(widget.buttonTitle),
        ),
      ],
    );
  }
}
