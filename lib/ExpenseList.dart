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
                  child: Text(expense.name, textAlign: TextAlign.left),
                ),
                Expanded(
                  child: Text("\$" + expense.value.toString(), textAlign: TextAlign.right),
                )
              ]
          ),
          subtitle: new Text(expense.category)
      );
}