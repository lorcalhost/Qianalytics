import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qianalytics/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

var uname = '';

class FirstTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    var titleFontSize = width * 0.14;
    var generalFontSize = width * 0.09;
    var buttonFontSize = width * 0.045;
    var buttonFontWeight = FontWeight.w300;

    void saveAndGoBack() async {
      final prefs = await SharedPreferences.getInstance();
      if (uname.isNotEmpty && uname != '') {
        await prefs.setBool('isFirstTime', false);
        await prefs.setString('username', uname);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
      }
    }

    return Scaffold(
      body: Container(
        color: Colors.teal[5],
        child: Stack(
          children: <Widget>[
            Constants.getBackgroundWidget(height),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Welcome to',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  Container(
                    padding:
                        EdgeInsets.only(left: width * 0.05, top: height * 0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "What's your name?",
                              style: TextStyle(
                                fontSize: generalFontSize,
                                fontFamily: 'Roboto',
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.03),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'My name is ',
                              style: TextStyle(
                                  fontSize: generalFontSize,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              width: width * 0.4,
                              child: TextField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                enableInteractiveSelection: false,
                                style: TextStyle(
                                  fontSize: generalFontSize,
                                  fontFamily: 'Roboto',
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 0),
                                ),
                                inputFormatters: [
                                  BlacklistingTextInputFormatter
                                      .singleLineFormatter,
                                  LengthLimitingTextInputFormatter(25),
                                ],
                                onChanged: (input) {
                                  uname = input;
                                },
                                onSubmitted: (input) {
                                  saveAndGoBack();
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.015),
                        ),
                        Row(
                          children: <Widget>[
                            RaisedButton(
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                  fontSize: buttonFontSize,
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  fontWeight: buttonFontWeight,
                                ),
                              ),
                              color: Colors.teal[300],
                              elevation: 0,
                              splashColor: Colors.teal[100],
                              onPressed: () {
                                saveAndGoBack();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
