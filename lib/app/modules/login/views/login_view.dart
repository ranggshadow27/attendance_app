import 'package:attendance_app/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('LoginView'),
      //   centerTitle: true,
      // ),
      backgroundColor: greyColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(26),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back!",
                  style: interBold.copyWith(
                    fontSize: 24,
                    color: darkGreenColor,
                  ),
                ),
                Text(
                  "lets login to your account first.",
                  style: interLight.copyWith(
                    color: darkGreyColor,
                  ),
                ),
                SizedBox(height: 60),
                Text(
                  "Email",
                  style: interSemiBold.copyWith(
                      fontSize: 16, color: darkGreenColor),
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
                Text(
                  "Password",
                  style: interSemiBold.copyWith(
                      fontSize: 16, color: darkGreenColor),
                ),
                SizedBox(height: 8),
                Obx(
                  () => TextField(
                    controller: controller.passwordC,
                    obscureText: controller.isShowPassword.value,
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
                SizedBox(height: 30),
                Obx(
                  () => Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.login();
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
                        controller.isLoading.isFalse ? 'Sign In' : 'Loading..',
                        style: interSemiBold.copyWith(
                            color: greyColor, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.FORGOT_PASSWORD);
                    },
                    child: Text(
                      "Forgot Password",
                      style: interSemiBold.copyWith(color: primaryGreenColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
