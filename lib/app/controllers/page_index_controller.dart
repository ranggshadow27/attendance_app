import 'package:attendance_app/app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

import '../routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> changePage(int i) async {
    switch (i) {
      case 1:
        print("Absensi");
        Map<String, dynamic> dataResponse = await determinePosition();
        if (dataResponse["error"] != true) {
          Position position = dataResponse["position"];

          List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );
          print(placemarks[0]);

          String userAddress =
              "${placemarks[0].street} , ${placemarks[0].subLocality} , ${placemarks[0].locality}";
          await updatePosition(position, userAddress);

          //CEK JARAK
          double distance = Geolocator.distanceBetween(
              -6.3544882, 107.1438753, position.latitude, position.longitude);

          await absensi(position, userAddress, distance);

          // Get.snackbar("Berhasil", "Mankyus lokasimu ada di ${userAddress}");
        } else {
          Get.snackbar("Error", dataResponse["message"]);
        }
        break;
      case 2:
        pageIndex.value = i;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        pageIndex.value = i;
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> absensi(Position pos, String address, double distance) async {
    String uid = await auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> collectionPresence =
        await firestore.collection("pegawai").doc(uid).collection("presence");

    QuerySnapshot<Map<String, dynamic>> snapshotPresence =
        await collectionPresence.get();

    DateTime now = DateTime.now();
    String todayDateId = DateFormat.yMd().format(now).replaceAll("/", "-");

    String statusArea = "No";

    if (distance <= 100) {
      // didalam area
      statusArea = "Yes";
    }

    if (snapshotPresence.docs.length == 0) {
      await Get.defaultDialog(
        radius: 12,
        backgroundColor: greyColor,
        titlePadding: EdgeInsets.only(top: 20),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        titleStyle: interSemiBold.copyWith(color: darkGreenColor),
        middleTextStyle: interMedium.copyWith(
          color: darkGreenColor,
          fontSize: 14,
        ),
        title: "Verifikasi Absen",
        middleText: "Yakin mau Absen masuk ni jon?",
        actions: [
          OutlinedButton(
            onPressed: () {
              Get.back();
              Get.back();

              // changePage(2);
              // isLoading.value = true;
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: lightBorderColor),
              ),
            ),
            child: Text(
              "Back",
              style: interSemiBold.copyWith(
                color: primaryGreenColor,
                fontSize: 12,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              collectionPresence.doc(todayDateId).set(
                {
                  "date": now.toIso8601String(),
                  "masuk": {
                    "date": now.toIso8601String(),
                    "latitude": pos.latitude,
                    "longitude": pos.longitude,
                    "lokasi": address,
                    "jarak": "${distance} Meter",
                    "inArea": statusArea,
                  }
                },
              );
              Get.back();

              changePage(0);
              isLoading.value = false;

              Get.snackbar("Berhasil", "Sukses absen masuk jon");
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: primaryGreenColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Yes",
              style: interSemiBold.copyWith(
                color: greyColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      );
    } else {
      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await collectionPresence.doc(todayDateId).get();
      if (todayDoc.exists == true) {
        //
        Map<String, dynamic>? dataPresenceToday = todayDoc.data();
        if (dataPresenceToday?["pulang"] != null) {
          changePage(0);
          isLoading.value = false;

          Get.snackbar(
              "Error", "Udah absen masuk dan Pulang jon, besok lagi absennya");
        } else {
          await Get.defaultDialog(
            radius: 12,
            backgroundColor: greyColor,
            titlePadding: EdgeInsets.only(top: 20),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            titleStyle: interSemiBold.copyWith(color: darkGreenColor),
            middleTextStyle: interMedium.copyWith(
              color: darkGreenColor,
              fontSize: 14,
            ),
            title: "Verifikasi Absen",
            middleText: "Yakin mau Absen pulang ni jon?",
            actions: [
              OutlinedButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: lightBorderColor),
                  ),
                ),
                child: Text(
                  "Back",
                  style: interSemiBold.copyWith(
                    color: primaryGreenColor,
                    fontSize: 12,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  collectionPresence.doc(todayDateId).update(
                    {
                      "pulang": {
                        "date": now.toIso8601String(),
                        "latitude": pos.latitude,
                        "longitude": pos.longitude,
                        "lokasi": address,
                        "inArea": statusArea,
                        "jarak": "${distance} Meter",
                      }
                    },
                  );
                  Get.back();

                  changePage(0);
                  isLoading.value = false;

                  Get.snackbar("Berhasil", "Sukses absen pulang jon");
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: primaryGreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Yes",
                  style: interSemiBold.copyWith(
                    color: greyColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          );
        }
      } else {
        //
        await Get.defaultDialog(
          radius: 12,
          backgroundColor: greyColor,
          titlePadding: EdgeInsets.only(top: 20),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          titleStyle: interSemiBold.copyWith(color: darkGreenColor),
          middleTextStyle: interMedium.copyWith(
            color: darkGreenColor,
            fontSize: 14,
          ),
          title: "Verifikasi Absen",
          middleText: "Yakin mau Absen masuk ni jon?",
          actions: [
            OutlinedButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: lightBorderColor),
                ),
              ),
              child: Text(
                "Back",
                style: interSemiBold.copyWith(
                  color: primaryGreenColor,
                  fontSize: 12,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                collectionPresence.doc(todayDateId).set(
                  {
                    "date": now.toIso8601String(),
                    "masuk": {
                      "date": now.toIso8601String(),
                      "latitude": pos.latitude,
                      "longitude": pos.longitude,
                      "lokasi": address,
                      "inArea": statusArea,
                      "jarak": "${distance} Meter",
                    }
                  },
                );
                Get.back();

                changePage(0);
                isLoading.value = false;

                Get.snackbar("Berhasil", "Sukses absen masuk jon");
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: primaryGreenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Yes",
                style: interSemiBold.copyWith(
                  color: greyColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        );
      }
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = await auth.currentUser!.uid;

    firestore.collection("pegawai").doc(uid).update(
      {
        "position": {
          "latitude": position.latitude,
          "longitude": position.longitude,
        },
        "alamat": address,
      },
    );
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return {
        'error': true,
        'message':
            'jon, ini servis lokasi hape nya gaidup, gagal absen jadinya',
      };
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return {
          'error': true,
          'message': 'yaah jangan di tolak dong izin lokasinya joonnnn',
        };
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return {
        'error': true,
        'message': 'Ups gabisa dapet izin lokasi ni jon',
      };
      // Permissions are denied forever, handle appropriately.
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return {
      'position': position,
      'message': 'Sukses Dapet lokasimu jon',
      'error': false,
    };
  }
}
