import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/database/dbhelper.dart';
import 'package:todo_application/models/birthdayTodo.dart';
import 'package:todo_application/provider/birthdayTodo_list.dart';
import 'package:todo_application/provider/notificationProvider.dart';

class BirthdayTasks extends StatefulWidget {
  @override
  _BirthdayTasksState createState() => _BirthdayTasksState();
}

class _BirthdayTasksState extends State<BirthdayTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Padding(
      //   padding: const EdgeInsets.only(top: 16.0, left: 16),
      child: Consumer<BirthdayTodoList>(
        builder: (context, provider, child) {
          if (provider.birthdayTodoList.length == 0)
            return Center(
              // child: EmptyList.empty(
              //     context, PackageImage.Image_1, null, 'Add a few birthdays'),
              child: Text("No birthdays"),
            );
          return ListView.builder(
            itemCount: provider.birthdayTodoList.length,
            itemBuilder: (BuildContext context, int index) {
              return singleItem(
                  index, provider.birthdayTodoList[index], context);
            },
          );
        },
      ),
    );
  }

  Widget singleItem(int index, snapshot, BuildContext context) {
    final provider = Provider.of<BirthdayTodoList>(context, listen: false);
    var _theDate = DateTime.parse(snapshot.birthDate);
    var _onlyDate = DateFormat('dd-MMM -yyyy').format(_theDate);
    return ClipRect(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        key: Key(snapshot.id),
        // actions: [
        //   IconSlideAction(
        //     color: Colors.red,
        //     caption: 'Delete',
        //     onTap: () {
        //       deleteTodo(context, snapshot);
        //       provider.removeBirthdayTodo(snapshot);
        //       final snackBar = SnackBar(content: Text('Deleted'));
        //       Scaffold.of(context).showSnackBar(snackBar);
        //     },
        //     icon: Icons.delete,
        //   )
        // ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            caption: 'Delete',
            onTap: () {
              deleteTodo(context, snapshot.id);
              deleteTodo(context, snapshot.id + '1');
              provider.removeBirthdayTodo(snapshot);
              final snackBar = SnackBar(content: Text('Deleted'));
              Scaffold.of(context).showSnackBar(snackBar);
            },
            icon: Icons.delete,
          )
        ],
        child: GestureDetector(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.only(top: 5),
                child: ListTile(
                  title: Text(
                    snapshot.name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  subtitle: Text(
                    _onlyDate.toString(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Center(
                      child: Text(
                        snapshot.name.substring(0, 1).toUpperCase(),
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void editReminderTodo(BuildContext context, ReminderTodo reminderTodo) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => EditScreen(reminderTodo: reminderTodo),
  //     ),
  //   );
  // }

  void deleteTodo(BuildContext context, String id) async {
    final dbhelper = DatabaseHelper.instance;
    dbhelper.deleteBirthdayTodo(id); // new
    final snackBar = SnackBar(content: Text('Deleted'));
    var fltrNotification = Notificationher().instance;
    await fltrNotification.cancel(int.parse(id));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
