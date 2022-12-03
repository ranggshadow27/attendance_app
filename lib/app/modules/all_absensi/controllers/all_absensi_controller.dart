import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AllAbsensiController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime? startDate;
  DateTime endDate = DateTime.now();

  Future<QuerySnapshot<Map<String, dynamic>>> getAllPresence() async {
    String uid = auth.currentUser!.uid;

    if (startDate == null) {
      return await firestore
          .collection("pegawai")
          .doc(uid)
          .collection("presence")
          .where('date', isLessThan: endDate.toIso8601String())
          .orderBy("date", descending: true)
          .get();
    } else {
      return await firestore
          .collection("pegawai")
          .doc(uid)
          .collection("presence")
          .where('date', isGreaterThan: startDate!.toIso8601String())
          .where('date',
              isLessThan: endDate
                  .add(Duration(hours: 23, minutes: 59))
                  .toIso8601String())
          .orderBy("date", descending: true)
          .get();
    }
  }

  void datePick(DateTime startPick, DateTime endPick) {
    startDate = startPick;
    endDate = endPick;
    update();
    Get.back();
  }
}
