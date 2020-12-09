import 'package:flutter/material.dart';
import 'package:todo_application/widgets/todo_form_widget.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  final _formkey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: height / 3,
        // width: width / 2,
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add todo'),
              SizedBox(height: 8),
              TodoFormWidget(
                onChangedTitle: (title) {
                  setState(() {
                    this.title = title;
                  });
                },
                onChangedDescription: (description) {
                  setState(() {
                    this.description = description;
                  });
                },
                onSavedTodo: editTodo,
              ),
            ],
          ),
        ),
      );
  }

  void editTodo(Todo todo){
    
  }
}