import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/estimate_shipping_methods_model.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/estimate_shipping/estimate_shipping_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class EstimateShippingScreen extends GetView<EstimateShippingController> {
  const EstimateShippingScreen({Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: true,
        title: TransactionConstants.shippingMethod.tr,
        onPressed: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: SingleChildScrollView(child: Obx(() {
          final methods = controller.methods.value;

          return methods.isEmpty
              ? Center(
              child: Padding(
                padding: EdgeInsets.only(top: 24.sp),
                child: Text(
                  TransactionConstants.noData.tr,
                  style: ThemeText.bodyMedium.grey500Color.s20,
                ),
              ))
              : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: methods
                  .map((e) => _buildItem(method: e))
                  .toList());
        })),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.sp),
        child: AppButton(
          title: TransactionConstants.continueButton.tr,
          onPressed: () => Get.toNamed(AppRoutes.createAddress),
        ),
      ),
    );
  }

  Widget _buildItem({required EstimateShippingMethodsModel method}) {
    return GestureDetector(
      onTap: () => controller.updateSelectedMethod(method),
      child: Container(
        color: Colors.transparent,
        margin:  EdgeInsets.symmetric(vertical: 8.sp),
        child: Row(
          children: [
            AppImageWidget(
              asset: controller.selectedMethod.value == method
                  ? Assets.images.icCircleChecked
                  : Assets.images.icCircleUnchecked,
              size: 20.sp,
            ),
            SizedBox(width: 16.sp),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method.carrierTitle ?? '',
                  style: ThemeText.bodySemibold,
                ),
                SizedBox(height: 2.sp),
                Text(
                  '${currencySymbols[controller.mainController.storeConfig.value.baseCurrencyCode ?? 'USD']}${method.amount ?? 0}',
                  style: ThemeText.bodyRegular.grey600Color,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
