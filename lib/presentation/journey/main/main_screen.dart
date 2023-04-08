import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/account/account_screen.dart';
import 'package:magento_app/presentation/journey/cart/cart_controller.dart';
import 'package:magento_app/presentation/journey/cart/cart_screen.dart';
import 'package:magento_app/presentation/journey/category/category_screen.dart';
import 'package:magento_app/presentation/journey/home/home_page.dart';
import 'package:magento_app/presentation/journey/product/product_screen.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

import 'main_controller.dart';

class MainScreen extends GetView<MainController> {
  MainScreen({Key? key}) : super(key: key);

  final List<String> titles = [
    TransactionConstants.mainNavigationHome.tr,
    TransactionConstants.mainNavigationCategory.tr,
    TransactionConstants.mainNavigationCart.tr,
    TransactionConstants.mainNavigationMalls.tr,
    TransactionConstants.mainNavigationAccount.tr,
  ];

  final List<SvgGenImage> icons = [
    Assets.images.icHome,
    Assets.images.icCategory,
    Assets.images.icShoppingCart,
    Assets.images.icShop,
    Assets.images.icUser,
  ];

  Widget _buildBottomNavigationItemWidget(
    BuildContext context, {
    Function()? onPressed,
    SvgGenImage? asset,
    String? title,
    bool isSelected = false,
  }) {
    return AppTouchable(
        onPressed: onPressed,
        outlinedBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        width: double.infinity,
        padding: EdgeInsets.only(
          top: AppDimens.space_12,
          bottom: MediaQuery.of(context).padding.bottom + 12.sp,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImageWidget(
              asset: asset!,
              height: AppDimens.space_20,
              color: isSelected ? AppColors.primary : AppColors.grey,
            ),
            SizedBox(
              height: AppDimens.height_8,
            ),
            Text(
              title!,
              style: ThemeText.bodyMedium.copyWith(
                color: isSelected ? AppColors.primary : AppColors.grey,
              ),
            )
          ],
        ));
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Obx(
        () {
          return Row(
            children: [
              Expanded(
                child: _buildBottomNavigationItemWidget(context,
                    title: titles[0],
                    asset: icons[0],
                    isSelected: controller.rxCurrentNavIndex.value == 0,
                    onPressed: () => controller.onChangedNav(0)),
              ),
              Expanded(
                child: _buildBottomNavigationItemWidget(context,
                    title: titles[1],
                    asset: icons[1],
                    isSelected: controller.rxCurrentNavIndex.value == 1,
                    onPressed: () => controller.onChangedNav(1)),
              ),
              Expanded(
                child: Stack(
                  children: [
                    _buildBottomNavigationItemWidget(context,
                        title: titles[2],
                        asset: icons[2],
                        isSelected: controller.rxCurrentNavIndex.value == 2,
                        onPressed: () => controller.onChangedNav(2)),
                    Positioned(
                      top: 4.sp,
                      right: 12.sp,
                      child: Obx(
                        () => Visibility(
                          visible: controller.totalItem.value != 0,
                          child: Container(
                            width: 22.sp,
                            height: 22.sp,
                            padding: EdgeInsets.all(2.sp),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.red,
                                border: Border.all(
                                    color: AppColors.white, width: 1.5.sp)),
                            child: Center(
                                child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                '${controller.totalItem.value}',
                                style: ThemeText.bodySemibold.colorWhite,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildBottomNavigationItemWidget(context,
                    title: titles[3],
                    asset: icons[3],
                    isSelected: controller.rxCurrentNavIndex.value == 3,
                    onPressed: () => controller.onChangedNav(3)),
              ),
              Expanded(
                child: _buildBottomNavigationItemWidget(context,
                    title: titles[4],
                    asset: icons[4],
                    isSelected: controller.rxCurrentNavIndex.value == 4,
                    onPressed: () => controller.onChangedNav(4)),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(),
      CategoryScreen(),
      CartScreen(),
      ProductScreen(),
      AccountScreen()
    ];

    return Scaffold(
      backgroundColor: AppColors.grey100,
      body: Obx(() => pages[controller.rxCurrentNavIndex.value]),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}
