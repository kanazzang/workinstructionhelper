import 'dart:async';
import 'dart:ui';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'configuration.dart';

String strCurrentDate = formatDate(DateTime.now(), [yy, '-', mm, '-', dd]).toString();
String strCurrentTime = formatDate(DateTime.now(), [HH, ':', nn, ":", ss]).toString();

class TitleArea extends StatefulWidget {
  const TitleArea(BuildContext context, {Key? key}) : super(key: key);
  @override
  _TitleAreaState createState() => _TitleAreaState();
}

class _TitleAreaState extends State<TitleArea> {

  static bool bAppStarted = false;

  late Timer tmrTimer;
  late Timer tmrWeather;
  Color clrTimeText = Colors.black;

  @override
  void initState() {

    Timer.periodic(const Duration(milliseconds: 1000), (Timer tmrTimer) async {
      if (!bAppStarted) {
        setState(() {
          strCurrentDate = formatDate(DateTime.now(), [yy, '-', mm, '-', dd]).toString();
          strCurrentTime = formatDate(DateTime.now(), [HH, ':', nn, ":", ss]).toString();
        });
        bAppStarted = true;
      }
      else {
        setState(() {
          strCurrentDate = formatDate(DateTime.now(), [yy, '-', mm, '-', dd]).toString();
          strCurrentTime = formatDate(DateTime.now(), [HH, ':', nn, ":", ss]).toString();
        });
      }
    });

    Timer.periodic(const Duration(milliseconds: 1000 * 60), (Timer tmrWeather) async {
      setState(() {
        strCurrentDate = formatDate(DateTime.now(), [yy, '-', mm, '-', dd]).toString();
        strCurrentTime = formatDate(DateTime.now(), [HH, ':', nn, ':', ss]).toString();
      });
    });

    super.initState();
    // AdMob code will be added here
  }

  @override
  void dispose() {
    tmrTimer.cancel();
    tmrWeather.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/header_bg.png')
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/logo.png')
              ),
            ),
            child: const Text(""),
            width: 300.0 * Configuration.dSizeAdjustRatio,
            height: 150.0 * Configuration.dSizeAdjustRatio,
          ),
          Expanded(
            child: Center(
              child: Text(  Configuration.strDashBoardTitle, style: Configuration.tstMainTitle(),
          ))),
          Container(
            alignment: Alignment.bottomCenter,
            color: Colors.transparent,
            padding: EdgeInsets.all(10 * Configuration.dSizeAdjustRatio),
            child: ClipRect(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: InkWell(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(flex: 12),
                          Column (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text( strCurrentDate, style: Configuration.tstDateTime(), ),
                              Text( strCurrentTime, style: Configuration.tstDateTime(), ),
                            ]
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            width: 320.0 * Configuration.dSizeAdjustRatio
          ),
        ],
      ),
      height: 150 * Configuration.dSizeAdjustRatio,
    );
  }
}