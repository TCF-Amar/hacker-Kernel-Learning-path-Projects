import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotTodoExist extends StatelessWidget{
  const NotTodoExist({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_outlined,
            size: 80,
            color: Colors.grey.shade600,
          ),
          SizedBox(height: 16),
          Text(
            'No todos yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
  
}