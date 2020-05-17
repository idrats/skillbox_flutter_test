import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillbox_test/models/user.dart';
import 'package:skillbox_test/services/users_bloc.dart';

class ChatPage extends StatelessWidget {
  static const routeName = 'chat';

  @override
  Widget build(BuildContext context) {
    final _usersBloc = Provider.of<UsersBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('SkillboxTest chat page')),
      body: StreamBuilder<List<User>>(
          stream: _usersBloc.selectedUsers,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.data.isEmpty) {
              return Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Please, firstly select users you want to chat',
                  textAlign: TextAlign.center,
                ),
              ));
            }
            return ListView.builder(
                key: PageStorageKey('usersListView'),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: Column(
                    children: <Widget>[
                      ListTile(
                          isThreeLine: true,
                          leading: CircleAvatar(
                              backgroundColor: Colors.brown.shade800,
                              child: Text(snapshot.data[index].initials)),
                          title: Text(snapshot.data[index].name),
                          subtitle: Text(snapshot.data[index].email +
                              '\n' +
                              snapshot.data[index].phone),
                          trailing: Text(snapshot.data[index].website)),
                    ],
                  ));
                });
          }),
    );
  }
}
