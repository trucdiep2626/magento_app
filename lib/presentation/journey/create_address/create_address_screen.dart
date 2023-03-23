import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/create_address/create_address_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class CreateNewAddressScreen extends GetView<CreateNewAddressController> {
  const CreateNewAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
        appBar: AppBarWidget(
          showBackButton: true,
          title: TransactionConstants.addAccountAddress.tr,
          onPressed: () => Get.back(),
        ),
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(
                        title: TransactionConstants.firstName.tr,
                        isRequired: true),

                    Obx(() => AppTextField(
                          controller: controller.firstNameController,
                          keyboardType: TextInputType.name,
                          onChangedText: (value) {
                            controller.checkButtonEnable();
                            controller.firstNameValidate.value = '';
                          },
                          errorText: controller.firstNameValidate.value,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(controller.lastNameFocusNode),
                          focusNode: controller.firstNameFocusNode,
                        )),
                    SizedBox(
                      height: 24.h,
                    ),
                    _buildTitle(
                        title: TransactionConstants.lastName.tr,
                        isRequired: true),

                    Obx(
                      () => AppTextField(
                        controller: controller.lastNameController,
                        keyboardType: TextInputType.name,
                        onChangedText: (value) {
                          controller.checkButtonEnable();
                          controller.lastNameValidate.value = '';
                        },
                        errorText: controller.lastNameValidate.value,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(controller.phoneFocusNode),
                        focusNode: controller.lastNameFocusNode,
                      ),
                    ),

                    SizedBox(
                      height: 24.h,
                    ),
                    _buildTitle(
                        title: TransactionConstants.telephone.tr,
                        isRequired: true),
                    Obx(() => AppTextField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          onChangedText: (value) {
                            controller.checkButtonEnable();
                            controller.phoneValidate.value = '';
                          },
                          errorText: controller.phoneValidate.value,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(controller.addressFocusNode),
                          focusNode: controller.phoneFocusNode,
                        )),
                    SizedBox(
                      height: 24.h,
                    ),
                    _buildTitle(
                        title: TransactionConstants.address.tr,
                        isRequired: true),
                    Obx(() => AppTextField(
                          controller: controller.addressController,
                          keyboardType: TextInputType.name,
                          onChangedText: (value) {
                            controller.checkButtonEnable();
                            controller.addressValidate.value = '';
                          },
                          errorText: controller.addressValidate.value,
                          textInputAction: TextInputAction.done,
                          onEditingComplete:
                              controller.onEditingCompleteAddress,
                          focusNode: controller.addressFocusNode,
                        )),
                    SizedBox(
                      height: 24.h,
                    ),
                    Obx(() => _buildItemDefaultAddress(
                        title: TransactionConstants
                            .addressDefaultBillingAddress.tr,
                        isSelected: controller.defaultBillingAddress.value,
                        onSelect: controller.onChangeSetDefaultBillingAddress)),
                    SizedBox(
                      height: 24.h,
                    ),
                    Obx(() => _buildItemDefaultAddress(
                        title: TransactionConstants
                            .addressDefaultShippingAddress.tr,
                        isSelected: controller.defaultShippingAddress.value,
                        onSelect:
                            controller.onChangeSetDefaultShippingAddress)),
                    // AppButton(
                    //   margin: EdgeInsets.all(0),
                    //   title: TransactionConstants.,
                    //   onPressed: () {
                    //     if (controller.buttonEnable.value) {
                    //       controller.saveInfo();
                    //     }
                    //   },
                    //   buttonState: controller.buttonState.value,
                    // ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Obx(() => AppButton(
                          //   margin: EdgeInsets.all(0),
                          title: TransactionConstants.save.tr,
                          onPressed: controller.onPressedSave,
                          loaded: controller.rxLoadedButton.value,
                        )),
                    SizedBox(
                      height: AppDimens.height_50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }

  // Widget _itemInfoSkeletonWidget() {
  //   return ContainerSkeletonWidget(
  //     height: 48.h,
  //     width: double.infinity,
  //     borderRadius: AppDimens.radius_5,
  //   );
  // }

  Widget _buildTitle({required String title, bool isRequired = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.sp),
      child: Text(
        isRequired ? '$title *' : title,
        style: ThemeText.bodySemibold,
      ),
    );
  }

  Widget _buildItemDefaultAddress(
      {required String title,
      bool isSelected = false,
      required Function()? onSelect}) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(right: 24),
        child: Row(
          children: [
            AppImageWidget(
              asset: isSelected
                  ? Assets.images.icCircleChecked
                  : Assets.images.icCircleUnchecked,
              size: 20.sp,
            ),
            SizedBox(width: 8.sp),
            Text(
              title,
              style: ThemeText.bodyRegular,
            )
          ],
        ),
      ),
    );
  }

// Widget _buildStateDropDownButton(BuildContext context,
//     {bool? hasFocus = false,
//       required var selected,
//       required Function(Object?) onChanged,
//       required List items,
//       required Function() onTap}) {
//   return Container(
//       height: 48.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(AppDimens.radius_5),
//         border: Border.all(
//             color:
//             //hasFocus ? AppColors.primary :
//             AppColors.greyF0FF,
//             width: 1.0),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: AppDimens.width_16,
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton(
//             isExpanded: true,
//             alignment: Alignment.center,
//             elevation: 0,
//             value: selected,
//             onChanged: onChanged,
//             icon: Icon(Icons.arrow_drop_down),
//             items: items
//                 .map((e) => DropdownMenuItem(
//               value: e,
//               child: e.toString().isEmpty
//                   ? SizedBox(
//                 height: 0,
//               )
//                   : Text(
//                 e.toString(),
//                 style: ThemeText.body5.copyWith(
//                     color: AppColors.grey, height: 1.8),
//               ),
//             ))
//                 .toList(),
//           ),
//         ),
//       ));
// }
}
