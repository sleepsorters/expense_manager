import 'package:flutter/material.dart';

import 'package:expense/Expense.dart';
//adapted from https://hackernoon.com/flutter-iii-lists-and-items-6bfa7348ab1b

class ExpenseList extends StatelessWidget {

  final List<Expense> _expense;
  ExpenseList(this._expense);

  @override
  Widget build(BuildContext context) {
    return new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _buildContactList()
    );
  }

  List<ExpenseListItem> _buildContactList() {
    return _expense.map((expense) => new ExpenseListItem(expense))
        .toList();
  }
}

class ExpenseListItem extends ListTile {
  ExpenseListItem(Expense expense):
        super(
          title: new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(expense.name, textAlign: TextAlign.left),
                  ),
                ),
                Expanded(
                  child: Text("\$" + (expense.value).toStringAsFixed(2), textAlign: TextAlign.right),
                ),

              ]
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(expense.category, textAlign: TextAlign.left,),
              Divider(color: Colors.black)
            ],
          ),

      );
}