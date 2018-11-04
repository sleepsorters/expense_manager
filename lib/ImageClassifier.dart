import 'package:flutter/material.dart';
import 'package:expense/ImageInformation.dart';
import 'package:expense/InfoFetcher.dart';

class ImageClassifier extends StatefulWidget {
  _ImageClassifier hP;
  @override
  _ImageClassifier createState() => hP;

  ImageClassifier() {
    hP = new _ImageClassifier();
  }
}

class _ImageClassifier extends State<ImageClassifier> {
  String _categories = "";
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  @override
  void initState() {
    print('got here');
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    InfoFetcher infoFetcher = new InfoFetcher();
    Set<ImageInformation> infos = await infoFetcher.fetchInfo();
    setState((){
      _categories = "";

      for (var info in infos) {
        _categories += info.category + "\n" + info.score.toString() + "\n";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Analytics';

    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(title)
          ),
          body: Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20.0),
              child: Text(_categories)
          )
      ),
    );
  }
}