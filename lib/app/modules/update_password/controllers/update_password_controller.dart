import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isShowCPassword = true.obs;
  RxBool isShowNPassword = true.obs;
  RxBool isShowCNPassword = true.obs;

  TextEditingController currentPasswordC = TextEditingController();
  TextEditingController newPasswordC = TextEditingController();
  TextEditingController confirmNewPasswordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePassword() async {
    if (currentPasswordC.text.isNotEmpty &&
        newPasswordC.text.isNotEmpty &&
        confirmNewPasswordC.text.isNotEmpty) {
      if (newPasswordC.text == confirmNewPasswordC.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currentPasswordC.text);

          await auth.currentUser!.updatePassword(newPasswordC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: newPasswordC.text);

          Get.back();
          Get.snackbar("Berhasil", "Mantapjon, udah keganti passwordnya");
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar("Error", "Password lamanya salah jon");
          } else {
            Get.snackbar("Error", "Ini gara gara ${e.code.toLowerCase()}");
          }
        } catch (e) {
          Get.snackbar("Error", "Ini error general, gatau kenapa");
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar(
            "Error", "Coba dicek lagi password barunya, gacocok soalnya jon");
      }
    } else {
      Get.snackbar("Error", "Yaa harus diisi dulu lah jon");
    }
  }
}
