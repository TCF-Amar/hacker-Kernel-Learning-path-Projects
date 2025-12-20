import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseMessageController extends GetxController {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    initNotification();
  }

  Future<void> initNotification() async {
    try {
      NotificationSettings settings =
      await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: true,
      );
      String? token = await _messaging.getToken();

      if (settings.authorizationStatus ==
          AuthorizationStatus.authorized ||
          settings.authorizationStatus ==
              AuthorizationStatus.provisional) {

        print("FCM Token: $token");

        if (token != null) {
          await saveTokenToFirestore(token);
        }
      }
    } catch (e) {
      print("FCM Error: $e");
    }
  }

  Future<void> saveTokenToFirestore(String token) async {
    await _firestore.collection('fcm_tokens').doc(token).set({
      'token': token,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }


}
