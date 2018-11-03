import 'package:flutter/material.dart';

import 'package:expense/ExpensePage.dart';

class HomePage extends StatefulWidget {
  _HomePage hP;
  @override
  _HomePage createState() => hP;

  HomePage() {
    hP = new _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);
  String _budget = "";

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      void _show() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Set your budget!"),
                content: TextField(
                  controller: myController,
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState((){
                        _budget = myController.text;
                      });
                    },
                  ),
                ],
              );
            }
        );
      }

      void _addItem() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return SimpleDialog(
                title: new Text("Add expense"),
                children: <Widget>[

                ],
              );
            }
        );
      }

      return MaterialApp(
        title: 'Welcome to Flutter',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Your spending'),
          ),
          body: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "This months remaining budget:",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "\$" + _budget,
                    style: TextStyle(fontSize: 50.0),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 200.0),
                    child: RaisedButton(
                        child: Text("Set your budget"),
                        onPressed: _show)
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 200.0),
                      child: RaisedButton(
                          child: Text("View purchases"),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              ExpensePage()));
                        })
                  )
              ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addItem();
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
              ExpensePage()));
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
            elevation: 2.0,
          ),
        ),
      );
    }
  }


