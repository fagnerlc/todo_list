import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/app/models/todo_model.dart';
import 'package:todo_list/app/repositories/todos_repository.dart';
import 'package:collection/collection.dart';

class HomeController extends ChangeNotifier {
  final TodosRepository repository;
  DateTime daySelectec;
  int selectedTab = 1;
  DateTime startFilter;
  DateTime endFilter;
  Map<String, List<TodoModel>> listTodos;
  var dateFormat = DateFormat('dd/MM/yyyy');

  HomeController({@required this.repository}) {
    //repository.saveTodo(DateTime.now(), 'Teste 1');
    //repository.saveTodo(DateTime.now().subtract(Duration(days: 2)), 'Teste 2');
    //repository.saveTodo(DateTime.now().add(Duration(days: 1)), 'Teste 3');
    findAllForWeek();
  }

  Future<void> findAllForWeek() async {
    daySelectec = DateTime.now();
    startFilter = DateTime.now();

    if (startFilter.weekday != DateTime.sunday) {
      startFilter = startFilter.subtract(Duration(days: (startFilter.weekday)));
    }
    endFilter = startFilter.add(Duration(days: 6));
    //print(startFilter);
    //print(endFilter);

    var todos = await repository.findByPeriod(startFilter, endFilter);

    if (todos.isEmpty) {
      //criado para ter pelo menos um conteudo na lista se estiver vazia.
      listTodos = {dateFormat.format(DateTime.now()): []};
    } else {
      listTodos =
          groupBy(todos, (TodoModel todo) => dateFormat.format(todo.dataHora));
    }

    this.notifyListeners();
  }

  void changeSelectedTab(BuildContext context, int index) async {
    selectedTab = index;
    switch (index) {
      case 0:
        filterFinalized();
        break;
      case 1:
        findAllForWeek();
        break;
      case 2:
        daySelectec = await showDatePicker(
          context: context,
          initialDate: daySelectec,
          firstDate: DateTime.now().subtract(Duration(days: 365 * 3)),
          lastDate: DateTime.now().add(Duration(days: 365 * 10)),
        );
        findTodosBySelectedDay();
        break;
      default:
    }
    notifyListeners();
  }

  void checkedOrUncheck(TodoModel todo) {
    todo.finalizado = !todo.finalizado;
    this.notifyListeners();
    repository.checkOrUncheckTodo(todo);
  }

  void filterFinalized() {
    listTodos = listTodos.map((key, value) {
      var todosFinalized =
          value.where((element) => element.finalizado).toList();
      return MapEntry(key, todosFinalized);
    });
    this.notifyListeners();
  }

  void findTodosBySelectedDay() async {
    var todos = await repository.findByPeriod(daySelectec, daySelectec);
    if (todos.isEmpty) {
      //criado para ter pelo menos um conteudo na lista se estiver vazia.
      listTodos = {dateFormat.format(DateTime.now()): []};
    } else {
      listTodos =
          groupBy(todos, (TodoModel todo) => dateFormat.format(todo.dataHora));
    }

    this.notifyListeners();
  }
}
