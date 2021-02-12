import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/models/new_task/new_task_controller.dart';

class NewTaskPage extends StatelessWidget {
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
