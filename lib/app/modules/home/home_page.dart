import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
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
                itemCount: 3,
                itemBuilder: (_, index) {
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
                              'Hoje',
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
                        itemCount: 4,
                        itemBuilder: (_, index) {
                          return ListTile(
                            leading: Checkbox(
                              value: false,
                              onChanged: (bool value) {},
                            ),
                            title: Text(
                              'Tarefa X',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration:
                                    true ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            trailing: Text(
                              '06:00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration:
                                    true ? TextDecoration.lineThrough : null,
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
            onSelectTab: (index) => controller.changeSelectedTab(index),
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
