import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  TodoFormWidget({
    this.title,
    this.description,
    @required this.onChangedTitle,
    @required this.onChangedDescription,
    @required this.onSavedTodo,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTitle(),
          SizedBox(height: 8),
          buildDescription(),
          SizedBox(height: 8),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      initialValue: title,
      onChanged: onChangedTitle,
      validator: (value) {
        if (value.isEmpty) {
          return "title cannot be empty";
        }
        return null;
      },
    );
  }

  Widget buildDescription() {
    return TextFormField(
      initialValue: description,
      onChanged: onChangedDescription,
      validator: (value) {
        if (value.isEmpty) {
          return "description cannot be empty";
        }
        return null;
      },
    );
  }

  Widget buildButton() {
    return RaisedButton(
      onPressed: onSavedTodo,
      child: Text('Save'),
    );
  }
}
