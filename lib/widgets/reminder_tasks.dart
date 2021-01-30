import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/reminderTodo.dart';
import 'package:todo_application/provider/reminderTodo_list.dart';
import 'package:todo_application/screens/edit_screen.dart';

class ReminderTasks extends StatefulWidget {
  @override
  _ReminderTasksState createState() => _ReminderTasksState();
}

class _ReminderTasksState extends State<ReminderTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Padding(
      //   padding: const EdgeInsets.only(top: 16.0, left: 16),
      child: Consumer<ReminderTodoList>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.reminderTodoList.length,
            itemBuilder: (BuildContext context, int index) {
              return singleItem(
                  index, provider.reminderTodoList[index], context);
            },
          );
        },
      ),
    );
  }

  Widget singleItem(int index, snapshot, BuildContext context) {
    final provider = Provider.of<ReminderTodoList>(context, listen: false);
    return ClipRect(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        key: Key(snapshot.id),
        actions: [
          IconSlideAction(
            color: Colors.green,
            onTap: () => editReminderTodo(context, snapshot),
            caption: 'Edit',
            icon: Icons.edit,
          )
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            caption: 'Delete',
            onTap: () {
              provider.removeReminderTodo(snapshot);
              final snackBar = SnackBar(content: Text('Deleted'));
              Scaffold.of(context).showSnackBar(snackBar);
            },
            icon: Icons.delete,
          )
        ],
        child: GestureDetector(
          // onTap: () => editTodo(context, provider.todoList[index]),
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.only(top: 5),
                child: ListTile(
                  onTap: () {
                    provider.toggleCompletion(snapshot);
                  },
                  title: Text(
                    snapshot.title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  subtitle: Text(
                    snapshot.description,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  leading: snapshot.completed == 1
                      ? Container(
                          margin: EdgeInsets.all(5),
                          color: Colors.green,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: 25,
                          height: 25,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: Colors.green,
                            ),
                          ),
                        ),
                ),
              ),
              //Divider(thickness: 2),
            ],
          ),
        ),
      ),
    );
  }

  void editReminderTodo(BuildContext context, ReminderTodo reminderTodo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditScreen(reminderTodo: reminderTodo),
      ),
    );
  }

  // YO DONT FORGET THIS SHIT!!!!!!!!!!!!!!   Never called it thats why it wasn't deleting i guess...

  // void deleteTodo(BuildContext context, ReminderTodo reminderTodo) async {
  //   final dbhelper = DatabaseHelper.instance;
  //   dbhelper.deleteReminderTodo(reminderTodo.id); // new
  //   // String polishedId = todo.id.substring(todo.id.length - 4);
  //   // int specialId = int.parse(polishedId);
  //   final snackBar = SnackBar(content: Text('Deleted'));
  //   //var fltrNotification = new FlutterLocalNotificationsPlugin();
  //   //await fltrNotification.cancel(0);
  //   var fltrNotification = Notificationher().notific;
  //   await fltrNotification.cancel(0);
  //   Scaffold.of(context).showSnackBar(snackBar);
  // }
}
