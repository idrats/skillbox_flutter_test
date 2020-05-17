import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:skillbox_test/models/todo.dart';
import 'package:skillbox_test/services/helpers.dart';
import 'package:skillbox_test/services/todos_bloc.dart';

class TodosTab extends StatefulWidget {
  @override
  _TodosTabState createState() => _TodosTabState();
}

class _TodosTabState extends State<TodosTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Provider.of<TodosBloc>(context, listen: false).fetchTodos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(children: <Widget>[
      StreamBuilder<List<Todo>>(
          stream: Provider.of<TodosBloc>(context, listen: false).todos,
          initialData: [],
          builder: (context, snapshot) {
            return ListView.builder(
                key: PageStorageKey('todosListView'),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            color: snapshot.data[index].completed
                                ? Colors.green[200]
                                : Colors.white10,
                            child: Text(
                              snapshot.data[index].title,
                              style: TextStyle(fontSize: 15),
                            )),
                        Divider(height: 1, indent: 16, endIndent: 16)
                      ]);
                });
          }),
      StreamBuilder<bool>(
          stream: Provider.of<TodosBloc>(context, listen: false).loading,
          initialData: false,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) return buildLoader();
            return SizedBox.shrink();
          })
    ]);
  }
}
