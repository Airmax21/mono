import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mono_app/size_config.dart';

class ContainerOnboarding extends StatelessWidget {
  
  GetStorage box = GetStorage();

  ContainerOnboarding({super.key});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.blue[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
      height: getProportionateScreenHeight(350),
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(50),
          ),
          Text(
            'onboard_header'.tr,
            textAlign: TextAlign.center,
            style: Get.textTheme.headlineLarge,
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Text(
            'onboard_description'.tr,
            textAlign: TextAlign.center,
            style: Get.textTheme.headlineSmall,
          ),
          SizedBox(
            height: getProportionateScreenHeight(50),
          ),
          ElevatedButton(
            onPressed: () {
              box.write('onboarding_read', true);
              Get.offNamed('/dashboard');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Get.isDarkMode ? Colors.white : Colors.blue[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 120,
                vertical: 15,
              ),
            ),
            child: Text(
              'onboard_button'.tr,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.blue[900] : Colors.white,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
