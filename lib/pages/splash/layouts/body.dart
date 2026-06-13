import 'package:flutter/material.dart';
import 'package:mono_app/pages/splash/layouts/text.dart';
import 'package:mono_app/size_config.dart';


class Body extends StatelessWidget {
  const Body({super.key});

      
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/Icon.png',
                        width: getProportionateScreenWidth(40),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(15),
                      ),
                      TextSplash()
                    ],
                  ),
                )
              ],
            )));
  }
}
