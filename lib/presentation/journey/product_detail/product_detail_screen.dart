import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/utils/export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/product_detail/product_detail_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.errorColor,
      body: CustomScrollView(
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
                  color: AppColors.grey200,
                  shape: BoxShape.circle,
                ),
                child: AppImageWidget(
                  asset: Assets.images.icArrowLeft,
                  size: 18.sp,
                ),
              ),
            ),
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text('Goa', textScaleFactor: 1),
              background: AppImageWidget(
                backgroundColor: AppColors.white,
                asset: Assets.images.women,
                width: Get.width,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Goa',
                    style: ThemeText.bodyStrong.s24,
                  ),
                  SizedBox(
                    height: 8.sp,
                  ),
                  Text(
                    //'${currencySymbols[mainController.storeConfig.value.baseCurrencyCode ?? 'USD']}${productModel.price ?? 0}',
                    '\$1234.45',

                    style: ThemeText.bodySemibold.s18,
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                  RichText(
                    text: TextSpan(
                        text: '${TransactionConstants.availability.tr}: ',
                        style: ThemeText.bodyRegular,
                        children: [
                          TextSpan(
                            text: TransactionConstants.inStock.tr,
                            style: ThemeText.bodyRegular.orange,
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
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
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          title: TransactionConstants.buyNow.tr,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Expanded(
                          child: AppButton(
                        backgroundColor: AppColors.white,
                        title: TransactionConstants.addToCartButton.tr,
                        titleStyle: ThemeText.bodyMedium.colorBlack,
                        titleColor: AppColors.black,
                        onPressed: () {
                          debugPrint('fvdvdv');
                        },
                      ))
                    ],
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
                    child: Text(
                      'fsdfdvdfbdbvfdv',
                      style: ThemeText.bodyRegular,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
