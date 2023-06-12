import 'package:dio/dio.dart';
import 'package:earnipay_interview/controller/home_controller.dart';
import 'package:earnipay_interview/util/app_contants.dart';
import 'package:earnipay_interview/util/app_themes.dart';
import 'package:earnipay_interview/view/home.dart';
import 'package:earnipay_interview/view/photo_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'fakes.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late Widget widgetUnderTest;

  group(
    "Services success cases",
    () {
      setUp(() {
        dio = Dio();
        dioAdapter = DioAdapter(dio: dio);
        dioAdapter.onGet(
          "${baseURL}1",
          (server) => server.reply(
            200,
            testResponseBody,
            delay: const Duration(seconds: 2),
          ),
        );
        dioAdapter.onGet(
          "${baseURL}2",
          (server) => server.reply(
            200,
            testResponseBody,
            delay: const Duration(seconds: 2),
          ),
        );
        widgetUnderTest = ScreenUtilInit(
          designSize: const Size(428, 926),
          builder: (context, child) {
            return GetMaterialApp(
              title: "Earnipay Interview",
              defaultTransition: Transition.cupertino,
              debugShowCheckedModeBanner: false,
              initialBinding: FakeEarnipayBinding(dio: dio),
              home: const Home(),
              theme: AppThemes.lightTheme(context: context),
              darkTheme: AppThemes.darkTheme(context: context),
            );
          },
        );
      });

      testWidgets(
        "Should have initial values and load photos when app starts up",
        (tester) async {
          await tester.pumpWidget(widgetUnderTest);
          final controller = Get.find<HomeController>();
          expect(controller.isFirstPageLoaded.value, false);
          expect(controller.pages, 1);
          expect(controller.photos.length, 0);
          expect(controller.selectedPhoto.value.id, "");
          expect(find.byType(Home), findsOneWidget);
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          await tester.pumpAndSettle();
          expect(controller.isFirstPageLoaded.value, true);
          expect(controller.photos.length, 10);
          expect(find.byType(CircularProgressIndicator), findsNothing);
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        "Should change theme when user clicks on brightness icon in app bar",
        (tester) async {
          await tester.pumpWidget(widgetUnderTest);
          await tester.pumpAndSettle();
          expect(find.byType(Home), findsOneWidget);
          await tester.tap(find.byIcon(Icons.brightness_6_rounded));
          await tester.pumpAndSettle();
          expect(Get.isDarkMode, true);
          await tester.tap(find.byIcon(Icons.brightness_6_rounded));
          await tester.pumpAndSettle();
          expect(Get.isDarkMode, false);
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        "Should open photo details when user clicks on photo tile",
        (tester) async {
          await tester.pumpWidget(widgetUnderTest);
          await tester.pumpAndSettle();
          expect(find.byType(Home), findsOneWidget);
          expect(find.byKey(const Key("Tile#1")), findsOneWidget);
          await tester.tap(find.byKey(const Key("Tile#1")));
          await tester.pumpAndSettle();
          expect(find.byType(PhotoDetails), findsOneWidget);
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        "Should display tooltip with alt description when user tap and hold on photo details image",
        (tester) async {
          await tester.pumpWidget(widgetUnderTest);
          await tester.pumpAndSettle();
          expect(find.byType(Home), findsOneWidget);
          await tester.tap(find.byKey(const Key("Tile#1")));
          await tester.pumpAndSettle();
          expect(find.byType(PhotoDetails), findsOneWidget);
          expect(find.byTooltip(Get.find<HomeController>().selectedPhoto.value.altDescription), findsOneWidget);
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        "Should load more photos when user scrolls to the bottom of the page",
        (tester) async {
          await tester.pumpWidget(widgetUnderTest);
          await tester.pumpAndSettle();
          expect(find.byType(Home), findsOneWidget);
          expect(Get.find<HomeController>().photos.length, 10);
          await tester.dragUntilVisible(
            find.byKey(const Key("Loading Tile")),
            find.byType(MasonryGridView),
            const Offset(0, -250),
          );
          await tester.pump();
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          expect(Get.find<HomeController>().pages, 2);
          await tester.pumpAndSettle();
          expect(Get.find<HomeController>().photos.length, 20);
          await tester.pumpAndSettle();
        },
      );
    },
  );

  group(
    "Services error cases",
    () {
      setUp(() {
        dio = Dio();
        dioAdapter = DioAdapter(dio: dio);
        dioAdapter.onGet(
          "${baseURL}1",
          (server) => server.reply(
            500,
            {},
            delay: const Duration(seconds: 2),
          ),
        );
        widgetUnderTest = ScreenUtilInit(
          designSize: const Size(428, 926),
          builder: (context, child) {
            return GetMaterialApp(
              title: "Earnipay Interview",
              defaultTransition: Transition.cupertino,
              debugShowCheckedModeBanner: false,
              initialBinding: FakeEarnipayBinding(dio: dio),
              home: const Home(),
              theme: AppThemes.lightTheme(context: context),
              darkTheme: AppThemes.darkTheme(context: context),
            );
          },
        );
      });

      testWidgets(
        "Should load no photos when app starts up for the first time",
        (tester) async {
          await tester.pumpWidget(widgetUnderTest);
          await tester.pump();
          expect(find.byType(Home), findsOneWidget);
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          expect(Get.find<HomeController>().photos.length, 0);
          await tester.pumpAndSettle();
          expect(find.byType(Home), findsOneWidget);
          expect(find.byType(CircularProgressIndicator), findsNothing);
          expect(Get.find<HomeController>().photos.length, 0);
        },
      );

      testWidgets(
        "Should display snack bar when server fails to return photos",
        (tester) async {
          await tester.pumpWidget(widgetUnderTest);
          await tester.pump();
          expect(find.byType(Home), findsOneWidget);
          expect(Get.find<HomeController>().photos.length, 0);
          await tester.pumpAndSettle();
          expect(find.byType(SnackBar), findsOneWidget);
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        "Should reload list when user clicks on the refresh button on the snack bar",
        (tester) async {
          await tester.pumpWidget(widgetUnderTest);
          await tester.pump();
          expect(find.byType(Home), findsOneWidget);
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          await tester.pumpAndSettle();
          expect(find.byType(CircularProgressIndicator), findsNothing);
          expect(find.byType(SnackBar), findsOneWidget);
          await tester.tap(find.text("Refresh"));
          await tester.pump();
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          await tester.pumpAndSettle();
        },
      );
    },
  );
}
