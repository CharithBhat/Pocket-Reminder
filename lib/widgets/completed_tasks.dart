import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/provider/todo_list.dart';

class CompletedTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<TodoList>(context, listen: true);

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16),
        child: Consumer<TodoList>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.todoList.where((element) => element.completed).length + 1,
              itemBuilder: (BuildContext context, int index) {
                return provider.todoList[index].completed ?  singleItem(index, provider) : Container();
              },
            );
          },
        ),
      ),
    );
  }

  Widget singleItem(int index, provider) {
    return Column(
      children: [
        ListTile(
          title: Text(
            provider.todoList[index].title,
          ),
          subtitle: Text(
            provider.todoList[index].description,
          ),
          leading: provider.todoList[index].completed
              ? Icon(
                  Icons.check_circle,
                  color: Colors.greenAccent,
                )
              : Icon(
                  Icons.check_box,
                  color: Colors.orangeAccent,
                ),
        ),
        Divider(thickness: 2),
      ],
    );
  }
}