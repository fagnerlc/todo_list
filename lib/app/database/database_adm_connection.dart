import 'package:flutter/cupertino.dart';
import 'package:todo_list/app/database/connections.dart';

class DatabaseAdmConnection with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // é chamado sempre quando um estado for alterado
    var connection = Connection();
    print(state);
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        connection.closeConnection();
        break;
      case AppLifecycleState.paused:
        connection.closeConnection();
        break;
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
