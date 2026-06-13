import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mono_app/controllers/account_controller.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountController>();

    Widget buildSettingItem({
      required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap,
      Color? iconColor,
      Color? textColor,
    }) {
      final isDark = Get.isDarkMode;
      final resolvedIconColor = iconColor ?? (isDark ? Colors.white70 : Colors.black54);
      final resolvedTextColor = textColor ?? (isDark ? Colors.white : Colors.black87);
      final resolvedSubtitleColor = isDark ? Colors.white54 : Colors.black54;
      final resolvedTrailingColor = isDark ? Colors.white38 : Colors.black38;

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.black.withValues(alpha: 0.04), 
            width: 1,
          ),
        ),
        child: ListTile(
          onTap: onTap,
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: resolvedIconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: resolvedIconColor, size: 22),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: resolvedTextColor,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: resolvedSubtitleColor, fontSize: 12),
          ),
          trailing: Icon(Icons.chevron_right, color: resolvedTrailingColor),
        ),
      );
    }

    return Column(
      children: [
        buildSettingItem(
          icon: Icons.language,
          title: 'settings_language_title'.tr,
          subtitle: 'settings_language_subtitle'.tr,
          onTap: () {
            final currentLocale = Get.locale;
            final box = GetStorage('MoNo');
            if (currentLocale?.languageCode == 'id') {
              Get.updateLocale(const Locale('en', 'US'));
              box.write('language', 'en');
            } else {
              Get.updateLocale(const Locale('id', 'ID'));
              box.write('language', 'id');
            }
          },
        ),
        buildSettingItem(
          icon: Icons.dark_mode_outlined,
          title: 'settings_theme_title'.tr,
          subtitle: 'settings_theme_subtitle'.tr,
          onTap: () {
            final box = GetStorage('MoNo');
            if (Get.isDarkMode) {
              Get.changeThemeMode(ThemeMode.light);
              box.write('is_dark', false);
            } else {
              Get.changeThemeMode(ThemeMode.dark);
              box.write('is_dark', true);
            }
          },
        ),
        buildSettingItem(
          icon: Icons.help_outline_outlined,
          title: 'settings_help_title'.tr,
          subtitle: 'settings_help_subtitle'.tr,
          onTap: () {
            Get.snackbar('Support', 'Hubungi kami di support@mono.app');
          },
        ),
        const SizedBox(height: 24),
        buildSettingItem(
          icon: Icons.logout_outlined,
          title: 'settings_logout_title'.tr,
          subtitle: 'settings_logout_subtitle'.tr,
          iconColor: Colors.redAccent,
          textColor: Colors.redAccent,
          onTap: () {
            Get.dialog(
              AlertDialog(
                backgroundColor: Get.theme.colorScheme.surface,
                title: Text('logout_dialog_title'.tr),
                content: Text('logout_dialog_message'.tr),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text('cancel'.tr),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                      controller.logout();
                    },
                    child: Text('logout_btn'.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
