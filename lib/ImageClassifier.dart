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
  Set<ImageInformation> _infos;
  List<Widget> _widgetList = [Text("")];
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  @override
  void initState() {
    print('got here');
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    InfoFetcher infoFetcher = new InfoFetcher();
    _infos = await infoFetcher.fetchInfo();
    setState((){
      _widgetList = getFormattedCategories(_infos);
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
              children: _widgetList
          )
      ),
    );
  }
}