import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/birthdayTodo.dart';
import 'package:todo_application/provider/birthdayTodo_list.dart';
import 'package:todo_application/widgets/todo_form_widget.dart';

class BirthdayTodoDialog extends StatefulWidget {
  @override
  _BirthdayTodoDialogState createState() => _BirthdayTodoDialogState();
}

class _BirthdayTodoDialogState extends State<BirthdayTodoDialog> {

  final _formkey = GlobalKey<FormState>();
  String title = '';
  DateTime pickedDate;
  // TimeOfDay time;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    // time = TimeOfDay.now(); 
  }
 
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: AlertDialog(
        //insetPadding: EdgeInsets.symmetric(horizontal: 0)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        content: Container(
          //height: height,
          width: width,
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
                  onSavedTodo: addTodo,
                ),
                ListTile(
                  title: Text(
                      "Date: ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _pickDate,
                ),
                // ListTile(
                //   title: Text("Time: ${time.hour}:${time.minute}"),
                //   trailing: Icon(Icons.keyboard_arrow_down),
                //   onTap: _pickTime,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime(DateTime.now().year + 50),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  // _pickTime() async {
  //   TimeOfDay t = await showTimePicker(context: context, initialTime: time);
  //   if (t != null)
  //     setState(() {
  //       time = t;
  //     });
  // }

  void addTodo() {
    final isValid = _formkey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final todo = BirthdayTodo(
        id: DateTime.now().toIso8601String(),
        name: title,
        date: DateTime.now().toIso8601String(),
        birthDate: pickedDate.toString(),
      );
      final provider = Provider.of<BirthdayTodoList>(context, listen: false);
      provider.addBirthdayTodo(todo);
      Navigator.of(context).pop();
      // _showNotification(todo.title, todo.id);
    }
  }
}