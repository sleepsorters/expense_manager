import 'dart:math';

import 'package:flutter/material.dart';

import 'package:expense/ExpensePage.dart';
import 'package:expense/Expense.dart';
import 'package:expense/sample_circular_page.dart';

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
  String _budget = "1000.00";
  double allowance = 100.00;
  double expenditures = 0.00;
  Color indicator = Colors.green[400];
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
                    child: new Text("Save"),
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
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: TextField(controller: nameController, decoration: InputDecoration(border: InputBorder.none, hintText: "Item"),)
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: TextField(controller: categoryController, decoration: InputDecoration(border: InputBorder.none, hintText: "Category"),)
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: TextField(controller: priceController, decoration: InputDecoration(border: InputBorder.none, hintText: "Price"),)
                  ),
                  FlatButton(child: Text("Save"),
                  onPressed: ((){
                    Navigator.of(context).pop();
                    String name = nameController.text.toString();
                    double price = double.parse(priceController.text.toString());
                    expenseList.insert(0, Expense(name: name, value: price, category: categoryController.text.toString()));
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
                      if ((allowance - expenditures) / allowance < 0.5) {
                        indicator = Colors.yellow[400];
                      }
                      if ((allowance - expenditures) / allowance < 0.25) {
                        indicator = Colors.red[300];
                      }

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
              actions: <Widget>[
          IconButton(
          icon: Icon(Icons.update),
          tooltip: 'Air it',
          onPressed: _show,
        )],
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('Your spending'),
          ),
          body: Center(
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 80.0, bottom: 20.0),
                      child: Text(
                        "This months remaining budget:",
                        style: TextStyle(fontSize: 20.0),
                      )
                    ),
                  ),

                  new CircularPercentIndicator(
                    radius: 260.0,
                    lineWidth: 7.0,
                    percent: max((allowance - expenditures) / allowance, 0.0),
                    progressColor: indicator,
                    center: Text(
                      "\$" + _budget,
                      style: TextStyle(fontSize: 50.0),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(top:30.0, left: 120.0, right: 120.0),
              child: Container(
                width: 40.0,
                height: 40.0,
                child: SizedBox(
                  width: 40.0,
                  child: RaisedButton(
                      child: Text("View purchases"),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            ExpensePage.withList(expenseList)));
                      }),
                ),
              )
            )
              ]),
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the Drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Lili Chen'),
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
                ListTile(
                  title: Text('Purchase History'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        ExpensePage.withList(expenseList)));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Settings'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer

                  },
                ),
              ],
            ),
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


