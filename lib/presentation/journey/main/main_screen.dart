import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/account/account_screen.dart';
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
    return Expanded(
      child: AppTouchable(
          onPressed: onPressed,
          outlinedBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
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
          )),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Obx(
        () => Row(
          children: [
            _buildBottomNavigationItemWidget(context,
                title: titles[0],
                asset: icons[0],
                isSelected: controller.rxCurrentNavIndex.value == 0,
                onPressed: () => controller.onChangedNav(0)),
            _buildBottomNavigationItemWidget(context,
                title: titles[1],
                asset: icons[1],
                isSelected: controller.rxCurrentNavIndex.value == 1,
                onPressed: () => controller.onChangedNav(1)),
            _buildBottomNavigationItemWidget(context,
                title: titles[2],
                asset: icons[2],
                isSelected: controller.rxCurrentNavIndex.value == 2,
                onPressed: () => controller.onChangedNav(2)),
            _buildBottomNavigationItemWidget(context,
                title: titles[3],
                asset: icons[3],
                isSelected: controller.rxCurrentNavIndex.value == 3,
                onPressed: () => controller.onChangedNav(3)),
            _buildBottomNavigationItemWidget(context,
                title: titles[4],
                asset: icons[4],
                isSelected: controller.rxCurrentNavIndex.value == 4,
                onPressed: () => controller.onChangedNav(4)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(),
      CategoryScreen(),
      Center(
        child: Text(StringConstants.workflow.tr),
      ),
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
