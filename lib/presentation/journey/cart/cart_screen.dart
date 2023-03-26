import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/cart/cart_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';
import 'package:magento_app/presentation/widgets/refresh_widget.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          SizedBox(
            height: Get.mediaQuery.padding.top,
          ),
          Obx(
            () => Padding(
                padding: EdgeInsets.all(16.sp),
                child: Row(
                  children: [
                    AppTouchable(
                      onPressed: () => controller.onChangeSelectAllItem(),
                      child: Container(
                        margin: EdgeInsets.only(right: 12.sp),
                        height: 16.sp,
                        width: 16.sp,
                        decoration: BoxDecoration(
                            color: controller.isSelectedAll.value
                                ? AppColors.orange
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: controller.isSelectedAll.value
                                ? null
                                : Border.all(color: AppColors.grey)),
                        child: controller.isSelectedAll.value
                            ? Icon(
                                Icons.check,
                                color: AppColors.white,
                                size: 16.sp,
                              )
                            : const SizedBox(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        TransactionConstants.selectAllItems.tr,
                        style: ThemeText.bodySemibold,
                      ),
                    ),
                    AppTouchable(
                        onPressed: controller.clearAllItem,
                        child: Text(
                          TransactionConstants.clearAllItems.tr,
                          style: ThemeText.bodySemibold.orange,
                        ))
                  ],
                )),
          ),
          Expanded(
            child: RefreshWidget(
              controller: controller.cartRefreshController,
              onRefresh: controller.onRefresh,
              child:
                  //   Column(
                  // children: [

                  // Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [

                  CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  // Obx(
                  //       () =>
                  SliverList(
                    delegate: SliverChildListDelegate([
                      // controller.rxLoadedList.value == LoadedType.start
                      //     ? Container(
                      //     height:Get.height/2,
                      //     child: const AppLoadingWidget())
                      //     :
                      Column(children: [
                        // controller.items.value
                        //     .map(
                        //       (e) =>
                        _buildItem(isSelected: true
                            // controller
                            //           .selectedItems.value
                            //                    .contains(e),
                            //                            productEntity: e
                            ),
                      ])
                      // .toList(),
                      //  )
                    ]),
                    //     delegate: SliverChildBuilderDelegate(
                    //   (context, index) => _buildItem(
                    //       index: index,
                    //       isSelected: controller
                    //           .selectedItems.value
                    //           .contains(controller
                    //               .items.value[index]),
                    //       productEntity:
                    //           controller.items.value[index]),
                    //   childCount:
                    //       controller.items.value.length,
                    // )
                  ),
                  //       ),
                ],

                // SizedBox(
                //   height: AppDimens.height_24,
                // ),
                // ])
                //   ],
                // ),
              ),
            ),
          ),
        ]),
        bottomNavigationBar: Obx(
          () => Visibility(
            visible: true,
            //controller.selectedItems.value.isNotEmpty,
            child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${TransactionConstants.coupon.tr}: ',
                          style: ThemeText.bodySemibold,
                        ),
                        Expanded(
                          child: Text(
                            '${200}',
                            textAlign: TextAlign.end,
                            style: ThemeText.bodySemibold,
                          ),
                        ),
                        Text(
                          TransactionConstants.select.tr,
                          textAlign: TextAlign.end,
                          style: ThemeText.bodySemibold.grey400Color,
                        ),
                        AppTouchable(
                            onPressed: () {},
                            child: AppImageWidget(
                              asset: Assets.images.icArrowRight,
                              size: 16.sp,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    Row(
                      children: [
                        Text(
                          '${TransactionConstants.orderTotal.tr}: ',
                          style: ThemeText.bodySemibold.s18,
                        ),
                        Expanded(
                          child: Text(
                            '${200}',
                            textAlign: TextAlign.end,
                            style: ThemeText.bodySemibold.s18,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    AppButton(
                      title: TransactionConstants.checkoutButton.tr,
                      onPressed: () async {
                        // await controller.onInitDialog();
                        // showCreateNewOrderDialog(context);
                      },
                      loaded: controller.buttonState.value,
                    )
                  ],
                )),
          ),
        ));
  }

  Widget _buildItem({
    required bool isSelected,
    //   required ProductCartEntity productEntity,
    //required int index
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.sp, left: 16.sp, right: 16.sp),
      decoration: BoxDecoration(
        border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.grey200),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => controller.onChangeSelect(
                  //    productEntity
                  ),
              child: Container(
                margin: EdgeInsets.only(right: 12.sp),
                height: 16.sp,
                width: 16.sp,
                decoration: BoxDecoration(
                    color: isSelected ? AppColors.orange : AppColors.white,
                    borderRadius: BorderRadius.circular(5),
                    border:
                        isSelected ? null : Border.all(color: AppColors.grey)),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 16.sp,
                      )
                    : const SizedBox(),
              ),
            ),
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
                fit: BoxFit.cover,
                url: '',
                //productEntity.productImage!,
                color: AppColors.grey,
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
                    'Nike Air Zoom Pegasus 36 Miami Low Version',
                    //productEntity.productName ?? '',
                    style: ThemeText.bodySemibold,
                  ),
                  Text(
                    '${TransactionConstants.size.tr}',
                    //productEntity.productName ?? '',
                    style: ThemeText.bodyRegular.s12.grey500Color,
                  ),
                  Text(
                    '${TransactionConstants.color.tr}',
                    //productEntity.productName ?? '',
                    style: ThemeText.bodyRegular.s12.grey500Color,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 8.sp,
            ),
            AppTouchable(
                onPressed: () async {
                  await controller.onPressDeleteItem();
                },
                child: AppImageWidget(
                  asset: Assets.images.icTrash,
                  color: AppColors.grey,
                  size: 24.sp,
                ))
          ],
        ),
      ),
    );
  }
}
