import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NewPasswordController extends GetxController {
  RxBool isShowPassword = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController newPasswordC = TextEditingController();

  void newPassword() async {
    if (newPasswordC.text.isNotEmpty) {
      if (newPasswordC.text != "password@123") {
        try {
          String currentUserEmail = auth.currentUser!.email!;
          await auth.currentUser!.updatePassword(newPasswordC.text);
          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: currentUserEmail, password: newPasswordC.text);
          Get.offAllNamed(Routes.HOME);
          Get.snackbar("Berhasil", "Mantap password barunya keupdate jon");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar('Error', 'passwordnya kegampangan jon');
          }
        } catch (e) {
          Get.snackbar('Error', 'ini eror general, gatau kenapa');
        }
      } else {
        Get.snackbar("Error", "Yailah ini passwordnya sama kek default jon");
      }
    } else {
      Get.snackbar("Error", "Password harus diisi dulu lah jon astaga");
    }
  }
}
