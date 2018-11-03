import 'package:flutter/material.dart';

class StatefulWidgetPage extends StatefulWidget {
  _StatefulWidgetPage hP;
  @override
  _StatefulWidgetPage createState() => hP;

  StatefulWidgetPage() {
    hP = new _StatefulWidgetPage();
  }
}

class _StatefulWidgetPage extends State<StatefulWidgetPage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';

    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(title)
          ),
          body: Container(child: Text('df'))
      ),
    );
  }
}