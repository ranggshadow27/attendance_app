import 'package:attendance_app/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
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
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 26),
        children: [
          Text(
            "Add Account",
            style: interBold.copyWith(
              fontSize: 24,
              color: darkGreenColor,
            ),
          ),
          Text(
            "Add your employee account here.",
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
            enableInteractiveSelection: false,
            cursorColor: darkGreenColor,
            style: interMedium.copyWith(
              color: darkGreenColor,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Icon(FontAwesomeIcons.key,
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
            enableInteractiveSelection: false,
            cursorColor: darkGreenColor,
            style: interMedium.copyWith(
              color: darkGreenColor,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Icon(FontAwesomeIcons.userTie,
                  color: primaryGreenColor, size: 16),
              labelText: "account name here ..",
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
            "Job / Position",
            style: interSemiBold.copyWith(fontSize: 16, color: darkGreenColor),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller.jobC,
            enableInteractiveSelection: false,
            cursorColor: darkGreenColor,
            style: interMedium.copyWith(
              color: darkGreenColor,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Icon(FontAwesomeIcons.userGroup,
                  color: primaryGreenColor, size: 16),
              labelText: "insert a job or position ..",
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
          Obx(
            () => Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.addPegawai();
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
                  controller.isLoading.isFalse ? 'Add Account' : 'Loading ..',
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
