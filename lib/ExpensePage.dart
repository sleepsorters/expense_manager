import 'dart:async';

import 'package:flutter/material.dart';

import 'package:expense/Expense.dart';
import 'package:expense/ExpenseList.dart';

class ExpensePage extends StatefulWidget {
  _ExpensePageState hP;
  @override
  _ExpensePageState createState() => hP;

  ExpensePage() {
    hP = new _ExpensePageState();
  }

  ExpensePage.withList(List eL) {
    hP = new _ExpensePageState.withList(eL);
  }

  }

class _ExpensePageState extends State<ExpensePage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  List expenseList;
  _ExpensePageState() {
    expenseList = null;
  }

  _ExpensePageState.withList(List eL) {
    expenseList = eL;
  }

  var url, request, response;
  String value, error;
  Set<Expense> expenses;
  Future<Set<Expense>> eFuture;

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  initPlatformState() async {
    Set<Expense> exp = await fetchExpenses();

    setState(() {
      expenses = exp;
    }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Purchase History'),
        ),
        body: new ExpenseList(expenseList)

    );
  }

  Future<Set<Expense>> fetchExpenses() async {
    Set<Expense> expenses = new Set<Expense>();
    expenses.add(Expense(name: "Sheng Kee", value: 100, category: "boba"));
    expenses.add(Expense(name: "Sheng Kee", value: 200, category: "boba"));
    expenses.add(Expense(name: "La Vals", value: 100, category: "pizza"));
    return expenses;
  }

}