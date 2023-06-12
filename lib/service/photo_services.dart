import 'package:dio/dio.dart';
import 'package:earnipay_interview/controller/home_controller.dart';
import 'package:earnipay_interview/model/unsplash_photo.dart';
import 'package:earnipay_interview/util/app_contants.dart';
import 'package:earnipay_interview/util/app_snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PhotoServices {
  PhotoServices({required this.dio});

  final Dio dio;

  /// Get List of Photos using the Unsplash API. The page value specifies which set of 10 photos to be fetched.
  Future<List<UnsplashPhoto>> getPhotos(BuildContext context, {required int page}) async {
    List<UnsplashPhoto> photos = [];
    await dio.get("$baseURL$page").then((value) {
      if (value.data is List && value.data.isNotEmpty) {
        for (var element in value.data) {
          photos.add(UnsplashPhoto.fromJson(element));
        }
        // Writes data to cache
        if (page == 1) GetStorage("XGallery").write("Cached Data", photos);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Get.find<HomeController>().onFirstPageLoadError.value = false;
      } else {
        if (page == 1) photos = getCachedData;
        ScaffoldMessenger.of(context).showSnackBar(AppSnackBars.internetConnectionSnackBar(context));
        Get.find<HomeController>().onFirstPageLoadError.value = true;
      }
    }).catchError((error) {
      if (page == 1) photos = getCachedData;
      ScaffoldMessenger.of(context).showSnackBar(AppSnackBars.internetConnectionSnackBar(context));
      Get.find<HomeController>().onFirstPageLoadError.value = true;
      debugPrint("List Photos: $error");
    });
    return photos;
  }

  /// Fetches cached data if available
  static List<UnsplashPhoto> get getCachedData {
    List<UnsplashPhoto> photos = [];
    if (GetStorage("XGallery").read("Cached Data") != null &&
        GetStorage("XGallery").read("Cached Data") is List &&
        GetStorage("XGallery").read("Cached Data").isNotEmpty) {
      var cachedData = GetStorage("XGallery").read("Cached Data");
      for (var element in cachedData) {
        photos.add(UnsplashPhoto.fromJson(element));
      }
    }
    return photos;
  }
}
