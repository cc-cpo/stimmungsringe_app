import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'datamappings.dart';


class HierGehtsWeiterPage extends StatefulWidget {
  HierGehtsWeiterPage({Key key, this.title}) : super(key: key) {
    debugPrint('asdfsdfsdf');


  }

  final String title;

  @override
  _HierGehtsWeiterPageState createState() => _HierGehtsWeiterPageState();

}

class _HierGehtsWeiterPageState extends State<HierGehtsWeiterPage> {
  var _textControllerName = TextEditingController();
  var _textControllerEmail = TextEditingController();

  Future<String> loadData() async {

    String url = 'http://wvsvhackvirtuellestimmungsringe-env.eba-eug7bzt6.eu-central-1.elasticbeanstalk.com/stimmungsring/sample';

    http.Response response = await http.get(
        url, headers: {
          'X-User-ID': 'cafecafe-b855-46ba-b907-321d2d38beef'
    });

    log(response.body);

    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child:
          Column(
            children: [
              new Text('weiter hfasdfadsfsdfasdfe'),
              RaisedButton(child: Text('Load Data'),
              onPressed: () {
                log('loading..');
                loadData().then((bodyAsString) => log('got body'))
                .catchError((err) => log('error loading data ' + err.toString()));
              },)
            ],
          )

      ,);
  }
}
