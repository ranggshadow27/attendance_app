import 'package:attendance_app/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: greyColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Forgot Password",
                style: interBold.copyWith(
                  fontSize: 24,
                  color: darkGreenColor,
                ),
              ),
              Text(
                "Dont worry just fill the field, we’ll sent recovery.",
                style: interLight.copyWith(
                  color: darkGreyColor,
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Email",
                style:
                    interSemiBold.copyWith(fontSize: 16, color: darkGreenColor),
              ),
              SizedBox(height: 8),
              TextField(
                controller: controller.emailC,
                cursorColor: darkGreenColor,
                style: interMedium.copyWith(color: darkGreenColor),
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: Icon(FontAwesomeIcons.solidEnvelope,
                      color: primaryGreenColor, size: 20),
                  labelText: "example@gmail.com",
                  labelStyle: interMedium.copyWith(
                      fontSize: 16, color: lightBorderColor),
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
              Obx(
                () => Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        controller.resetPassword();
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
                          ? 'Send Password Reset'
                          : 'Loading..',
                      style: interSemiBold.copyWith(
                          color: greyColor, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
