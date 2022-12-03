import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void resetPassword() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        isLoading.value = false;
        Get.back();
        Get.snackbar("Berhasil", "Cek email buat reset password jon.");
      } catch (e) {
        Get.snackbar("Error", "Gagal mengirim Email reset Passwordnya jon.");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
