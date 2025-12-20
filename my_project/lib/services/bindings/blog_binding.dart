import 'package:get/get.dart';
import 'package:my_project/src/controllers/blog_controller.dart';

class BlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BlogController(),permanent: true);
  }
}
