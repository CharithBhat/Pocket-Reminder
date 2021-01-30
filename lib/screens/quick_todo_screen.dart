import 'package:flutter/material.dart';
import 'package:todo_application/models/quickTodo.dart';
import 'package:todo_application/screens/settings_screen.dart';
import 'package:todo_application/widgets/add_todo_dialog.dart';
import 'package:provider/provider.dart';

class QuickTodoScreen extends StatefulWidget {
  @override
  _QuickTodoScreenState createState() => _QuickTodoScreenState();
}

class _QuickTodoScreenState extends State<QuickTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quick Tasks',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).appBarTheme.color,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white, size: 30),
            tooltip: "add a Todo",
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                child: AddTodoDialog(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: "goes to the settings page",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Container()), // change this with the query all thing
          EnterMessage(),
        ],
      ),
    );
  }
}

class EnterMessage extends StatefulWidget {
  @override
  _EnterMessageState createState() => _EnterMessageState();
}

class _EnterMessageState extends State<EnterMessage> {

  final _controler = TextEditingController();
    var _enteredMessage = '';

  void _sendMessage(){
    FocusScope.of(context).unfocus();
    final provider = Provider.of(context, listen: false)._quickTodoList();
    provider.addQuickTodo(
      QuickTodo(
        name: _enteredMessage,
        id: DateTime.now().toIso8601String(),
        date: DateTime.now().toIso8601String(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.face), onPressed: () {}),
                  Expanded(
                    child: TextField(
                      controller: _controler,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      enableSuggestions: true,
                      onChanged: (value) {
                        setState(() {
                          _enteredMessage = value;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Type Something...",
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          // Container(
          //   padding: const EdgeInsets.all(15.0),
          //   decoration:
          //       BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          //   child: InkWell(
          //     child: Icon(
          //       Icons.send,
          //       color: Colors.white,
          //     ),
          //     // onLongPress: () {
          //     //   setState(() {
          //     //     _showBottom = true;
          //     //   });
          //     // },
          //   ),
          // )
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}


