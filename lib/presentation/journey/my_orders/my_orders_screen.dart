import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/journey/my_orders/my_orders_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';

class MyOrdersScreen extends GetView<MyOrdersController> {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    //final mainController = Get.find<MainController>();
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: true,
        title: TransactionConstants.myOrders.tr,
        onPressed: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: SingleChildScrollView(
          child:
          //Obx(
            //() {
              //    final addresses = mainController.rxCustomer.value?.addresses ?? [];

            //  return
            Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 24.sp),
                  child: Text(
                    TransactionConstants.noData.tr,
                    style: ThemeText.bodyMedium.grey500Color.s20,
                  ),
                ),
              )
            //;
           // },
       //   ),
        ),
      ),
    );
  }
}
