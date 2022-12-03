import 'package:attendance_app/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Password",
                  style: interBold.copyWith(
                    fontSize: 24,
                    color: darkGreenColor,
                  ),
                ),
                Text(
                  "Please change the default password before you go.",
                  style: interLight.copyWith(
                    color: darkGreyColor,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "New Password",
                  style: interSemiBold.copyWith(
                      fontSize: 16, color: darkGreenColor),
                ),
                SizedBox(height: 8),
                Obx(
                  () => TextField(
                    controller: controller.newPasswordC,
                    obscureText: controller.isShowPassword.value,
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
                          controller.isShowPassword.value =
                              !controller.isShowPassword.value;
                        },
                        child: Icon(
                            controller.isShowPassword.isFalse
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: primaryGreenColor,
                            size: 20),
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.newPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: primaryGreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "CONFIRM",
                    style:
                        interSemiBold.copyWith(color: greyColor, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
