import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytodoapp/tabs/home_tab.dart';
import 'package:mytodoapp/tabs/task_tab.dart';
import 'package:mytodoapp/widgets/todo_add_btn.dart';

import 'controllers/todo_controller.dart';

void main() {

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TodoController todoController = TodoController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
    await  todoController.loadTodo();
      // todoController.applyFilter('');
      // todoController.todoStates();
    });
    // NotificationController.initialize();
    // NotificationController.showNotification("Log", "sdf");

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,

        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),

          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),

      home: DefaultTabController(

        length: 3,
        child: Scaffold(

          appBar: AppBar(
            title: Text('Todo'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home_outlined)),
                Tab(icon: Icon(Icons.list_alt_rounded)),
                Tab(icon: Icon(Icons.settings_outlined)),
              ],
            ),
          ),
          body: TabBarView(

            children: [
              HomeTab(todoController: todoController),
              TaskTab(todoController: todoController),
              Padding(
                padding: const EdgeInsets.all(50),
                child: Center(child: Text("Coming Soon")),
              ),
            ],
          ),
          floatingActionButtonLocation: .centerFloat,
          floatingActionButton: TodoAddBtn(
            todoController: todoController,
          ),
        ),
      ),
    );
  }
}
