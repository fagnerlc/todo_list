import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/modules/new_task/new_task_controller.dart';

class NewTaskPage extends StatelessWidget {
  static String routerName = '/new';
  @override
  Widget build(BuildContext context) {
    return Consumer<NewTaskController>(
      builder: (BuildContext context, NewTaskController controller, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Nova Task'),
          ),
          body: Container(
            child: Center(
              child: Text(''),
            ),
          ),
        );
      },
    );
  }
}
