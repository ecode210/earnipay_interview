import 'package:earnipay_interview/controller/home_controller.dart';
import 'package:get/get.dart';

class EarnipayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}
