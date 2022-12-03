import 'package:attendance_app/app/controllers/page_index_controller.dart';
import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:attendance_app/app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 26,
            ),
            decoration: BoxDecoration(
              color: primaryGreenColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
          Center(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.streamUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.waveDots(
                      size: 24,
                      color: primaryGreenColor,
                    ),
                  );
                }
                if (snapshot.hasData) {
                  Map<String, dynamic> user = snapshot.data!.data()!;
                  String defaultProfilePhoto =
                      "https://ui-avatars.com/api/?bold=true&font-size=0.3&background=random&&name=${user['name']}";
                  return ListView(
                    padding: EdgeInsets.all(26),
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                height: 86,
                                width: 86,
                                decoration: BoxDecoration(
                                  color: greyColor,
                                  borderRadius: BorderRadius.circular(34),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(32),
                                child: Container(
                                  height: 80,
                                  child: Image.network(
                                    user["profile"] != null
                                        ? user["profile"] != ""
                                            ? user["profile"]
                                            : defaultProfilePhoto
                                        : defaultProfilePhoto,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${user['name']}",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: interBold.copyWith(
                          fontSize: 20,
                          color: lightGreyColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${user['email']}",
                        textAlign: TextAlign.center,
                        style: interLight.copyWith(
                          fontSize: 12,
                          color: lightGreyColor,
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        // height: MediaQuery.of(context).size.height * .5,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 26,
                        ),
                        decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Tile(
                                testing: () => Get.toNamed(
                                    Routes.UPDATE_PROFILE,
                                    arguments: user),
                                icon: FontAwesomeIcons.userGear,
                                title: "Update Profile",
                              ),
                              SizedBox(height: 10),
                              Tile(
                                testing: () {
                                  Get.toNamed(Routes.UPDATE_PASSWORD);
                                },
                                icon: FontAwesomeIcons.gear,
                                title: "Update Password",
                              ),
                              if (user["role"] == "admin") SizedBox(height: 10),
                              if (user["role"] == "admin")
                                Tile(
                                  testing: () =>
                                      Get.toNamed(Routes.ADD_PEGAWAI),
                                  icon: FontAwesomeIcons.userPlus,
                                  title: "Add Account",
                                ),
                              SizedBox(height: 10),
                              Material(
                                color: redColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () => controller.logout(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.rightFromBracket,
                                          size: 14,
                                          color: greyColor,
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          "Logout",
                                          style: interSemiBold.copyWith(
                                              fontSize: 14, color: greyColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("Gagal memuat Data user nya jon."),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => ConvexAppBar(
          style: TabStyle.fixedCircle,
          backgroundColor: primaryGreenColor,
          elevation: 0,
          height: 60,
          items: [
            TabItem(
              icon: Icon(
                FontAwesomeIcons.house,
                size: 18,
                color: pageC.pageIndex.value == 0
                    ? lightGreyColor
                    : lightGreyColor.withOpacity(.5),
              ),
            ),
            TabItem(
              icon: pageC.isLoading.isFalse
                  ? FontAwesomeIcons.fingerprint
                  : FontAwesomeIcons.fingerprint,
            ),
            TabItem(
              icon: Icon(
                FontAwesomeIcons.solidUser,
                size: 18,
                color: pageC.pageIndex.value == 2
                    ? lightGreyColor
                    : lightGreyColor.withOpacity(.5),
              ),
            ),
          ],
          onTap: (int i) async {
            if (pageC.isLoading.isFalse) {
              Get.dialog(
                Dialog(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    height: 120,
                    width: 50,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadingAnimationWidget.prograssiveDots(
                            color: greenColor,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
              await pageC.changePage(i);
            } else {}
          },
          initialActiveIndex: pageC.pageIndex.value,
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.testing,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final Function() testing;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: greyColor,
          style: BorderStyle.solid,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: testing,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: darkGreenColor,
              ),
              SizedBox(width: 20),
              Text(
                title,
                style:
                    interSemiBold.copyWith(fontSize: 14, color: darkGreenColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
