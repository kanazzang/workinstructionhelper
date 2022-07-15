import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:workinstructionhelper/title_area.dart';
import 'package:workinstructionhelper/workinstruction.dart';
import 'configuration.dart';
import 'helperdisplay.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            resizeToAvoidBottomInset:false,
            body: Stack(
              fit: StackFit.expand,
              children: [
                TitleAndLoginDisplay(),
              ],
            )
        )
    );
  }
}

class TitleAndLoginDisplay extends StatelessWidget {
  const TitleAndLoginDisplay({Key? key,}) : super(key: key);

  static bool bIconOnly = false;
  static bool bAutoScreenChange = false;
  static int iSecondCount = 0;
  static int iRefreshPeriod = 3;

  @override
  Widget build(BuildContext context) {
    Configuration.dSizeAdjustRatio = MediaQuery
        .of(context)
        .size
        .width / 1920.0;
    return Scaffold(
        body: Center(
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black,
                        Colors.grey,
                      ],
                    )
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Title Area
                      // TitleArea(context),
                      Expanded(
                        child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/left_bg.png')
                                  ),
                                ),
                                padding: EdgeInsets.all(
                                    5 * Configuration.dSizeAdjustRatio),
                                width: bIconOnly
                                    ? Configuration.dMenuItemMinWidth *
                                    Configuration.dSizeAdjustRatio
                                    : Configuration.dMenuItemWidth *
                                    Configuration.dSizeAdjustRatio,
                                child: ListView.builder(
                                  itemCount: arrMenuItem.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                        color: Colors.transparent,
                                        surfaceTintColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.transparent,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                          'images/left_menubg.png')
                                                  ),
                                                ),
                                                padding: EdgeInsets.fromLTRB(5 *
                                                    Configuration
                                                        .dSizeAdjustRatio, 10 *
                                                    Configuration
                                                        .dSizeAdjustRatio, 0,
                                                    10 * Configuration
                                                        .dSizeAdjustRatio),
                                              )
                                    );
                                  },
                                ),
                              ),
                                GestureDetector(
                                    child:Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'images/content_bg.png')
                                          ),
                                        ),
                                        child: Text("시작", style: Configuration.tstMainTitle(),),
                                      ),
                                     onTap: () {
                                      Get.off(() => WorkInstructionWidget(),
                                          // binding: UserLoginBinding());
                                          binding: BindingsBuilder(() {
                                            Get.put(WorkInstructionController(
                                                paramWorkInstruction:
                                                <String, String>{
                                                  "WO": Configuration.strWO!,
                                                  "WID": Configuration.strWID!,
                                                }
                                            )
                                            );
                                          })
                                      );
                                    }
                                ),
                            ]
                        ),
                      )
                    ]
                )
            )
        )
    );
  }
}
