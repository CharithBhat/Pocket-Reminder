import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/quickTodo.dart';
import 'package:todo_application/provider/quickTodo_list.dart';
import 'package:todo_application/screens/edit_quick_todo_screen.dart';
import 'package:todo_application/utilities/empty_list.dart';

class QuickTasks extends StatefulWidget {
  @override
  _QuickTasksState createState() => _QuickTasksState();
}

class _QuickTasksState extends State<QuickTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<QuickTodoList>(
        builder: (context, provider, child) {
          if (provider.quickTodoList.length == 0)
            return Center(
              child: EmptyList.empty(
                  context, PackageImage.Image_3, null, 'You have no Tasks'),
            );
          return ListView.builder(
            itemCount: provider.quickTodoList.length,
            itemBuilder: (BuildContext context, int index) {
              return singleItem(
                  index, provider.quickTodoList[index], context);
            },
          );
        },
      ),
    );
  }

  Widget singleItem(int index, snapshot, BuildContext context) {
    final provider = Provider.of<QuickTodoList>(context, listen: false);
    var _theDate =  DateTime.parse(snapshot.date);
    var _onlyDate = DateFormat('dd-MMM -yyyy').format(_theDate);
    return ClipRect(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        key: Key(snapshot.id),
        actions: [
          IconSlideAction(
            color: Colors.green,
            onTap: () => editQuickTodo(context, snapshot),
            caption: 'Edit',
            icon: Icons.edit,
          )
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            caption: 'Delete',
            onTap: () {
              provider.removeQuickTodo(snapshot);
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
                    snapshot.name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  subtitle: Text(
                    //snapshot.date,
                    _onlyDate.toString(),
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
  
  void editQuickTodo(BuildContext context, QuickTodo quickTodo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditQuickTodoScreen(quickTodo: quickTodo),
      ),
    );
  }
}