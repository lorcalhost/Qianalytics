import 'package:flutter/material.dart';
import 'package:qianalytics/Constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    var titleFontSize = height * 0.065;
    var menuItemsFontSize = height * 0.04;
    var menuItemFontWeight = FontWeight.w300;
    var iconSize = height * 0.035;
    var menuIconsColor = Colors.teal[300];
    var spacingLeft = width * 0.025;

    void rename() {
      Navigator.of(context).pushNamed('/welcome');
    }

    return Scaffold(
      body: Container(
        color: Colors.teal[5],
        child: Stack(
          children: <Widget>[
            Constants.getBackgroundWidget(height),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: Row(
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.1),
                ),
                Container(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: spacingLeft, top: height * 0.07),
                              ),
                              Icon(
                                Icons.settings_backup_restore,
                                color: menuIconsColor,
                                size: iconSize,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: spacingLeft),
                              ),
                              Text(
                                '- Change name',
                                style: TextStyle(
                                  fontSize: menuItemsFontSize,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontWeight: menuItemFontWeight,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            rename();
                          },
                        ),
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: spacingLeft, top: height * 0.07),
                              ),
                              Icon(
                                Icons.person,
                                color: menuIconsColor,
                                size: iconSize,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: spacingLeft),
                              ),
                              Text(
                                '- About me',
                                style: TextStyle(
                                  fontSize: menuItemsFontSize,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontWeight: menuItemFontWeight,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            launch('https://github.com/lorcalhost');
                          },
                        ),
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: spacingLeft, top: height * 0.07),
                              ),
                              Icon(
                                Icons.monetization_on,
                                color: menuIconsColor,
                                size: iconSize,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: spacingLeft),
                              ),
                              Text(
                                '- Donate',
                                style: TextStyle(
                                  fontSize: menuItemsFontSize,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontWeight: menuItemFontWeight,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            launch('https://paypal.me/callegari');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
