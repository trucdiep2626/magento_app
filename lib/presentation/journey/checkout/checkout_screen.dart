import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/cart_information_model.dart';
import 'package:magento_app/domain/models/customer_model.dart';
import 'package:magento_app/domain/models/estimate_shipping_methods_model.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/checkout/checkout_controller.dart';
import 'package:magento_app/presentation/journey/estimate_shipping/estimate_shipping_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: true,
        title: TransactionConstants.checkoutButton.tr,
        onPressed: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: SingleChildScrollView(child: Obx(() {
          // if (controller.rxLoadedList.value == LoadedType.start) {
          //   return SizedBox(
          //     height: Get.height / 2,
          //     child: AppLoadingWidget(),
          //   );
          // }

          //    final methods = controller.methods.value;

          return
              // methods.isEmpty
              //   ? Center(
              //   child: Padding(
              //     padding: EdgeInsets.only(top: 24.sp),
              //     child: Text(
              //       TransactionConstants.noShippingMethod.tr,
              //       style: ThemeText.bodyMedium.grey500Color.s20,
              //     ),
              //   ))
              //   :
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildTitle(TransactionConstants.shippingMethod.tr),
            _buildAddressItem(
                addresses: controller.shippingController.address!),
            _buildTitle(TransactionConstants.orderDetails.tr),
            ...List.generate(
                controller.cartController.items.length,
                (index) => _buildCartItem(
                    productEntity: controller.cartController.items[index])),
            Row(
              children: [
                Expanded(
                    child: Text(
                  TransactionConstants.subTotal.tr,
                  style: ThemeText.bodyRegular,
                )),
                Text(
                  '${controller.paymentController.shippingInfor?.totals?.subtotal ?? 0}',
                  style: ThemeText.bodyRegular,
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  TransactionConstants.subTotal.tr,
                  style: ThemeText.bodyRegular,
                )),
                Text(
                  '${controller.paymentController?.shippingInfor?.totals?.subtotal ?? 0}',
                  style: ThemeText.bodyRegular,
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  TransactionConstants.total.tr,
                  style: ThemeText.bodyRegular,
                )),
                Text(
                  '${controller.paymentController.shippingInfor?.totals?.subtotalWithDiscount ?? 0}',
                  style: ThemeText.bodyRegular,
                )
              ],
            ),
          ]);
        })),
      ),
      bottomNavigationBar: Obx(() => Padding(
            padding: EdgeInsets.all(16.sp),
            child: AppButton(
              title: TransactionConstants.checkoutButton.tr,
              loaded: controller.rxLoadedButton.value,
              //   onPressed: () async => await controller.saveInfo(),
            ),
          )),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: ThemeText.bodySemibold.s18,
    );
  }

  Widget _buildAddressItem({required Addresses addresses}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8.sp),
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${addresses.firstname ?? ''} ${addresses.lastname ?? ''}',
                style: ThemeText.bodySemibold,
              ),
              Text(
                addresses.telephone ?? '',
                style: ThemeText.bodyRegular,
              ),
              Text(
                addresses.city ?? '',
                style: ThemeText.bodyRegular,
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required CartItem productEntity,
    //required int index
  }) {
    return AppTouchable(
      onPressed: () {
        Get.toNamed(AppRoutes.productDetail, arguments: productEntity.sku);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.sp, left: 16.sp, right: 16.sp),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey200),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 72.sp,
                width: 72.sp,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child:
                    // productEntity.productImage == null
                    //     ? const SizedBox()
                    //     :
                    AppImageWidget(
                  //   fit: BoxFit.cover,
                  url:
                      '${NetworkConfig.baseProductMediaUrl}${productEntity.productOption?.extensionAttributes?.customOptions?.first.optionValue ?? ''}',
                  //  color: AppColors.grey,
                  height: 72.sp,
                  width: 72.sp,
                ),
              ),
              SizedBox(
                width: 12.sp,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //  'Nike Air Zoom Pegasus 36 Miami Low Version',
                      productEntity.name ?? '',
                      style: ThemeText.bodySemibold,
                    ),
                    SizedBox(
                      height: 2.sp,
                    ),
                    Text(
                      '${currencySymbols[controller.mainController.storeConfig.value.baseCurrencyCode ?? 'USD']}${(productEntity.price ?? 0) * (productEntity.qty ?? 1)}',
                      style: ThemeText.bodyRegular.s12,
                    ),
                    Text(
                      '${TransactionConstants.quantity.tr}: ${productEntity.qty ?? 1}',
                      //productEntity.productName ?? '',
                      style: ThemeText.bodyRegular.s12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
