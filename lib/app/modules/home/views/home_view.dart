import 'package:attendance_app/app/controllers/page_index_controller.dart';
import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:attendance_app/app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGreenColor,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          children: [
                            SizedBox(height: 430),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Last 5 Days",
                                  style: interSemiBold.copyWith(
                                    color: darkGreenColor,
                                    fontSize: 14,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.ALL_ABSENSI);
                                  },
                                  child: Text(
                                    "See more",
                                    style: interSemiBold.copyWith(
                                      color: darkGreenColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      side: BorderSide(
                                        color: lightBorderColor,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: controller.streamLastPresence(),
                              builder: (context, snapshotPresence) {
                                if (snapshotPresence.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: LoadingAnimationWidget.waveDots(
                                      size: 24,
                                      color: primaryGreenColor,
                                    ),
                                  );
                                }
                                if (snapshotPresence.data?.docs.length == 0 ||
                                    snapshotPresence.data?.docs == null) {
                                  return SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Text("Belum ada History Data"),
                                    ),
                                  );
                                }
                                print(snapshotPresence);
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshotPresence.data?.docs.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> dataAbsen =
                                        snapshotPresence.data!.docs.reversed
                                            .toList()[index]
                                            .data();

                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Material(
                                        color: lightGreyColor,
                                        borderRadius: BorderRadius.circular(14),
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.DETAIL_ABSEN,
                                                arguments: dataAbsen);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          child: Container(
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              // color: Colors.grey[200],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${DateFormat("EEEE, d MMMM yyyy").format(DateTime.parse(dataAbsen["date"]))}",
                                                  style: interSemiBold.copyWith(
                                                    color: darkGreenColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Divider(),
                                                SizedBox(height: 12),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      child: Text(
                                                        dataAbsen["masuk"]
                                                                    ?["date"] ==
                                                                null
                                                            ? "-"
                                                            : "${DateFormat.jms().format(DateTime.parse(dataAbsen["masuk"]!["date"]))}",
                                                        style: interMedium
                                                            .copyWith(
                                                          color: darkGreenColor,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      child: Text(
                                                        dataAbsen["pulang"]
                                                                    ?["date"] ==
                                                                null
                                                            ? "-"
                                                            : "${DateFormat.jms().format(DateTime.parse(dataAbsen["pulang"]!["date"]))}",
                                                        style: interMedium
                                                            .copyWith(
                                                          color: darkGreenColor,
                                                          fontSize: 14,
                                                        ),
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 12),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    signStatus("MASUK",
                                                        lightGreenColor),
                                                    Icon(
                                                      FontAwesomeIcons.circle,
                                                      color: greyColor,
                                                      size: 16,
                                                    ),
                                                    signStatus("pulang",
                                                        lightRedColor),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
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
                    Padding(
                      padding: EdgeInsets.all(26),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 210,
                                    child: Text(
                                      "Hi! \n${user['name']}",
                                      style: interBold.copyWith(
                                        fontSize: 20,
                                        color: lightGreyColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    width: 220,
                                    child: Text(
                                      user["email"] != null
                                          ? "${user['email']}"
                                          : "belum ada lokasi Realtime",
                                      textAlign: TextAlign.left,
                                      style: interLight.copyWith(
                                        fontSize: 12,
                                        color: lightGreyColor,
                                      ),
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  ClipOval(
                                    child: Container(
                                        height: 70,
                                        width: 70,
                                        color: Colors.grey[200],
                                        child: SizedBox()),
                                  ),
                                  ClipOval(
                                    child: Container(
                                      height: 65,
                                      width: 65,
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: Image.network(
                                          user["profile"] != null
                                              ? user["profile"]
                                              : defaultProfilePhoto,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 26),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.locationPin,
                                color: lightGreyColor,
                              ),
                              SizedBox(width: 12),
                              Container(
                                width: 190,
                                child: Text(
                                  "${user['alamat']}",
                                  style: interLight.copyWith(
                                    color: lightGreyColor,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Spacer(),
                              Obx(
                                () => Container(
                                  width: 60,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      side: BorderSide(
                                        color: lightBorderColor,
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (controller.isLoading.isFalse) {
                                        Get.dialog(
                                          Dialog(
                                            elevation: 0,
                                            backgroundColor: Colors.transparent,
                                            child: Container(
                                              height: 120,
                                              width: 50,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    LoadingAnimationWidget
                                                        .prograssiveDots(
                                                      color: greenColor,
                                                      size: 40,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                        await controller.refreshPosition();
                                        Get.back();
                                      }
                                    },
                                    child: controller.isLoading.isFalse
                                        ? Icon(
                                            FontAwesomeIcons.rotate,
                                            size: 14,
                                            color: lightGreyColor,
                                          )
                                        : Text(
                                            "Wait..",
                                            style: interMedium.copyWith(
                                              fontSize: 8,
                                              color: lightGreyColor,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: lightGreyColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${DateFormat('EEEE, d MMMM yyyy').format(DateTime.now())}",
                                  style: interMedium.copyWith(
                                    color: darkGreenColor,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Divider(),
                                SizedBox(height: 4),
                                Text(
                                  "${user['nip']}",
                                  style: interBold.copyWith(
                                    color: darkGreenColor,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "${user['job']}",
                                  style: interMedium.copyWith(
                                    color: darkGreenColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(22),
                                width: 144,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: lightGreyColor,
                                ),
                                child: StreamBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: controller.streamTodayPresence(),
                                    builder: (context, snapshotTodayPresence) {
                                      if (snapshotTodayPresence
                                              .connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child:
                                              LoadingAnimationWidget.waveDots(
                                            size: 24,
                                            color: primaryGreenColor,
                                          ),
                                        );
                                      }

                                      Map<String, dynamic>? dataToday =
                                          snapshotTodayPresence.data?.data();
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "In",
                                                style: interBold.copyWith(
                                                    color: greenColor,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(width: 8),
                                              Icon(
                                                FontAwesomeIcons.caretUp,
                                                size: 12,
                                                color: greenColor,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            dataToday?['masuk'] == null
                                                ? "-"
                                                : "${DateFormat.jms().format(DateTime.parse(dataToday!['masuk']['date']))}",
                                            style: interMedium.copyWith(
                                                color: darkGreenColor,
                                                fontSize: 16),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              Container(
                                padding: EdgeInsets.all(22),
                                width: 144,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: lightGreyColor,
                                ),
                                child: StreamBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: controller.streamTodayPresence(),
                                    builder: (context, snapshotTodayPresence) {
                                      if (snapshotTodayPresence
                                              .connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child:
                                              LoadingAnimationWidget.waveDots(
                                            size: 24,
                                            color: primaryGreenColor,
                                          ),
                                        );
                                      }

                                      Map<String, dynamic>? dataToday =
                                          snapshotTodayPresence.data?.data();
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Out",
                                                style: interBold.copyWith(
                                                    color: redColor,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(width: 8),
                                              Icon(
                                                FontAwesomeIcons.caretDown,
                                                size: 12,
                                                color: redColor,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            dataToday?['pulang'] == null
                                                ? "-"
                                                : "${DateFormat.jms().format(DateTime.parse(dataToday!['pulang']['date']))}",
                                            style: interMedium.copyWith(
                                                color: darkGreenColor,
                                                fontSize: 16),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.waveDots(
                size: 24,
                color: primaryGreenColor,
              ),
            );
          }
        },
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
            }
          },
          initialActiveIndex: pageC.pageIndex.value,
        ),
      ),
    );
  }
}

Widget signStatus(
  String text,
  Color color,
) {
  return Container(
    width: 50,
    height: 24,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: color,
    ),
    child: Center(
      child: Text(
        text.toUpperCase(),
        style: interSemiBold.copyWith(
          fontSize: 8,
          color: darkGreenColor,
        ),
      ),
    ),
  );
}
