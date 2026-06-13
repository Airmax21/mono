import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mono_app/database/api_client.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AccountController extends GetxController {
  final box = GetStorage('MoNo');
  final ApiClient api = Get.find<ApiClient>();
  
  final userName = 'Customer'.obs;
  final userEmail = 'customer@email.com'.obs;
  final profilePhotoPath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    syncWithBackend();
  }

  void loadUserData() {
    userName.value = box.read<String>('user_name') ?? 'Customer';
    final email = box.read<String>('user_email') ?? 'customer@email.com';
    userEmail.value = email;
    profilePhotoPath.value = box.read<String>('user_profile_photo_$email') ?? box.read<String>('user_profile_photo') ?? '';
  }

  Future<void> syncWithBackend() async {
    try {
      final profile = await api.getProfile();
      if (profile != null) {
        if (profile['name'] != null) {
          userName.value = profile['name'] as String;
          box.write('user_name', userName.value);
        }
        if (profile['email'] != null) {
          userEmail.value = profile['email'] as String;
          box.write('user_email', userEmail.value);
        }
        final remotePhoto = profile['profile_photo'] as String?;
        final localPath = await api.syncProfilePhoto(remotePhoto, userEmail.value);
        profilePhotoPath.value = localPath;
      }
    } catch (e) {
      debugPrint('Failed to sync profile with backend: $e');
    }
  }

  Future<void> pickProfilePhoto() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      
      if (image != null) {
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        final String fileExtension = p.extension(image.path);
        final String newPath = p.join(appDocDir.path, 'profile_photo_${userEmail.value}$fileExtension');
        
        final File tempFile = File(image.path);
        // Overwrite if exists
        final File savedFile = await tempFile.copy(newPath);

        // Show uploading loader
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        String? remotePhotoUrl;
        try {
          remotePhotoUrl = await api.uploadProfilePhoto(savedFile);
        } finally {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
        }

        profilePhotoPath.value = savedFile.path;
        box.write('user_profile_photo', savedFile.path);
        box.write('user_profile_photo_${userEmail.value}', savedFile.path);
        if (remotePhotoUrl != null && remotePhotoUrl.isNotEmpty) {
          box.write('user_profile_photo_url_${userEmail.value}', remotePhotoUrl);
        }
        
        Get.snackbar(
          'Sukses',
          'Foto profil berhasil diperbarui',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.isDarkMode ? Colors.white : Colors.black87,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengunggah foto profil: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void logout() {
    box.remove('jwt_token');
    box.remove('refresh_token');
    box.remove('user_name');
    box.remove('user_email');
    box.remove('user_profile_photo');
    profilePhotoPath.value = '';
    Get.offAllNamed('/login');
  }
}
