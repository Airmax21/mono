import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/size_config.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/icons/Icon.png'),
            ),
            SizedBox(width: getProportionateScreenWidth(15)),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Good Morning", style: Get.textTheme.bodySmall),
                  Text("Costumer", style: Get.textTheme.titleSmall)
                ],
              ),
            )
          ],
        ));
  }
}
