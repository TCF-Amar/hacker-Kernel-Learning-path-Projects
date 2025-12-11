import 'package:flutter/material.dart';
import 'package:mytodoapp/controllers/todo_controller.dart';
import 'package:mytodoapp/widgets/bottom_todo_form.dart';
import 'package:mytodoapp/widgets/my_snack_bar.dart';

// import 'package:responcive/widgets/my_snack_bar.dart';
class TodoAddBtn extends StatefulWidget {
  final TodoController todoController;

  const TodoAddBtn({super.key, required this.todoController});

  @override
  State<TodoAddBtn> createState() => _TodoAddBtnState();
}

class _TodoAddBtnState extends State<TodoAddBtn> {
  late TodoController todoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoController = widget.todoController;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final res = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => BottomTodoForm(
            task: '',
            description: "",
            dateTime: DateTime.now(),
            priority: "",
            btnText: 'Add',
          ),
        );

        final String task = res["task"] ?? "";
        final String description = res["description"] ?? "";
        final String priority = res["priority"] ?? "";
        final DateTime dateTime = res["dateTime"] ?? DateTime.now();

        bool isTodoAdded = todoController.addTodo(
          task,
          description,
          priority,
          dateTime,
        );
        if (isTodoAdded) {
          MySnackBar.show(context, message: "Task Added Successfully");
        } else {
          MySnackBar.show(
            context,
            message: "All field required",
            textColor: Colors.red,
          );
        }
      },
      child: Icon(Icons.add, size: 28),
    );
  }
}
