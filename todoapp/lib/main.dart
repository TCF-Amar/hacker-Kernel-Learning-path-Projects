import 'package:flutter/material.dart';
import 'package:todoapp/controllers/todo_controller.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/screens/task_screen.dart';
import 'package:todoapp/widgets/todo_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const TabsBars(),
    );
  }
}

class TabsBars extends StatefulWidget {
  const TabsBars({super.key});

  @override
  State<TabsBars> createState() => _TabsBarsState();
}

class _TabsBarsState extends State<TabsBars> {
  TodoController todoController = TodoController();

  @override
  void initState() {
    super.initState();
    // Load todos and apply an initial empty filter after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await todoController.loadTodos();
      todoController.applyFilter('');
    });

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Center(
            child: Text(
              "My Todo ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              color: Colors.blue, // ⭐ TabBar background color
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                // indicatorColor: Colors.red,
                tabs: const [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.task_sharp)),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: [
          HomeScreen(todoController: todoController),
          TaskScreen(todoController: todoController)]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final res = await showDialog(
              context: context,
              builder: (_) =>
                  TodoForm(task: "", title: "Add New Task", buttonTitle: "Add", dateTime: DateTime.now(),description:"",),
            );
            // print(res);
            // print(res);
            if(res != null && res is Map) {
              final String task = res["task"].toString();
              final DateTime dt = res["dateTime"] is DateTime ? res['dateTime'] as DateTime : DateTime.now();
              final String description = res["description"].toString();
              if (task.trim().isNotEmpty) {
                setState(() {
                  todoController.addTodo(task, dt,description);
                });
              }
            }
          },
          child: Icon(Icons.add, size: 25),
        ),
      ),
    );
  }
}
