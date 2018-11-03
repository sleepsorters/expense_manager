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
  }

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
          body: Container(child: Text('hi'))
      ),
    );
  }
}