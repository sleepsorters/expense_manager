import 'package:flutter/material.dart';
import 'package:expense/ImageInformation.dart';
import 'package:expense/InfoFetcher.dart';
import 'package:expense/Keyword.dart';
import 'package:expense/Expense.dart';
import 'package:expense/ExpenseList.dart';

class ImageClassifier extends StatefulWidget {
  _ImageClassifier hP;
  @override
  _ImageClassifier createState() => hP;

  ImageClassifier() {
    hP = new _ImageClassifier();
  }

  ImageClassifier.withExpenseList(List<Expense> eL) {
    hP = new _ImageClassifier.withExpenseList(eL);
  }
}

class _ImageClassifier extends State<ImageClassifier> {
  List<Expense> expenseList;
  String expenseListString = "";
  _ImageClassifier() {
    expenseList = [];
  }
  _ImageClassifier.withExpenseList(List<Expense> eL) {
    expenseList = eL;
    expenseList.forEach((expense) => expenseListString += (expense.name + "\""));
  }
  Set<ImageInformation> _infos;
  Set<Keyword> _keywords;
  List<Widget> _widgetList = [Text("")];
  List<Widget> _widgetList2 = [Text("")];
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  @override
  void initState() {
    print('got here');
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    InfoFetcher infoFetcher = new InfoFetcher();
    _infos = await infoFetcher.fetchInfo(expenseListString);
    _keywords = await infoFetcher.fetchKeywords();
    print(_keywords);

    setState((){
      _widgetList = getFormattedCategories(_infos);
      _widgetList2 = getFormattedKeywords(_keywords);
    });
  }

  List <Widget> getFormattedCategories(infos) {
    List<Widget> ret = [Padding(padding: EdgeInsets.only(top: 20.0, left: 20.0), child: Text("TOP CATEGORIES", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)))];
    for (var info in infos) {
      ListTile lt = ListTile(
          title: Text((info.category + " (score: " + info.score.toStringAsFixed(2) + ")"), style: TextStyle(fontSize: 14.0)),
          subtitle: new LinearProgressIndicator(value: info.score, backgroundColor: Theme.of(context).highlightColor, valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))
      );
      ret.add(lt);
    }
    return ret;
  }

  List <Widget> getFormattedKeywords(keywords) {
    List<Widget> ret = [Padding(padding: EdgeInsets.only(top: 20.0, left: 20.0), child: Text("TOP KEYWORDS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)))];
    for (var keyword in keywords) {
      ListTile lt = ListTile(
          title: Text((keyword.word + " (relevance: " + keyword.relevance.toStringAsFixed(2) + ")"), style: TextStyle(fontSize: 14.0)),
          subtitle: new LinearProgressIndicator(value: keyword.relevance, backgroundColor: Theme.of(context).highlightColor, valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))
      );
      ret.add(lt);
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Analytics';

    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                tooltip: 'Back',
                onPressed: (() {
                  Navigator.pop(context);
                }
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(title)
          ),
          body: ListView(
              children: new List.from(_widgetList)..addAll(_widgetList2)
          )
      ),
    );
  }
}