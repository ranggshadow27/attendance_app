import 'dart:io';

import 'package:attendance_app/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Change Password",
                  style: interBold.copyWith(
                    fontSize: 24,
                    color: darkGreenColor,
                  ),
                ),
                Text(
                  "Update your password for more account security.",
                  style: interLight.copyWith(
                    color: darkGreyColor,
                  ),
                ),
                SizedBox(height: 60),
                Text(
                  "Current Password",
                  style: interSemiBold.copyWith(
                      fontSize: 16, color: darkGreenColor),
                ),
                SizedBox(height: 8),
                Obx(
                  () => TextField(
                    controller: controller.currentPasswordC,
                    obscureText: controller.isShowCPassword.value,
                    enableInteractiveSelection: false,
                    cursorColor: darkGreenColor,
                    style: interMedium.copyWith(
                      color: darkGreenColor,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.lockOpen,
                          color: primaryGreenColor, size: 16),
                      labelText: "Current Password",
                      suffixIcon: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          controller.isShowCPassword.value =
                              !controller.isShowCPassword.value;
                        },
                        child: Icon(
                            controller.isShowCPassword.isFalse
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: primaryGreenColor,
                            size: 16),
                      ),
                      labelStyle: interMedium.copyWith(
                          fontSize: 14, color: lightBorderColor),
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
                SizedBox(height: 20),
                Text(
                  "New Password",
                  style: interSemiBold.copyWith(
                      fontSize: 16, color: darkGreenColor),
                ),
                SizedBox(height: 8),
                Obx(
                  () => TextField(
                    controller: controller.newPasswordC,
                    obscureText: controller.isShowNPassword.value,
                    enableInteractiveSelection: false,
                    cursorColor: darkGreenColor,
                    style: interMedium.copyWith(
                      color: darkGreenColor,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.lock,
                          color: primaryGreenColor, size: 16),
                      labelText: "New Password",
                      suffixIcon: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          controller.isShowNPassword.value =
                              !controller.isShowNPassword.value;
                        },
                        child: Icon(
                            controller.isShowNPassword.isFalse
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: primaryGreenColor,
                            size: 16),
                      ),
                      labelStyle: interMedium.copyWith(
                          fontSize: 14, color: lightBorderColor),
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
                SizedBox(height: 20),
                Text(
                  "Confirm New Password",
                  style: interSemiBold.copyWith(
                      fontSize: 16, color: darkGreenColor),
                ),
                SizedBox(height: 8),
                Obx(
                  () => TextField(
                    controller: controller.confirmNewPasswordC,
                    obscureText: controller.isShowCNPassword.value,
                    enableInteractiveSelection: false,
                    cursorColor: darkGreenColor,
                    style: interMedium.copyWith(
                      color: darkGreenColor,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.lock,
                          color: primaryGreenColor, size: 16),
                      labelText: "Confirm New Password",
                      suffixIcon: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          controller.isShowCNPassword.value =
                              !controller.isShowCNPassword.value;
                        },
                        child: Icon(
                            controller.isShowCNPassword.isFalse
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: primaryGreenColor,
                            size: 16),
                      ),
                      labelStyle: interMedium.copyWith(
                          fontSize: 14, color: lightBorderColor),
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
                SizedBox(height: 30),
                Obx(
                  () => Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.isLoading.isFalse) {
                          controller.updatePassword();
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
                            ? "Update Password"
                            : "Loading ..",
                        style: interSemiBold.copyWith(
                          color: greyColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
