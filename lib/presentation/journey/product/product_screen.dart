import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/journey/product/product_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';
import 'package:magento_app/presentation/widgets/refresh_widget.dart';

class ProductScreen extends GetView<ProductController> {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: controller.shouldRefresh.value);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchField(),
              SizedBox(height: 8.sp),
              _buildSortWidget(),
              SizedBox(height: 16.sp),
              Expanded(
                child: Obx(
                  () => RefreshWidget(
                    enableLoadMore: controller.canLoadMore.value,
                    onLoadMore: () async {
                      double oldPosition =
                          controller.scrollController.position.pixels;
                      await controller.getProductList();
                      controller.scrollController.position.jumpTo(oldPosition);
                    },
                    controller: controller.productRefreshController,
                    onRefresh: controller.onRefresh,
                    child: controller.rxLoadedList.value == LoadedType.start
                        ? const Center(
                            child: AppLoadingWidget(),
                          )
                        : CustomScrollView(
                            controller: controller.scrollController,
                            shrinkWrap: true,
                            slivers: [
                              SliverGrid(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // mainAxisSpacing: 10,
                                  // crossAxisSpacing: 10,
                                  childAspectRatio:
                                      (Get.width / 3) / (Get.width / 2),
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return Card(
                                      // generate blues with random shades
                                      //    color: Colors.amber[Random().nextInt(9) * 100],
                                      child: _buildProductItem(
                                          controller.products[index]),
                                    );
                                  },
                                  childCount: controller.products.length,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchField() {
    return Container(
      margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      width: Get.width,
      child: Row(
        children: [
          AppTouchable(
            onPressed: () => Get.back(),
            child: AppImageWidget(
              asset: Assets.images.icArrowLeft,
              size: 18.sp,
            ),
          ),
          SizedBox(
            width: 8.sp,
          ),
          Expanded(
            child: AppTextField(
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 16.sp, right: 10.5.sp),
                child: SizedBox(
                  width: 14.sp,
                  height: 14.sp,
                  child: AppImageWidget(
                    asset: Assets.images.icSearch,
                  ),
                ),
              ),
              hintText: TransactionConstants.searchPlaceholderText.tr,
              controller: controller.searchController,
              textInputAction: TextInputAction.search,
              onEditingComplete: () => controller.onRefresh(),
              focusNode: controller.searchFocusNode,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSortWidget() {
    return Obx(() => Row(
          children: [
            Expanded(
              child: _builsItemFilter(
                onPressed: () async => await controller.onChangeSortByName(),
                title: TransactionConstants.sortByName.tr,
                icon: _getArrow(controller.sortByName.value),
              ),
            ),
            Expanded(
              child: _builsItemFilter(
                onPressed: () async => await controller.onChangeSortByPrice(),
                title: TransactionConstants.sortByPrice.tr,
                icon: _getArrow(controller.sortByPrice.value),
              ),
            ),
            Expanded(
              child: _builsItemFilter(
                onPressed: controller.openDrawer,
                title: TransactionConstants.filter.tr,
                icon: AppImageWidget(
                  asset: Assets.images.icFilter,
                  size: 14.sp,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildProductItem(ProductModel productModel) {
    final mainController = Get.find<MainController>();
    return Container(
      color: AppColors.white,
      //   margin: EdgeInsets.symmetric(horizontal: 16.sp),
      width: Get.width / 2,
      // height: Get.width / 2,
      padding: EdgeInsets.all(16.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImageWidget(
            url:
                '${NetworkConfig.baseProductMediaUrl}${productModel.mediaGalleryEntries?.first.file ?? ''}',
            size: Get.width / 4,
          ),
          SizedBox(height: 16.sp),
          Text(
            productModel.name ?? '',
            style: ThemeText.bodyRegular,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Obx(
            () => Text(
                '${currencySymbols[mainController.storeConfig.value.baseCurrencyCode ?? 'USD']}${productModel.price ?? 0}',
                style: ThemeText.bodySemibold.s16),
          ),
          const Spacer(),
          _buildAddToCartButton(),
        ],
      ),
    );
  }



  Widget _buildAddToCartButton() {
    return AppTouchable(
      width: double.infinity,
      onPressed: () {},
      padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
      backgroundColor: AppColors.black,
      child: Text(
        TransactionConstants.addToCartButton.tr,
        style: ThemeText.bodySemibold.colorWhite.s10,
      ),
    );
  }

  Widget _builsItemFilter({
    Function()? onPressed,
    required String title,
    required Widget icon,
  }) {
    return AppTouchable(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: ThemeText.bodySemibold,
          ),
          SizedBox(
            width: 4.sp,
          ),
          icon,
        ],
      ),
    );
  }

  Widget _getArrow(SortType sortType) {
    switch (sortType) {
      case SortType.none:
        return const SizedBox.shrink();
      case SortType.asc:
        return AppImageWidget(
          asset: Assets.images.icAsc,
          size: 14.sp,
        );
      case SortType.desc:
        return AppImageWidget(
          asset: Assets.images.icDesc,
          size: 14.sp,
        );
    }
  }
}