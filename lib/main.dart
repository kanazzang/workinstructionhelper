import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'configuration.dart';
import 'home_page.dart';

void main() async {
  Configuration.strWO = (Uri.base.queryParameters["WO"]==null)?Configuration.strWO:Uri.base.queryParameters["WO"]; //get parameter with attribute "para1"
  Configuration.strWID = (Uri.base.queryParameters["WID"]==null)?Configuration.strWID:Uri.base.queryParameters["WID"]; //get parameter with attribute "para2"

  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
    initialBinding: BindingsBuilder(() {
    }),
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.home,
    // theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
  ));
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
    ),
  ];
}

abstract class Routes{
  static const home = "/";
}