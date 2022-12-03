import 'package:attendance_app/app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../routes/app_pages.dart';
import '../controllers/all_absensi_controller.dart';

class AllAbsensiView extends GetView<AllAbsensiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryGreenColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              FontAwesomeIcons.arrowLeftLong,
              size: 20,
              color: greyColor,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Stack(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Text(
                      "Presence Detail",
                      style: interBold.copyWith(
                        fontSize: 24,
                        color: lightGreyColor,
                      ),
                    ),
                    Text(
                      "there you go, your detail presence.",
                      style: interLight.copyWith(
                        color: greyColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.dialog(
                            Dialog(
                              child: Container(
                                height: 400,
                                padding: EdgeInsets.all(20),
                                child: SfDateRangePicker(
                                  monthViewSettings:
                                      DateRangePickerMonthViewSettings(
                                          firstDayOfWeek: 1),
                                  selectionMode:
                                      DateRangePickerSelectionMode.range,
                                  showActionButtons: true,
                                  onCancel: () => Get.back(),
                                  onSubmit: (dateRange) {
                                    if (dateRange != null) {
                                      if ((dateRange as PickerDateRange)
                                              .endDate !=
                                          null) {
                                        controller.datePick(
                                            dateRange.startDate!,
                                            dateRange.endDate!);
                                      }
                                    } else {}
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Filter by Date",
                          style: interMedium.copyWith(
                            color: darkGreenColor,
                            fontSize: 12,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightGreyColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GetBuilder<AllAbsensiController>(
                      builder: (c) =>
                          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: controller.getAllPresence(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: LoadingAnimationWidget.waveDots(
                                size: 24,
                                color: primaryGreenColor,
                              ),
                            );
                          }
                          if (snapshot.data?.docs.length == 0) {
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Text("Belum ada History Data"),
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              // Map<String, dynamic> dataAbsen =
                              //     snapshot.data!.docs.reversed.toList()[index].data();

                              Map<String, dynamic> dataAbsen =
                                  snapshot.data!.docs[index].data();

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
                                    borderRadius: BorderRadius.circular(14),
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 100,
                                                child: Text(
                                                  dataAbsen["masuk"]?["date"] ==
                                                          null
                                                      ? "-"
                                                      : "${DateFormat.jms().format(DateTime.parse(dataAbsen["masuk"]!["date"]))}",
                                                  style: interMedium.copyWith(
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
                                                  style: interMedium.copyWith(
                                                    color: darkGreenColor,
                                                    fontSize: 14,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              signStatus(
                                                  "MASUK", lightGreenColor),
                                              Icon(
                                                FontAwesomeIcons.circle,
                                                color: greyColor,
                                                size: 16,
                                              ),
                                              signStatus(
                                                  "pulang", lightRedColor),
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
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryGreenColor,
        onPressed: () {
          Get.back();
          Get.toNamed(Routes.ALL_ABSENSI);
        },
        child: Icon(
          FontAwesomeIcons.rotateLeft,
          size: 18,
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
