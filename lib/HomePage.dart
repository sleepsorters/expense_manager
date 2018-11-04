import 'package:flutter/material.dart';

import 'package:expense/ExpensePage.dart';
import 'package:expense/Expense.dart';

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
  String _budget = "100.00";
  double allowance = 100.00;
  double expenditures = 0.00;
  List<Expense> expenseList = [];
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
                        allowance = double.parse(myController.text);
                        _budget = (allowance - expenditures).toStringAsFixed(2);
                      });
                    },
                  ),
                ],
              );
            }
        );
      }

      void _addItem() {
        final nameController = TextEditingController();
        final categoryController = TextEditingController();
        final priceController = TextEditingController();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return SimpleDialog(
                title: new Text("Add expense"),
                children: <Widget>[
                  TextField(controller: nameController, decoration: InputDecoration(border: InputBorder.none, hintText: "Item"),),
                  TextField(controller: categoryController, decoration: InputDecoration(border: InputBorder.none, hintText: "Category"),),
                  TextField(controller: priceController, decoration: InputDecoration(border: InputBorder.none, hintText: "Price"),),
                  FlatButton(child: Text("Save"),
                  onPressed: ((){
                    Navigator.of(context).pop();
                    String name = nameController.text.toString();
                    double price = double.parse(priceController.text.toString());
                    expenseList.add(Expense(name: name, value: price, category: categoryController.text.toString()));
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return new Container(
                              child: new Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: new Text(
                                      'Your item, ' + name + ', has been added!',
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          ))));
                        });
                    setState((){
                      expenditures += double.parse(priceController.text.toString());
                      _budget = (allowance - expenditures).toStringAsFixed(2);
                    });
                    nameController.clear();
                    categoryController.clear();
                    priceController.clear();
                  }),)
                ],
              );
            }
        );
      }

      return MaterialApp(
        title: 'Welcome to Flutter',
        home: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('Your spending'),
          ),
          body: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "This months remaining budget:",
                      style: TextStyle(fontSize: 20.0),
                    )
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
                              ExpensePage.withList(expenseList)));
                        })
                  )
              ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addItem();
            },
            backgroundColor: Theme.of(context).accentColor,
            tooltip: 'Add item',
            child: Icon(Icons.add),
            elevation: 2.0,
          ),
        ),
      );
    }
  }


