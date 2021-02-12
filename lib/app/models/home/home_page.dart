import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/models/home/home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Atividades'),
          ),
          body: TextButton(
            child: Text('teste'),
            onPressed: () => Navigator.of(context).pushNamed('/new'),
          ),
        );
      },
    );
  }
}
