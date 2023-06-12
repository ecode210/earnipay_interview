import 'package:earnipay_interview/controller/earnipay_binding.dart';
import 'package:earnipay_interview/util/app_themes.dart';
import 'package:earnipay_interview/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init("XGallery");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) {
        return GetMaterialApp(
          title: "Earnipay Interview",
          defaultTransition: Transition.cupertino,
          debugShowCheckedModeBanner: false,
          initialBinding: EarnipayBinding(),
          home: const Home(),
          theme: AppThemes.lightTheme(context: context),
          darkTheme: AppThemes.darkTheme(context: context),
        );
      },
    );
  }
}
