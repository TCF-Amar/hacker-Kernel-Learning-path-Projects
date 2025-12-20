import 'package:get/get.dart';
import 'package:my_project/src/controllers/firebase_massage_controller.dart';

class FirebaseMessageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(FirebaseMessageController(), permanent: true);

  }

}