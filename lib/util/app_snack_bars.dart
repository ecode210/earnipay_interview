import 'package:earnipay_interview/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppSnackBars {
  /// Displays a Snack Bar informing users about an internet connection error. Users can refresh the page by clicking the Refresh button on the Snack Bar.
  static SnackBar internetConnectionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return SnackBar(
      content: Text(
        "Something went wrong. Please try again.",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: EdgeInsets.all(20.w),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      duration: const Duration(hours: 24),
      action: SnackBarAction(
        backgroundColor: Theme.of(context).colorScheme.onError.withOpacity(0.5),
        textColor: Theme.of(context).colorScheme.onErrorContainer,
        label: "Refresh",
        onPressed: () {
          Get.find<HomeController>().fetchPhotos(context, page: 1);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }
}
