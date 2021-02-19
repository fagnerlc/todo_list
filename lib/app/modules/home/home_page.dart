import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/modules/new_task/new_task_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Atividades',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: controller.listTodos?.keys?.length ?? 0,
                itemBuilder: (_, index) {
                  var dateFormat = DateFormat('dd/MM/yyyy');
                  var dayKey = controller.listTodos.keys.elementAt(index);
                  var day = dayKey;
                  var listTodos = controller.listTodos;
                  var todos = listTodos[dayKey];
                  var today = DateTime.now();

                  if (todos.isEmpty && controller.selectedTab == 0) {
                    return SizedBox.shrink();
                  }

                  if (dayKey == dateFormat.format(today)) {
                    day = 'HOJE';
                  } else if (dayKey ==
                      dateFormat.format(today.add(Duration(days: 1)))) {
                    day = 'AMANHÃ';
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              day,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )),
                            IconButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(NewTaskPage.routerName),
                              icon: Icon(
                                Icons.add_circle,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true, // controla o tamanho das listas
                        physics:
                            NeverScrollableScrollPhysics(), // remove física
                        itemCount: todos.length,
                        itemBuilder: (_, index) {
                          var todo = todos[index];
                          return ListTile(
                            leading: Checkbox(
                              activeColor: Theme.of(context).primaryColor,
                              value: todo.finalizado, //false,
                              onChanged: (bool value) =>
                                  controller.checkedOrUncheck(todo),
                            ),
                            title: Text(
                              todo.descricao,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration: todo.finalizado // true
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: Text(
                              '${todo.dataHora.hour}:${todo.dataHora.minute}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration: todo.finalizado //true
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }),
          ),
          bottomNavigationBar: FFNavigationBar(
            selectedIndex: controller.selectedTab,
            onSelectTab: (index) =>
                controller.changeSelectedTab(context, index),
            items: [
              FFNavigationBarItem(
                iconData: Icons.check_circle,
                label: 'Finalizados',
              ),
              FFNavigationBarItem(
                iconData: Icons.view_week,
                label: 'Semanal',
              ),
              FFNavigationBarItem(
                iconData: Icons.calendar_today,
                label: 'Selecionar Data',
              ),
            ],
            theme: FFNavigationBarTheme(
              itemWidth: 60,
              barHeight: 70,
              barBackgroundColor: Theme.of(context).primaryColor,
              unselectedItemIconColor: Colors.white,
              unselectedItemLabelColor: Colors.white,
              selectedItemBorderColor: Colors.white,
              selectedItemIconColor: Colors.white,
              selectedItemBackgroundColor: Theme.of(context).primaryColor,
              selectedItemLabelColor: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
