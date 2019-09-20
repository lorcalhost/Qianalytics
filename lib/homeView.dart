import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qianalytics/Constants.dart';
import 'package:qianalytics/singninWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String username = '';
double rate = 0.0;
String rateLastUpdatedDateString = '';
String sheetslast = '';

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();

  bool isFirstTime = true;
  num eur = 0.0;
  num cny = 0.0;
  var eurController = TextEditingController();
  var cnyController = TextEditingController();
  var eurFontWeight = FontWeight.w300;
  var cnyFontWeight = FontWeight.w300;
  var generalFontWeight = FontWeight.w300;
  var currencyFontWeight = FontWeight.w400;

  @override
  void initState() {
    super.initState();
    checkIsFirstTime();
  }

  String getNowDateTime() {
    var now = new DateTime.now();
    var date = DateFormat('dd/MM/yyyy').format(now).toString();
    var time = DateFormat('H:m:s').format(now).toString();
    return 'Last updated on $date at $time';
  }

  checkIsFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFirstTime = (prefs.getBool('isFirstTime') ?? true);
    });
    if (isFirstTime == true) {
      prefs.setDouble('rate', 7.63);
      prefs.setString('rateLastUpdatedDateString', 'Last updated: never');
      prefs.setString('sheets', 'None'); // ONE HERE
      Navigator.of(context).pushNamed('/welcome');
    } else {
      updateUserName();
      updateSheet();
      getRate();
      updateRate();
      eurController.text = '0.0';
      cnyController.text = '0.0';
    }
  }

  updateUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String u = prefs.getString('username');
    setState(() => username = u);
  }

  updateRate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double r = prefs.getDouble('rate');
    String s = prefs.getString('rateLastUpdatedDateString');
    setState(() => rate = r);
    setState(() => rateLastUpdatedDateString = s);
  }

  updateSheet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String s = prefs.getString('sheets');
    setState(() => sheetslast = s);
  }

  getRate() async {
    var response =
        await http.get('https://api.exchangeratesapi.io/latest?symbols=CNY');
    if (response.statusCode == 200) {
      double parsed = json.decode(response.body)['rates']['CNY'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setDouble('rate', parsed);
      prefs.setString('rateLastUpdatedDateString', getNowDateTime());
    }
  }

  void eur2cny() {
    setState(() {
      cny = (((eur * rate) * 100).round()) / 100;
    });
  }

  void cny2eur() {
    setState(() {
      eur = (((cny / rate) * 100).round()) / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    var titleFontSize = width * 0.135;
    var textViewWidth = width * 0.8;
    var textViewFontSize = width * 0.166;
    var currentlyFontSize = width * 0.063;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // Background
            Constants.getBackgroundWidget(height),
            ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.right,
                color: Colors.teal[100],
                child: TabBarView(
                  children: <Widget>[
                    // Exchange view
                    Container(
                      color: Colors.teal[5],
                      child: Column(
                        children: <Widget>[
                          // TITLE
                          Container(
                            padding: EdgeInsets.only(
                                left: width * 0.04, top: height * 0.05),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Qian',
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontFamily: 'Roboto',
                                    color: Colors.teal,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'alytics',
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontFamily: 'Roboto',
                                    color: Colors.teal,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Manage your 钱.
                          Container(
                            padding: EdgeInsets.only(left: width * 0.06),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Manage your 钱, ',
                                  style: TextStyle(
                                    fontSize: height * 0.02,
                                    fontFamily: 'Roboto',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '$username',
                                  style: TextStyle(
                                    fontSize: height * 0.02,
                                    fontFamily: 'Roboto',
                                    color: Colors.teal,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '.',
                                  style: TextStyle(
                                    fontSize: height * 0.02,
                                    fontFamily: 'Roboto',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.1),
                                ),
                                Container(
                                  height: height * 0.2,
                                  padding: EdgeInsets.only(right: width * 0.05),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      // CNY TEXTVIEW
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        width: textViewWidth,
                                        child: TextField(
                                          textAlign: TextAlign.end,
                                          enableInteractiveSelection: false,
                                          controller: cnyController,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          inputFormatters: [
                                            BlacklistingTextInputFormatter(
                                              RegExp('[\\-|\\ |\\,]'),
                                            ),
                                          ],
                                          style: TextStyle(
                                            fontWeight: cnyFontWeight,
                                            fontSize: textViewFontSize,
                                            fontFamily: 'Roboto',
                                            color: Colors.teal,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                bottom: height * 0.012),
                                          ),
                                          onChanged: (input) {
                                            if (input.isEmpty) {
                                              setState(() {
                                                cny = 0.0;
                                              });
                                            } else {
                                              setState(() {
                                                cny = num.parse(input);
                                              });
                                            }
                                            cny2eur();
                                            eurController.text = '$eur';
                                          },
                                          onEditingComplete: () {
                                            if (cny == 0) {
                                              cnyController.text = '0.0';
                                            }
                                            cnyFontWeight = FontWeight.w300;
                                            SystemChannels.textInput
                                                .invokeMethod('TextInput.hide');
                                          },
                                          onTap: () {
                                            setState(() {
                                              eurFontWeight = FontWeight.w300;
                                              cnyFontWeight = FontWeight.w400;
                                            });
                                            if (cny == 0) {
                                              eurController.text = '0.0';
                                              cnyController.text = '';
                                            }
                                          },
                                        ),
                                      ),
                                      // ¥ TEXT
                                      Text(
                                        '¥',
                                        style: TextStyle(
                                          fontSize: textViewFontSize,
                                          fontFamily: 'Roboto',
                                          color: Colors.black,
                                          fontWeight: currencyFontWeight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*Padding(
                                  padding: EdgeInsets.all(1),
                                ),*/
                                Container(
                                  padding: EdgeInsets.only(right: width * 0.05),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      // EURO TEXTVIEW
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        width: textViewWidth,
                                        child: TextField(
                                          textAlign: TextAlign.end,
                                          enableInteractiveSelection: false,
                                          controller: eurController,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          inputFormatters: [
                                            BlacklistingTextInputFormatter(
                                              RegExp('[\\-|\\ |\\,]'),
                                            ),
                                          ],
                                          style: TextStyle(
                                            fontWeight: eurFontWeight,
                                            fontSize: textViewFontSize,
                                            fontFamily: 'Roboto',
                                            color: Colors.teal,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                bottom: height * 0.012),
                                          ),
                                          onChanged: (input) {
                                            if (input.isEmpty) {
                                              setState(() {
                                                eur = 0.0;
                                              });
                                            } else {
                                              setState(() {
                                                eur = num.parse(input);
                                              });
                                            }
                                            eur2cny();
                                            cnyController.text = '$cny';
                                          },
                                          onEditingComplete: () {
                                            if (eur == 0) {
                                              eurController.text = '0.0';
                                            }
                                            eurFontWeight = FontWeight.w300;
                                            SystemChannels.textInput
                                                .invokeMethod('TextInput.hide');
                                          },
                                          onTap: () {
                                            if (eur == 0) {
                                              eurController.text = '';
                                              cnyController.text = '0.0';
                                            }
                                            setState(() {
                                              eurFontWeight = FontWeight.w400;
                                              cnyFontWeight = FontWeight.w300;
                                            });
                                          },
                                        ),
                                      ),
                                      // € TEXT
                                      Text(
                                        '€',
                                        style: TextStyle(
                                          fontSize: textViewFontSize,
                                          fontFamily: 'Roboto',
                                          color: Colors.black,
                                          fontWeight: currencyFontWeight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Tooltip(
                            message: rateLastUpdatedDateString,
                            decoration: BoxDecoration(
                              color: Colors.teal[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: // Currently
                                Padding(
                              padding: EdgeInsets.only(top: height * 0.04),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Card(
                                    elevation: 1.5,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: width * 0.01),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: width * 0.02),
                                            ),
                                            Text(
                                              'Currently ',
                                              style: TextStyle(
                                                fontSize: currentlyFontSize,
                                                fontFamily: 'Roboto',
                                                color: Colors.black,
                                                fontWeight: currencyFontWeight,
                                              ),
                                            ),
                                            Text(
                                              '1',
                                              style: TextStyle(
                                                fontSize: currentlyFontSize,
                                                fontFamily: 'Roboto',
                                                color: Colors.teal[300],
                                                fontWeight: currencyFontWeight,
                                              ),
                                            ),
                                            Text(
                                              '€ ',
                                              style: TextStyle(
                                                fontSize: currentlyFontSize,
                                                fontFamily: 'Roboto',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              '= ',
                                              style: TextStyle(
                                                fontSize: currentlyFontSize,
                                                fontFamily: 'Roboto',
                                                color: Colors.black,
                                                fontWeight: currencyFontWeight,
                                              ),
                                            ),
                                            Text(
                                              ((rate * 1000).round() / 1000)
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: currentlyFontSize,
                                                fontFamily: 'Roboto',
                                                color: Colors.teal[300],
                                                fontWeight: currencyFontWeight,
                                              ),
                                            ),
                                            Text(
                                              ' ¥',
                                              style: TextStyle(
                                                fontSize: currentlyFontSize,
                                                fontFamily: 'Roboto',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.02),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: width * 0.01),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.05),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Manager View
                    Stack(
                      children: <Widget>[
                        Center(
                          child:
                              /*Column(
                            children: <Widget>[
                              gSignin.signinButton(),
                              GestureDetector(
                                onTap: () {
                                  updateSheet();
                                },
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  color: Colors.yellow,
                                  child: Text('hello $sheetslast'),
                                ),
                              ),
                            ],
                          ),*/
                              Text(
                            'Coming soon',
                            style: TextStyle(
                              fontSize: height * 0.05,
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Settings icon
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(width * 0.04),
                  child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: width * 0.08,
                      color: Colors.teal[300],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/settings');
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
