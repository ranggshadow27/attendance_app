import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;

import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void pickImages() async {
    image = await picker.pickImage(source: ImageSource.gallery);

    update();
  }

  void deleteProfileImage(String uid) async {
    try {
      await firestore.collection("pegawai").doc(uid).update(
        {
          "profile": FieldValue.delete(),
        },
      );
      Get.back();
      Get.snackbar("Berhasil", "Sukses mereset potonya");
    } catch (e) {
      Get.snackbar("Error", "Gagal hapus poto profilenya jon");
    }
  }

  Future<void> updateProfile(String uid) async {
    Map<String, dynamic> data = {
      'name': nameC.text,
    };

    if (nameC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref("${uid}/profile.${ext}").putFile(file);
          String urlImage =
              await storage.ref("${uid}/profile.${ext}").getDownloadURL();

          data.addAll({"profile": urlImage});
        }
        await firestore.collection('pegawai').doc(uid).update(data);
        image = null;

        Get.back();
        Get.snackbar("Berhasil", "Mantap, Coba cek profilemu jon");
      } catch (e) {
        Get.snackbar('Error', 'Gagal Update profile jon');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
