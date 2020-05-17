import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillbox_test/pages/home_page.dart';
import 'package:skillbox_test/pages/chat_page.dart';
import 'package:skillbox_test/services/todos_bloc.dart';
import 'package:skillbox_test/services/users_bloc.dart';

class SkillboxTestApp extends StatelessWidget {
  final RouteObserver<PageRoute> routeObserver;
  SkillboxTestApp(this.routeObserver);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<UsersBloc>(
            create: (_) => UsersBloc(),
            dispose: (_, UsersBloc usersBloc) => usersBloc.dispose(),
          ),
          Provider<TodosBloc>(
            create: (_) => TodosBloc(),
            dispose: (_, TodosBloc usersBloc) => usersBloc.dispose(),
          ),
        ],
        child: MaterialApp(
          title: 'Skillbox test',
          theme: ThemeData(
            primarySwatch: Colors.brown,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          navigatorObservers: [routeObserver],
          home: HomePage(),
          routes: <String, WidgetBuilder>{
            HomePage.routeName: (BuildContext context) => HomePage(),
            ChatPage.routeName: (BuildContext context) => ChatPage(),
          },
        ));
  }
}
