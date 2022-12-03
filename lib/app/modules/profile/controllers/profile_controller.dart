import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore.collection("pegawai").doc(uid).snapshots();
  }

  void logout() async {
    await auth.signOut();
    Get.offNamed(Routes.LOGIN);
  }
}
