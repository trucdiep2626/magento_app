import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/home/home_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class DrawerWidget extends GetView<HomeController> {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.rxLoadedList.value == LoadedType.start
        ? const SizedBox.shrink()
        : Drawer(
            width: Get.width,
            backgroundColor: AppColors.white,
            child: Stack(
              children: [
                SizedBox(
                  height: Get.height,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        color: AppColors.grey200,
                        height: Get.mediaQuery.padding.top,
                      ),
                      ListTile(
                        tileColor: AppColors.grey200,
                        title: Text(
                          TransactionConstants.mainMenu.tr,
                          style: ThemeText.bodySemibold.s18,
                        ),
                        trailing: AppTouchable(
                          onPressed: () => controller.closeDrawer(),
                          child: const Icon(
                            Icons.clear,
                            color: AppColors.black45,
                          ),
                        ),
                      ),
                      ...List.generate(controller.categories.value.length,
                          (index) {
                        return ListTile(
                          title: Text(
                            controller.categories.value[index].name ?? '',
                            style: ThemeText.bodyRegular,
                          ),
                        );
                      }),
                      SizedBox(
                        height: 60.sp,
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 60.sp,
                    color: AppColors.grey200,
                    width: Get.width,
                    child: ListTile(
                      tileColor: AppColors.grey200,
                      leading: AppImageWidget(
                        asset: Assets.images.icUser,
                      ),
                      title: Text(
                        TransactionConstants.accountTitle.tr,
                        style: ThemeText.bodySemibold,
                      ),
                      trailing: AppTouchable(
                        onPressed: () {},
                        child: Text(
                          TransactionConstants.loginTitle.tr,
                          style: ThemeText.bodySemibold.blue600Color,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ));
  }
}
