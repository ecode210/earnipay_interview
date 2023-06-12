import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_interview/controller/home_controller.dart';
import 'package:earnipay_interview/util/app_contants.dart';
import 'package:earnipay_interview/util/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PhotoDetails extends GetWidget<HomeController> {
  const PhotoDetails({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: Text(
          "Photo Detail",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).colorScheme.onBackground,
            size: 20.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: 926.h,
          width: 428.w,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Hero(
                tag: "${controller.selectedPhoto.value.id}$index",
                child: Tooltip(
                  key: controller.tooltipKey,
                  message: controller.selectedPhoto.value.altDescription,
                  triggerMode: TooltipTriggerMode.manual,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: (_) {
                      controller.tooltipKey.currentState?.ensureTooltipVisible();
                    },
                    onTapUp: (_) {
                      controller.tooltipKey.currentState?.deactivate();
                    },
                    onTapCancel: () {
                      controller.tooltipKey.currentState?.deactivate();
                    },
                    child: CachedNetworkImage(
                      imageUrl: controller.selectedPhoto.value.urls.small,
                      fit: BoxFit.fitWidth,
                      fadeInDuration: const Duration(milliseconds: 200),
                      fadeOutDuration: const Duration(milliseconds: 200),
                      fadeInCurve: Curves.easeInOut,
                      fadeOutCurve: Curves.easeInOut,
                      alignment: Alignment.center,
                      placeholder: (context, url) {
                        return AspectRatio(
                          aspectRatio: controller.selectedPhoto.value.width / controller.selectedPhoto.value.height,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondaryContainer,
                            ),
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 50.h,
                              width: 50.w,
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
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              20.verticalSpace,
              Container(
                width: 428.w,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    Text(
                      controller.selectedPhoto.value.description.isNotEmpty
                          ? "${controller.selectedPhoto.value.description}."
                          : controller.selectedPhoto.value.altDescription.capitalizeFirstWord,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
              Container(
                width: 428.w,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: CachedNetworkImage(
                            imageUrl: controller.selectedPhoto.value.user.profileImage.large,
                            height: 60.h,
                            width: 60.h,
                            fit: BoxFit.cover,
                            fadeInDuration: const Duration(milliseconds: 200),
                            fadeOutDuration: const Duration(milliseconds: 200),
                            fadeInCurve: Curves.easeInOut,
                            fadeOutCurve: Curves.easeInOut,
                            alignment: Alignment.center,
                            placeholder: (context, url) {
                              return Container(
                                height: 60.h,
                                width: 60.h,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              debugPrint("Photo Details: $error");
                              return Container(
                                height: 60.h,
                                width: 60.h,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  shape: BoxShape.circle,
                                ),
                              );
                            },
                          ),
                        ),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (controller.selectedPhoto.value.user.name.isNotEmpty)
                              Text(
                                controller.selectedPhoto.value.user.name,
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                              ),
                            if (controller.selectedPhoto.value.user.username.isNotEmpty)
                              Text(
                                "@${controller.selectedPhoto.value.user.username}",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                      fontWeight: FontWeight.w700,
                                      height: 1,
                                    ),
                              ),
                            if (controller.selectedPhoto.value.user.location.isNotEmpty)
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: Theme.of(context).colorScheme.primary,
                                    size: 13.sp,
                                  ),
                                  Text(
                                    controller.selectedPhoto.value.user.location,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                  ),
                                ],
                              ),
                          ],
                        )
                      ],
                    ),
                    if (controller.selectedPhoto.value.user.bio.isNotEmpty) 5.verticalSpace,
                    if (controller.selectedPhoto.value.user.bio.isNotEmpty)
                      Text(
                        controller.selectedPhoto.value.user.bio,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                  ],
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
