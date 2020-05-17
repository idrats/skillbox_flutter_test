import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skillbox_test/api/api_client.dart';
import 'package:skillbox_test/models/user.dart';
import 'package:skillbox_test/services/service_locator.dart';

class UsersBloc {
  final _usersSubj = BehaviorSubject<List<User>>.seeded([]);
  final _isLoadingSubj = BehaviorSubject<bool>.seeded(false);
  final _usersController = StreamController<User>();
  var _users = <User>[];

  UsersBloc() {
    _usersController.stream.listen(_changeStream);
  }

  void _changeStream(User user) async {
    final index = _users.indexWhere((u) => u.id == user.id);
    _users[index] = user;
    _usersSubj.sink.add(_users);
  }

  Future<void> fetchUsers() async {
    _isLoadingSubj.sink.add(true);
    _users = await service<ApiClient>().fetchUsers();
    _usersSubj.add(_users);
    _isLoadingSubj.sink.add(false);
  }

  StreamSink<User> get updateUser => _usersController.sink;
  Stream<bool> get loading => _isLoadingSubj.distinct();
  Stream<List<User>> get users => _usersSubj.stream;
  Stream<List<User>> get selectedUsers => _usersSubj.distinct().map<List<User>>(
      (users) => List.from(users)..retainWhere((user) => user.selected));

  void dispose() {
    _usersSubj.close();
    _isLoadingSubj.close();
    _usersController.close();
  }
}
