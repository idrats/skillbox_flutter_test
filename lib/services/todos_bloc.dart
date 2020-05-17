import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skillbox_test/api/api_client.dart';
import 'package:skillbox_test/models/todo.dart';
import 'package:skillbox_test/services/service_locator.dart';

class TodosBloc {
  final _todosSubj = BehaviorSubject<List<Todo>>.seeded([]);
  final _isLoadingSubj = BehaviorSubject<bool>.seeded(false);
  var _todos = <Todo>[];

  Future<void> fetchTodos() async {
    _isLoadingSubj.sink.add(true);
    _todos = await service<ApiClient>().fetchTodos();
    _todosSubj.add(_todos);
    _isLoadingSubj.sink.add(false);
  }

  Stream<bool> get loading => _isLoadingSubj.distinct();
  Stream get todos => _todosSubj.stream;

  void dispose() {
    _todosSubj.close();
    _isLoadingSubj.close();
  }
}
