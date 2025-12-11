import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import 'input_field.dart';
import 'my_snack_bar.dart';

class BottomTodoForm extends StatefulWidget {
  final String task;
  final String description;
  final DateTime dateTime;
  final String priority;
  final String btnText;

  const BottomTodoForm({
    super.key,
    required this.task,
    required this.description,
    required this.dateTime,
    required this.priority,
    required this.btnText,
  });

  @override
  State<BottomTodoForm> createState() => _BottomSheetAnimationState();
}

class _BottomSheetAnimationState extends State<BottomTodoForm> {
  late TextEditingController titleCtrl;
  late TextEditingController descCtrl;
  late DateTime selectedDate;
  String _priority = "";
  String _btnText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = widget.dateTime;
    titleCtrl = TextEditingController(text: widget.task);
    descCtrl = TextEditingController(text: widget.description);
    _priority = widget.priority;
    _btnText = widget.btnText;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            width: .infinity,

            child: Column(
              children: [
                InputField(
                  labelText: "Task",
                  textEditingController: titleCtrl,
                  hintText: "Enter Task",
                ),
                const SizedBox(height: 20),

                InputField(
                  labelText: "Description",
                  textEditingController: descCtrl,
                  hintText: "Enter description",
                ),

                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  initialValue: _priority.isEmpty ? null : _priority,
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    hintText: "Select priority",
                  ),
                  items: ["Low", "Medium", "High"]
                      .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                      .toList(),
                  onChanged: (v) => _priority = v ?? "",
                ),

                const SizedBox(height: 30),
                DateTimeFormField(
                  decoration: InputDecoration(
                    labelText: "Date",
                    hintText: "Enter Date",
                  ),
                  initialValue: selectedDate,
                  onChanged: (value) {
                    selectedDate = value!;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    // elevation: 20,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    final todo = {
                      "task": titleCtrl.text.trim(),
                      "description": descCtrl.text.trim(),
                      "priority": _priority,
                      "dateTime": selectedDate,
                    };

                    Navigator.pop(context, todo);
                  },
                  child: Text(_btnText),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
