import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/provider/reminderTodo_list.dart';

class CompletedTasks extends StatefulWidget {
  @override
  _CompletedTasksState createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<TodoList>(context, listen: true);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16),
        child: Consumer<TodoList>(
          builder: (context, provider, child) {
            if (provider.todoList != null) {
              return ListView.builder(
                itemCount: provider.todoList
                        .where((element) => element.completed == 1).toList()
                        .length,
                    
                itemBuilder: (BuildContext context, int index) {
                  // return provider.todoList[index].completed == 1
                  //     ? singleItem(index, provider.todoList[index])
                  //     : Container();
                  return singleItem(index, provider.todoList.where((element) => element.completed == 1).toList()[index]);
                },
              );
            }
            else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
    // final dbhelper = DatabaseHelper.instance;
    // return FutureBuilder(
    //   future: dbhelper.queryall(),
    //   builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
    //     if (snapshot.hasData) {
    //       return ListView.builder(
    //         itemCount:
    //             snapshot.data.where((element) => element.completed == 1).length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return snapshot.data
    //                       .where((element) => element.completed == 1)
    //                       .toList()[index]
    //                       .completed ==
    //                   1
    //               ? singleItem(index, snapshot.data[index])
    //               : Container();
    //         },
    //       );
    //     } else {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //   },
    // );
  }

  Widget singleItem(int index, snapshot) {
    return Column(
      children: [
        ListTile(
          title: Text(
            snapshot.title,
          ),
          subtitle: Text(
            snapshot.description,
          ),
          leading: Container(
            margin: EdgeInsets.all(5),
            color: Colors.green,
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
        Divider(thickness: 2),
      ],
    );
  }
}
