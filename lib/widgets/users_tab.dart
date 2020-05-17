import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:skillbox_test/models/user.dart';
import 'package:skillbox_test/services/helpers.dart';
import 'package:skillbox_test/services/users_bloc.dart';

class UsersTab extends StatefulWidget {
  @override
  _UsersTabState createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UsersBloc>(context, listen: false).fetchUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _usersBloc = Provider.of<UsersBloc>(context, listen: false);

    return Stack(children: [
      StreamBuilder<List<User>>(
          stream: _usersBloc.users,
          initialData: [],
          builder: (context, snapshot) {
            return ListView.builder(
                key: PageStorageKey('usersListView'),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      color: snapshot.data[index].selected
                          ? Colors.blue[100]
                          : Colors.white10,
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Colors.brown.shade800,
                            child: Text(snapshot.data[index].initials)),
                        title: Text(snapshot.data[index].name),
                        subtitle: Text(snapshot.data[index].email),
                        selected: snapshot.data[index].selected,
                        onTap: () => _usersBloc.updateUser.add(
                            snapshot.data[index]
                              ..selected = !snapshot.data[index].selected),
                      ));
                });
          }),
      StreamBuilder<bool>(
          stream: Provider.of<UsersBloc>(context, listen: false).loading,
          initialData: false,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) return buildLoader();
            return SizedBox.shrink();
          })
    ]);
  }
}
