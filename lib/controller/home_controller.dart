import 'package:dio/dio.dart';
import 'package:earnipay_interview/model/unsplash_photo.dart';
import 'package:earnipay_interview/service/photo_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController({PhotoServices? photoServices}) {
    this.photoServices = photoServices ?? PhotoServices(dio: Dio());
  }
  late PhotoServices photoServices;

  RxBool isFirstPageLoaded = false.obs;
  RxBool onFirstPageLoadError = true.obs;
  int pages = 1;
  RxList<UnsplashPhoto> photos = <UnsplashPhoto>[].obs;
  Rx<UnsplashPhoto> selectedPhoto = UnsplashPhoto().obs;
  final tooltipKey = GlobalKey<TooltipState>();

  @override
  void onInit() {
    fetchPhotos(Get.context!, page: 1);
    super.onInit();
  }

  /// Change current theme mode of the app. NOTE: Default theme mode is system's default theme mode on app startup.
  void changeTheme() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
    }
  }

  /// Fetch List of Photos
  Future<void> fetchPhotos(BuildContext context, {required int page}) async {
    if (page == 1) {
      isFirstPageLoaded.value = false;
      photos.clear();
    }
    photos.addAll(await photoServices.getPhotos(context, page: page));
    isFirstPageLoaded.value = true;
  }
}
