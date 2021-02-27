import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final ValueChanged<String> onChangedTitle;
  final VoidCallback onSavedTodo;

  TodoFormWidget({
    this.title = '',
    @required this.onChangedTitle,
    @required this.onSavedTodo,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTitle(),
          SizedBox(height: 8),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      initialValue: title,
      maxLines: 1,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'title',
      ),
      onChanged: onChangedTitle,
      validator: (value) {
        if (value.isEmpty) {
          return "title cannot be empty";
        }
        return null;
      },
    );
  }

  // Widget buildDescription() {
  //   return TextFormField(
  //     maxLines: 1,
  //     initialValue: description,
  //     decoration: InputDecoration(
  //       border: UnderlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(
  //           color: Colors.amber,
  //           style: BorderStyle.solid,
  //         ),
  //       ),
  //       labelText: 'description',
  //     ),
  //     onChanged: onChangedDescription,
  //     validator: (value) {
  //       if (value.isEmpty) {
  //         return "description cannot be empty";
  //       }
  //       return null;
  //     },
  //   );
  // }

  Widget buildButton() {
    return RaisedButton(
      onPressed: onSavedTodo,
      color: Colors.green,
      child: Text('Save'),
    );
  }
}
