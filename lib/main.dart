import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/database/connections.dart';
import 'package:todo_list/app/database/database_adm_connection.dart';
import 'package:todo_list/app/models/home/home_controller.dart';
import 'package:todo_list/app/models/home/home_page.dart';
import 'package:todo_list/app/models/new_task/new_task_controller.dart';
import 'package:todo_list/app/models/new_task/new_task_page.dart';
import 'package:todo_list/app/repositories/todos_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

// WidgetsBindingObserver => identifica o estado que está o aplicativo (se está aberto... fechado... etc.) Obrigatoriamente tem que estar em um stateful component
class _MyAppState extends State<MyApp> {
  DatabaseAdmConnection databaseAdmConnection = DatabaseAdmConnection();
  @override
  void initState() {
    super.initState();
    Connection().instance;
    // observador
    WidgetsBinding.instance.addObserver(databaseAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(databaseAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider(create: (_) => TodosRepository())],
      child: MaterialApp(
        title: 'Todo List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFFFF9129),
          buttonColor: Color(0xFFFF9129),
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.robotoTextTheme().copyWith(
              //title: GoogleFonts.abel();
              ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/new': (_) => ChangeNotifierProvider(
                create: (context) => NewTaskController(
                  repository: context.read<TodosRepository>(),
                ),
                child: NewTaskPage(),
              ),
        },
        home: ChangeNotifierProvider(
          create: (context) {
            var repository = context.read<TodosRepository>();
            return HomeController(repository: repository);
          },
          child: HomePage(),
        ),
      ),
    );
  }
}
