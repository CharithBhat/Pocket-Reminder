import 'package:flutter/material.dart';

class QuickTodoForm extends StatelessWidget {
  final String name;
  final ValueChanged<String> onChangedName;
  final VoidCallback onSavedTodo;

  QuickTodoForm({
    this.name = '',
    @required this.onChangedName,
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
      initialValue: name,
      maxLines: 1,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'title',
      ),
      onChanged: onChangedName,
      validator: (value) {
        if (value.isEmpty) {
          return "title cannot be empty";
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
