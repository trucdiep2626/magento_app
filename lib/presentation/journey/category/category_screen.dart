import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/common/utils/translations/app_translations.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/category/category_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class CategoryScreen extends GetView<CategoryController> {
  CategoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarWidget(
        title: TransactionConstants.mainNavigationCategory.tr,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: controller.rxLoadedLeftList == LoadedType.start
                ? AppLoadingWidget()
                : ListView.builder(
                    itemBuilder: (context, index) => AppTouchable(
                      onPressed: () async =>
                          await controller.onSelectCategory(index),
                      child: _buildCategoryWidget(
                          category: controller.categories.value[index],
                          image: controller.categoryImages[index],
                          isSelected: index == controller.selectedIndex.value),
                    ),
                    shrinkWrap: true,
                    itemCount: controller.categories.value.length,
                  ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: controller.rxLoadedRightList == LoadedType.start
                    ? AppLoadingWidget()
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  TransactionConstants.viewAll.tr,
                                  style: ThemeText.bodySemibold.s16,
                                )),
                                AppImageWidget(
                                  asset: Assets.images.icArrowRight,
                                  size: 18.sp,
                                  color: AppColors.black,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            Wrap(
                              children: controller.productsOfCategory.value
                                  .map((e) => _buildItem(
                                      title: e.name,
                                      image: e.mediaGalleryEntries?.first.file))
                                  .toList(),
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            Text(
                              TransactionConstants.subCategories.tr,
                              style: ThemeText.bodySemibold.s16,
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            Wrap(
                              children: controller.subCategories.value
                                  .map((e) => AppTouchable(
                                        onPressed: () {},
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4.sp),
                                          child: Row(
                                            children: [
                                              AppImageWidget(
                                                asset: Assets.images.icCircle,
                                                size: 10.sp,
                                              ),
                                              SizedBox(
                                                width: 8.sp,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                e.name ?? '',
                                                style: ThemeText.bodyRegular,
                                              )),
                                              AppImageWidget(
                                                asset:
                                                    Assets.images.icArrowRight,
                                                size: 12.sp,
                                                color: AppColors.black,
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
              ))
        ],
      ),
    );
  }

  Widget _buildItem({String? title, String? image}) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 8.sp, 8.sp, 8.sp),
      width: Get.width / 5,
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImageWidget(
            border: Border.all(color: AppColors.grey200),
            borderRadius: BorderRadius.circular(10),
            url: '${NetworkConfig.baseMediaUrl}$image',
            //  fit: ,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            title ?? '',
            style: ThemeText.bodyRegular,
          )
        ],
      ),
    );
  }

  Widget _buildCategoryWidget(
      {required CategoryTreeModel category,
      required String image,
      bool isSelected = false}) {
    return Container(
      color: isSelected ? AppColors.white : AppColors.grey100,
      padding: EdgeInsets.all(16.sp),
      child: Column(
        children: [
          AppImageWidget(
            url: '${NetworkConfig.baseMediaUrl}$image',
            //  fit: ,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            category.name ?? '',
            style: ThemeText.bodyRegular,
          )
        ],
      ),
    );
  }
}
