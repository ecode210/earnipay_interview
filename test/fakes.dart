import 'package:dio/dio.dart';
import 'package:earnipay_interview/controller/home_controller.dart';
import 'package:earnipay_interview/service/photo_services.dart';
import 'package:get/get.dart';

class FakeEarnipayBinding extends Bindings {
  FakeEarnipayBinding({required this.dio});

  final Dio dio;

  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(photoServices: PhotoServices(dio: dio)), fenix: true);
  }
}
