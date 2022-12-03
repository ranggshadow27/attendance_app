import 'package:attendance_app/app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isShowPassword = true.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passwordC.text,
        );
        print(userCredential);
        // Get.offAllNamed(Routes.HOME);
        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;

            if (passwordC.text == "password@123") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              radius: 12,
              backgroundColor: greyColor,
              titlePadding: EdgeInsets.only(top: 20),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              titleStyle: interSemiBold.copyWith(color: darkGreenColor),
              middleTextStyle: interMedium.copyWith(
                color: darkGreenColor,
                fontSize: 14,
              ),
              title: "Email Verification",
              middleText: "Belom diverif ni akunnya jon, coba diverif dulu yak",
              actions: [
                OutlinedButton(
                  onPressed: () {
                    isLoading.value = false;
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: lightBorderColor),
                    ),
                  ),
                  child: Text(
                    "Kembali",
                    style: interSemiBold.copyWith(
                      color: primaryGreenColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar("Berhasil", "Silahkan cek emailmu jon");
                      isLoading.value = false;
                    } catch (e) {
                      Get.snackbar(
                          'Error', 'Alah gabisa ngirim verifikasinya jon');
                      isLoading.value = false;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: primaryGreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Verifikasi Email",
                    style: interSemiBold.copyWith(
                      color: greyColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            );
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'wrong-password') {
          Get.snackbar('Error', 'passwordnya salah ini jon');
        } else if (e.code == 'user-not-found') {
          Get.snackbar('Error', 'email ini kaga kedaftar jon');
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Error', 'ini eror general, gatau kenapa');
      }
    } else {
      Get.snackbar('Gagal Login', 'Haduh diisi dulu lah itu baru login');
    }
  }
}
