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
              itemCount: provider.todoList
                  .where((element) => element.completed == 1)
                  .length,
              itemBuilder: (BuildContext context, int index) {
                return provider.todoList[index].completed == 1
                    ? singleItem(index, provider)
                    : Container();
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
    );
  }
}
