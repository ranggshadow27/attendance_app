import 'package:attendance_app/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_absen_controller.dart';

class DetailAbsenView extends GetView<DetailAbsenController> {
  final Map<String, dynamic> data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    // print(status);
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
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Container(
                height: MediaQuery.of(context).size.height * .6,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18),
                    Text(
                      "${DateFormat('EEEE, d MMMM yyyy').format(DateTime.parse(data['date']))}",
                      style: interMedium.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 6),
                    Divider(),
                    SizedBox(height: 10),
                    masukSign("Masuk", lightGreenColor),
                    SizedBox(height: 10),

                    clockRow(
                      data: data,
                      absen: "masuk",
                    ),
                    SizedBox(height: 10),

                    locationRow(
                      data: data,
                      absen: "masuk",
                    ),
                    SizedBox(height: 10),

                    statusRow(
                      data: data,
                      absen: "masuk",
                    ),
                    SizedBox(height: 20),

                    ///
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Divider(),
                      ),
                    ),

                    ///
                    SizedBox(height: 20),
                    masukSign("Pulang", lightRedColor),
                    SizedBox(height: 10),
                    clockRow(
                      data: data,
                      absen: "pulang",
                    ),
                    SizedBox(height: 10),
                    locationRow(
                      data: data,
                      absen: "pulang",
                    ),
                    SizedBox(height: 10),
                    statusRow(
                      data: data,
                      absen: "pulang",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget masukSign(
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
}

class clockRow extends StatelessWidget {
  const clockRow({
    Key? key,
    required this.data,
    required this.absen,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final String absen;
  @override
  Widget build(BuildContext context) {
    return data[absen] == null
        ? Text(
            "No presence data found.",
            style: interLight.copyWith(
              color: primaryGreenColor,
              fontSize: 12,
            ),
          )
        : Row(
            children: [
              Icon(
                FontAwesomeIcons.solidClock,
                color: primaryGreenColor,
                size: 20,
              ),
              SizedBox(width: 14),
              Text(
                "${DateFormat.jms().format(DateTime.parse(data[absen]['date']))}",
                style: interSemiBold.copyWith(
                  color: darkGreenColor,
                ),
              ),
            ],
          );
  }
}

class statusRow extends StatelessWidget {
  const statusRow({
    Key? key,
    required this.data,
    required this.absen,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final String absen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        data[absen] == null
            ? SizedBox()
            : Text(
                data[absen]['inArea'] == "Yes"
                    ? "Inside Area"
                    : data[absen]['inArea'] == "No"
                        ? "Outside Area"
                        : "",
                style: data[absen]['inArea'] == "Yes"
                    ? interMedium.copyWith(
                        color: primaryGreenColor,
                        fontSize: 12,
                      )
                    : interMedium.copyWith(
                        color: redColor,
                        fontSize: 12,
                      ),
              ),
        SizedBox(width: 8),
        data[absen] == null
            ? SizedBox()
            : data[absen]['inArea'] == "Yes"
                ? Icon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: primaryGreenColor,
                    size: 14,
                  )
                : Icon(
                    FontAwesomeIcons.circleExclamation,
                    color: redColor,
                    size: 14,
                  )
      ],
    );
  }
}

class locationRow extends StatelessWidget {
  const locationRow({
    Key? key,
    required this.data,
    required this.absen,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final String absen;

  @override
  Widget build(BuildContext context) {
    return data[absen]?['date'] == null
        ? SizedBox()
        : Row(
            children: [
              Icon(FontAwesomeIcons.locationPin,
                  color: primaryGreenColor, size: 20),
              SizedBox(
                width: 14,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: Text(
                  "${data[absen]!['lokasi']}",
                  maxLines: 2,
                  style: interLight.copyWith(
                      fontSize: 12, color: primaryGreenColor),
                ),
              ),
            ],
          );
  }
}
