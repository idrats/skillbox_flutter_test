import 'package:flutter/material.dart';
import 'package:skillbox_test/widgets/todo_tab.dart';
import 'package:skillbox_test/widgets/users_tab.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.chat),
              onPressed: () => Navigator.of(context).pushNamed('chat'),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                    icon: Icon(Icons.supervised_user_circle),
                    text: 'Users',
                    iconMargin: EdgeInsets.only(bottom: 4)),
                Tab(
                    icon: Icon(Icons.work),
                    text: 'Todos',
                    iconMargin: EdgeInsets.only(bottom: 4)),
              ],
            ),
            title: Text('SkillboxTest home page'),
          ),
          body: Stack(children: [
            TabBarView(
              children: [
                UsersTab(),
                TodosTab(),
              ],
            ),
          ]),
        ));
  }
}
