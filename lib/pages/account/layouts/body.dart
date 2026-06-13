import 'package:flutter/material.dart';
import 'package:mono_app/pages/account/layouts/profile_info.dart';
import 'package:mono_app/pages/account/layouts/settings_list.dart';
import 'package:mono_app/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const ProfileInfo(),
          SizedBox(height: getProportionateScreenHeight(24)),
          const SettingsList(),
        ],
      ),
    );
  }
}
