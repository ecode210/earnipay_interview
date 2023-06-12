import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_interview/controller/home_controller.dart';
import 'package:earnipay_interview/util/app_contants.dart';
import 'package:earnipay_interview/view/photo_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class Home extends GetWidget<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "XGallery",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.changeTheme();
            },
            padding: EdgeInsets.only(right: 20.w),
            icon: Icon(
              Icons.brightness_6_rounded,
              color: Theme.of(context).colorScheme.onBackground,
              size: 25.sp,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchPhotos(context, page: 1);
          },
          child: SizedBox(
            height: 926.h,
            width: 428.w,
            child: Obx(() {
              if (controller.isFirstPageLoaded.value) {
                return NotificationListener<ScrollEndNotification>(
                  onNotification: (scrollEndNotification) {
                    final metrics = scrollEndNotification.metrics;
                    if (metrics.atEdge && metrics.pixels != 0) {
                      controller.pages++;
                      controller.fetchPhotos(context, page: controller.pages);
                    }
                    return true;
                  },
                  child: AnimationLimiter(
                    child: MasonryGridView.count(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.all(10.w),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.w,
                      crossAxisSpacing: 10.w,
                      itemCount: controller.photos.length + (controller.onFirstPageLoadError.value ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index == controller.photos.length) {
                          return AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              key: const Key("Loading Tile"),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                    width: 30.w,
                                    child: CircularProgressIndicator.adaptive(
                                      strokeWidth: 5.w,
                                    ),
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    "Loading more\nphotos...",
                                    textAlign: TextAlign.center,
                                    style: Get.textTheme.headlineSmall!.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.h,
                            child: FadeInAnimation(
                              child: TextButton(
                                key: Key("Tile#${index + 1}"),
                                onPressed: () {
                                  controller.selectedPhoto.value = controller.photos[index];
                                  Get.to(() => PhotoDetails(index: index));
                                },
                                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: AspectRatio(
                                    aspectRatio: controller.photos[index].width / controller.photos[index].height,
                                    child: Hero(
                                      tag: "${controller.photos[index].id}$index",
                                      child: CachedNetworkImage(
                                        imageUrl: controller.photos[index].urls.small,
                                        fit: BoxFit.cover,
                                        fadeInDuration: const Duration(milliseconds: 200),
                                        fadeOutDuration: const Duration(milliseconds: 200),
                                        fadeInCurve: Curves.easeInOut,
                                        fadeOutCurve: Curves.easeInOut,
                                        alignment: Alignment.center,
                                        placeholder: (context, url) {
                                          return AspectRatio(
                                            aspectRatio:
                                                controller.photos[index].width / controller.photos[index].height,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.secondaryContainer,
                                                borderRadius: BorderRadius.circular(20.r),
                                              ),
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 30.h,
                                                width: 30.w,
                                                child: !isTest
                                                    ? CircularProgressIndicator.adaptive(
                                                        strokeWidth: 5.w,
                                                      )
                                                    : 0.verticalSpace,
                                              ),
                                            ),
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          debugPrint("Unsplash Photo: $error");
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.secondary,
                                              borderRadius: BorderRadius.circular(20.r),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    strokeWidth: 5.w,
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
