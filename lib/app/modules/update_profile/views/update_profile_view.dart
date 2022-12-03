import 'dart:io';

import 'package:attendance_app/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.nipC.text = user['nip'];
    controller.emailC.text = user['email'];
    controller.nameC.text = user['name'];
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: greyColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              FontAwesomeIcons.arrowLeftLong,
              size: 20,
              color: darkGreenColor,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 26),
        children: [
          Text(
            "Update Profile",
            style: interBold.copyWith(
              fontSize: 24,
              color: darkGreenColor,
            ),
          ),
          Text(
            "You may update your account things here.",
            style: interLight.copyWith(
              color: darkGreyColor,
            ),
          ),
          SizedBox(height: 40),
          Text(
            "NIP",
            style: interSemiBold.copyWith(fontSize: 16, color: darkGreenColor),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller.nipC,
            enabled: false,
            cursorColor: darkGreenColor,
            style: interMedium.copyWith(
              color: darkGreenColor,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Icon(FontAwesomeIcons.solidEnvelope,
                  color: primaryGreenColor, size: 16),
              labelText: "insert account NIP",
              labelStyle:
                  interMedium.copyWith(fontSize: 14, color: lightBorderColor),
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
          SizedBox(height: 20),
          Text(
            "Name",
            style: interSemiBold.copyWith(fontSize: 16, color: darkGreenColor),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller.nameC,
            cursorColor: darkGreenColor,
            // autocorrect: false,
            style: interMedium.copyWith(
              color: darkGreenColor,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Icon(FontAwesomeIcons.solidEnvelope,
                  color: primaryGreenColor, size: 16),
              labelStyle:
                  interMedium.copyWith(fontSize: 14, color: lightBorderColor),
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
          SizedBox(height: 20),
          Text(
            "Email",
            style: interSemiBold.copyWith(fontSize: 16, color: darkGreenColor),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller.emailC,
            enabled: false,
            enableInteractiveSelection: false,
            cursorColor: darkGreenColor,
            style: interMedium.copyWith(
              color: darkGreenColor,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Icon(FontAwesomeIcons.solidEnvelope,
                  color: primaryGreenColor, size: 16),
              labelText: "example@gmail.com",
              labelStyle:
                  interMedium.copyWith(fontSize: 14, color: lightBorderColor),
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
          SizedBox(height: 20),
          Text(
            "Profile Photo",
            style: interSemiBold.copyWith(fontSize: 16, color: darkGreenColor),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user["profile"] != "" && user["profile"] != null) {
                      return Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Image.network(user["profile"]),
                            ),
                          ),
                          SizedBox(width: 12),
                          IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              controller.deleteProfileImage(user["uid"]);
                            },
                            icon: Icon(
                              FontAwesomeIcons.circleXmark,
                              color: redColor,
                            ),
                          ),
                        ],
                      );
                    }
                    return Text(
                      "No Images Choosen",
                      style: interMedium,
                    );
                  }
                },
              ),
              OutlinedButton(
                onPressed: () {
                  controller.pickImages();
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(
                    color: lightBorderColor,
                  ),
                ),
                child: Text(
                  "Choose file",
                  style: interBold.copyWith(
                    color: primaryGreenColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Obx(
            () => Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.updateProfile(user['uid']);
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: primaryGreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  controller.isLoading.isFalse
                      ? 'Update Profile'
                      : 'Loading ..',
                  style: interSemiBold.copyWith(
                    color: greyColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
