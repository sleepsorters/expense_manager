import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DBTest extends StatefulWidget {
  _DBTest hP;
  @override
  _DBTest createState() => hP;

  DBTest() {
    hP = new _DBTest();
  }
}

class _DBTest extends State<DBTest> {
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