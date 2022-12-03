import 'package:attendance_app/app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPegawaiController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddPegawai = false.obs;
  RxBool isShowPassword = false.obs;

  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddPegawai.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text,
        );

        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: 'password@123',
        );

        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;

          await firestore.collection('pegawai').doc(uid).set({
            "nip": nipC.text,
            "name": nameC.text,
            "email": emailC.text,
            "role": "pegawai",
            "uid": uid,
            "job": jobC.text,
            "createdAt": DateTime.now().toIso8601String(),
          });

          await userCredential.user!.sendEmailVerification();

          await auth.signOut();

          // await auth.signInWithEmailAndPassword(email: email, password: password)
          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passAdminC.text,
          );

          Get.back();
          Get.back();
          Get.snackbar('Berhasil', 'Mantap jon, udah kedaftar usernya');
          isLoadingAddPegawai.value = false;
        }

        print(userCredential);
      } on FirebaseAuthException catch (e) {
        isLoadingAddPegawai.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar('Error', 'passwordnya kegampangan jon');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar('Error', 'email ini udah kedaftar jon');
        } else if (e.code == 'wrong-password') {
          Get.snackbar('Error', 'Password salah jon');
        } else {
          Get.snackbar("Error", "${e.code}");
        }
      } catch (e) {
        isLoadingAddPegawai.value = false;
        Get.snackbar('Error', 'ini eror general, gatau kenapa');
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Error", "Password Wajib diisi jon");
    }
    ;
  }

  Future<void> addPegawai() async {
    if (nameC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        jobC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
        radius: 12,
        backgroundColor: greyColor,
        titlePadding: EdgeInsets.only(top: 20),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        titleStyle: interSemiBold.copyWith(color: darkGreenColor),
        title: "Validasi Admin",
        content: Column(
          children: [
            Text("Input password untuk Validasi Admin"),
            SizedBox(height: 20),
            Obx(
              () => TextField(
                controller: passAdminC,
                obscureText: isShowPassword.value,
                enableInteractiveSelection: false,
                cursorColor: darkGreenColor,
                style: interMedium.copyWith(color: darkGreenColor),
                decoration: InputDecoration(
                  prefixIcon: Icon(FontAwesomeIcons.lock,
                      color: primaryGreenColor, size: 20),
                  labelText: "password",
                  suffixIcon: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      isShowPassword.value = !isShowPassword.value;
                    },
                    child: Icon(
                      isShowPassword.isFalse
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                      color: primaryGreenColor,
                      size: 20,
                    ),
                  ),
                  labelStyle: interMedium.copyWith(
                      fontSize: 16, color: lightBorderColor),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: lightBorderColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: darkGreenColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
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
              "Cancel",
              style: interSemiBold.copyWith(
                color: primaryGreenColor,
                fontSize: 12,
              ),
            ),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (isLoadingAddPegawai.isFalse) {
                  await prosesAddPegawai();
                }
                isLoading.value = false;
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: primaryGreenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                isLoadingAddPegawai.isFalse ? "Add Pegawai" : 'Loading ..',
                style: interSemiBold.copyWith(
                  color: greyColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      Get.snackbar('Haduh eror brayy', 'Semua kolom harus diisi dulu');
    }
  }
}
