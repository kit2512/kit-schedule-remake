import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/service/services.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  var brightness;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _checkIfDarkModeEnabled();
    navigateToScreen();
  }

  /* void _checkIfDarkModeEnabled() {
    brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark)
      print("Dark mode");
    else
      print("Normal mode");
  }*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: AppColor.secondColor,
      ),
    )
        /*return Scaffold(
      backgroundColor:
          brightness == Brightness.dark ? Colors.black : AppColor.secondColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WidgetsConstants().kitLogo,
                SizedBox(
                  width: 20.w,
                ),
                Text("KIT Schedule",
                    style: ThemeText.headerStyle.copyWith(
                      fontSize: 24.sp,
                      color: AppColor.signInColor
                    ))
              ],
            ),
            //Box()
          ],
        ),
      ),
    )*/
        ;
  }

  Future initData() async {
    await Future.delayed(Duration(seconds: 3));
  }

  Future navigateToScreen() async {
    ShareService _shareService = ShareService();
    try {
      final isFirstRun = await _shareService.getIsFirstRun();
      if(isFirstRun)
        {
          await Permission.calendar.request();
          Navigator.pushReplacementNamed(context, '/introduction');
        }
     else

        Navigator.pushReplacementNamed(context, '/home');

    } catch (e) {
      debugPrint('SplashView - navigateToScreen - error: {$e}');
    }

//    Navigator.pushReplacementNamed(context, '/signIn');
  }
}
