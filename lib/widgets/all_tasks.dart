import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/database/dbhelper.dart';
import 'package:todo_application/models/todo.dart';
import 'package:todo_application/provider/todo_list.dart';
import 'package:todo_application/screens/edit_screen.dart';

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TodoList>(context, listen: false);
    final dbhelper = DatabaseHelper.instance;
    dbhelper.queryall().then(
          (value) => value.map(
            (todo) {
              provider.addTodo(todo);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16),
        child: Consumer<TodoList>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.todoList.length,
              itemBuilder: (BuildContext context, int index) {
                return singleItem(index, provider, context);
              },
            );
          },
        ),
      ),
    );
  }

  Widget singleItem(int index, provider, BuildContext context) {
    return ClipRect(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        key: Key(provider.todoList[index].id),
        actions: [
          IconSlideAction(
            color: Colors.green,
            onTap: () => editTodo(context, provider.todoList[index]),
            caption: 'Edit',
            icon: Icons.edit,
          )
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            caption: 'Delete',
            onTap: () => deleteTodo(context, provider.todoList[index]),
            icon: Icons.delete,
          )
        ],
        child: GestureDetector(
          // onTap: () => editTodo(context, provider.todoList[index]),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  provider.toggleCompletion(provider.todoList[index]);
                },
                title: Text(
                  provider.todoList[index].title,
                ),
                subtitle: Text(
                  provider.todoList[index].description,
                ),
                leading: provider.todoList[index].completed == 1
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
              Divider(thickness: 2),
            ],
          ),
        ),
      ),
    );
  }

  void editTodo(BuildContext context, Todo todo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditScreen(todo: todo),
      ),
    );
  }

  void deleteTodo(BuildContext context, Todo todo) {
    final dbhelper = DatabaseHelper.instance; // new
    final provider = Provider.of<TodoList>(context, listen: false);
    dbhelper.deleteTodo(todo.id); // new
    provider.removeTodo(todo);
    final snackBar = SnackBar(content: Text('Deleted'));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
