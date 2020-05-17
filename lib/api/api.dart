import 'dart:convert';
import 'dart:io';

import 'package:skillbox_test/models/todo.dart';
import 'package:skillbox_test/models/user.dart';

class ApiClient {
  static final usersUrl =
      Uri.parse('https://jsonplaceholder.typicode.com/users/');
  static final todosUrl =
      Uri.parse('https://jsonplaceholder.typicode.com/todos/');
  final httpClient;

  ApiClient(this.httpClient);

  Future<List<User>> fetchUsers() async {
    final httpRequest = await httpClient.getUrl(usersUrl);
    httpRequest.headers.add('Content-Type', 'application/json; charset=utf-8');
    httpRequest.headers.add('Accept', 'application/json');
    final httpResponse = await httpRequest.close();
    final users = <User>[];
    if (httpResponse.statusCode == HttpStatus.ok) {
      final resultBody =
          (await httpResponse.transform(utf8.decoder).toList()).join();
      final responseJson = json.decode(resultBody);
      if (responseJson is List) {
        responseJson.forEach((user) {
          users.add(User.fromJson(user));
        });
      }
    } else {
      throw HttpException(httpResponse.reasonPhrase);
    }
    return users;
  }

  Future<List<Todo>> fetchTodos() async {
    final httpRequest = await httpClient.getUrl(todosUrl);
    httpRequest.headers.add('Content-Type', 'application/json; charset=utf-8');
    httpRequest.headers.add('Accept', 'application/json');
    final httpResponse = await httpRequest.close();
    final todos = <Todo>[];
    if (httpResponse.statusCode == HttpStatus.ok) {
      final resultBody =
          (await httpResponse.transform(utf8.decoder).toList()).join();
      final responseJson = json.decode(resultBody);
      if (responseJson is List) {
        responseJson.forEach((todo) {
          todos.add(Todo.fromJson(todo));
        });
      }
    } else {
      throw HttpException(httpResponse.reasonPhrase);
    }
    return todos;
  }
}
