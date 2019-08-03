import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qianalytics/homePage.dart';
import 'package:qianalytics/firstTimeView.dart';
import 'package:qianalytics/settingsPage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qianalytics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Qianalytics'),
      routes: <String, WidgetBuilder>{
        '/main': (BuildContext context) => MyHomePage(title: 'Qianalytics'),
        '/welcome': (BuildContext context) => FirstTime(),
        '/settings': (BuildContext context) => Settings(),
      },
    );
  }
}
