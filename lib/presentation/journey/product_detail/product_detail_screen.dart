import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/common/utils/export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/journey/product_detail/product_detail_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    final mainController = Get.find<MainController>();
    return Scaffold(
      // backgroundColor: AppColors.errorColor,
      body: Obx(() {
        final product = controller.product.value;
        final description = product.customAttributes?.firstWhereOrNull(
            (element) => element.attributeCode?.compareTo('description') == 0);
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              pinned: true,
              snap: false,
              floating: false,
              leading: AppTouchable(
                onPressed: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    shape: BoxShape.circle,
                  ),
                  child: AppImageWidget(
                    asset: Assets.images.icArrowLeft,
                    size: 18.sp,
                  ),
                ),
              ),
              expandedHeight: 250.0,
              flexibleSpace: (controller.rxLoadedList.value == LoadedType.start)
                  ? SizedBox.shrink()
                  : FlexibleSpaceBar(
                      // title: Text('Goa', textScaleFactor: 1),
                      background: AppImageWidget(
                        backgroundColor: AppColors.white,
                        url:
                            '${NetworkConfig.baseProductMediaUrl}${product.mediaGalleryEntries?.first.file ?? ''}',
                        width: Get.width,
                      ),
                    ),
            ),
            (controller.rxLoadedList.value == LoadedType.start)
                ? SliverToBoxAdapter(child: AppLoadingWidget())
                : SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name ?? '',
                            style: ThemeText.bodyStrong.s24,
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Text(
                            '${currencySymbols[mainController.storeConfig.value.baseCurrencyCode ?? 'USD']}${product.price ?? 0}',
                            style: ThemeText.bodySemibold.s18,
                          ),
                          SizedBox(
                            height: 16.sp,
                          ),
                          RichText(
                            text: TextSpan(
                                text:
                                    '${TransactionConstants.availability.tr}: ',
                                style: ThemeText.bodyRegular,
                                children: [
                                  TextSpan(
                                    text: product.extensionAttributes?.stockItem
                                                ?.isInStock ??
                                            false
                                        ? TransactionConstants.inStock.tr
                                        : TransactionConstants.outOfStock.tr,
                                    style: ThemeText.bodyRegular.orange,
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 16.sp,
                          ),
                          if (product
                                  .extensionAttributes?.stockItem?.isInStock ??
                              false)
                            Row(
                              children: [
                                Text(
                                  '${TransactionConstants.selectQuantity.tr}: ',
                                  style: ThemeText.bodyRegular,
                                ),
                                SizedBox(
                                  width: 16.sp,
                                ),
                                Expanded(
                                    child: Row(
                                  children: [
                                    Expanded(
                                      child: AppTouchable(
                                        backgroundColor: AppColors.grey200,
                                        onPressed: controller.increaseQuantity,
                                        child: Text(
                                          "+",
                                          style: ThemeText.bodyMedium.s24,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => Text(
                                          controller.quantity.value.toString(),
                                          textAlign: TextAlign.center,
                                          style: ThemeText.bodySemibold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTouchable(
                                        backgroundColor: AppColors.grey200,
                                        onPressed: controller.decreaseQuantity,
                                        child: Text(
                                          "-",
                                          style: ThemeText.bodyMedium.s24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          product.extensionAttributes?.stockItem?.isInStock ??
                                  false
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: AppButton(
                                        title: TransactionConstants.buyNow.tr,
                                        onPressed: () async {
                                        await  controller.addToCart();
                                        Get.back();
                                        mainController.onChangedNav(2);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.sp,
                                    ),
                                    Expanded(
                                        child: AppButton(
                                      backgroundColor: AppColors.white,
                                      title: TransactionConstants
                                          .addToCartButton.tr,
                                      titleStyle:
                                          ThemeText.bodyMedium.colorBlack,
                                      titleColor: AppColors.black,
                                      onPressed:  controller.addToCart,
                                    ))
                                  ],
                                )
                              : AppButton(
                                  backgroundColor: AppColors.white,
                                  title: TransactionConstants.outOfStock.tr,
                                  titleStyle: ThemeText.bodyMedium.orange,
                                  titleColor: AppColors.black,
                                  onPressed: () {
                                    // debugPrint('fvdvdv');
                                  },
                                ),
                          SizedBox(height: 16.sp),
                          Container(
                            padding: EdgeInsets.all(8.sp),
                            width: Get.width,
                            color: AppColors.grey200,
                            child: Text(
                              TransactionConstants.description.tr,
                              style: ThemeText.bodySemibold,
                            ),
                          ),
                          SizedBox(height: 16.sp),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.sp),
                              child: HtmlWidget(
                                description?.value ?? '',
                                onLoadingBuilder:
                                    (context, element, loadingProgress) =>
                                        AppLoadingWidget(),
                                onErrorBuilder: (context, element, error) =>
                                    SizedBox.shrink(),
                              )
                              // Text(
                              //   description?.value ?? '',
                              //   style: ThemeText.bodyRegular,
                              // ),
                              )
                        ],
                      ),
                    ),
                  ),
          ],
        );
      }),
    );
  }
}
