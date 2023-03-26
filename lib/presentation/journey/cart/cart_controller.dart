import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartController extends GetxController with MixinController {
  // final ExchangeRateUseCase exchangeRateUseCase;
  //final CartUsecase cartUsecase;
  // final AuthenticationUseCase authUseCase;
  final ProductUseCase productUseCase;

  RxBool buttonEnable = false.obs;
  String token = '';
  // RxList<ProductCartEntity> selectedItems = <ProductCartEntity>[].obs;
  // RxList<ProductCartEntity> items = <ProductCartEntity>[].obs;
  Rx<LoadedType> buttonState = LoadedType.finish.obs;

  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;

  final RefreshController cartRefreshController =
      RefreshController(initialRefresh: false);

  CartController({required this.productUseCase});

  // MainController mainController = Get.find<MainController>();
  RxBool isSelectedAll = false.obs;

  void checkButtonEnable() {
    // if (selectedItems.value.isNotEmpty) {
    //   buttonEnable.value = true;
    // } else {
    //   buttonEnable.value = false;
    // }
  }

  // Future<void> getToken() async {
  //   token = await authUseCase.getToken();
  // }

  // bool checkSelectAll() {
  //   return items.value.length == selectedItems.value.length;
  // }

  onPressCreateOrder() async {
    buttonState.value = LoadedType.start;
    // List<int> ids = [];
    // for (ProductCartEntity product in selectedItems.value) {
    //   if (product.id != null) {
    //     ids.add(product.id!);
    //   }
    // }
    // final request = CreateNewOrderRequest(
    //     ids: ids,
    //     warehouseId: int.parse(
    //       selectedWarehouse.value.id ?? '0',
    //     ),
    //     orderType: selectedType.value);
    // final result = await mainController.requestApi(() => cartUsecase.createNewOrder(token, request.toJson), context!);
    // buttonState.value = ButtonState.active;
    // if (result.code! == 200) {
    //   Get.back();
    //   Get.back();
    //   log(result.code.toString());
    //   selectedItems.clear();
    //   isSelectedAll.value = false;
    //   await getProductsList();
    // } else {
    //   showTopSnackBarError(context!, 'Đã xảy ra lỗi. Vui lòng thử lại!');
    // }
  }

  Future<void> onRefresh() async {
    await getProductsList();
    cartRefreshController.refreshCompleted();
  }

  onChangeSelect(
      //    ProductCartEntity item
      ) {
    //  List<ProductCartEntity> selectedProducts = [];
    // selectedProducts.addAll(selectedItems.value);
    // if (selectedProducts.contains(item)) {
    //   selectedProducts.remove(item);
    // } else {
    //   selectedProducts.add(item);
    // }
    // selectedItems.clear();
    // selectedItems.value.addAll(selectedProducts);
    // isSelectedAll.value = checkSelectAll();
  }

  onPressDeleteItem(
      //ProductCartEntity item
      ) async {
    // ButtonState acceptButtonState = ButtonState.active;
    // await showAppDialog(context!, 'Xóa sản phẩm', 'Bạn có chắc chắn muốn xóa sản phẩm này không?',
    //     firstButtonText: StringConstants.yes,
    //     firstButtonState: acceptButtonState,
    //     messageTextAlign: TextAlign.start,
    //     dismissAble: true,
    //     firstButtonCallback: () async {
    //       acceptButtonState = ButtonState.loading;
    //       final result = await mainController.requestApi(() => cartUsecase.deleteProduct(token, item.id!), context!);
    //       if (result.status != null && result.status!) {
    //         List<ProductCartEntity> oldItems = [];
    //         oldItems.addAll(items.value);
    //         oldItems.remove(item);
    //         items.clear();
    //         items.value.addAll(oldItems);
    //         if (selectedItems.value.contains(item)) {
    //           List<ProductCartEntity> oldSelectedItems = [];
    //           oldSelectedItems.addAll(selectedItems.value);
    //           oldSelectedItems.remove(item);
    //           selectedItems.clear();
    //           selectedItems.value.addAll(oldItems);
    //           isSelectedAll.value = checkSelectAll();
    //         }
    //         acceptButtonState = ButtonState.active;
    //         Get.back();
    //         // await getProductsList();
    //       } else {
    //         showTopSnackBarError(context!, 'Đã xảy ra lỗi. Vui lòng thử lại!');
    //       }
    //     },
    //     secondButtonText: StringConstants.no,
    //     secondButtonCallback: () => Get.back());
  }

  clearAllSelectedList() {
    // selectedItems.clear();
    // isSelectedAll.value = false;
  }

  clearAllItem() {
    // selectedItems.clear();
    // isSelectedAll.value = false;
  }

  Future<void> getProductsList() async {
    rxLoadedList.value = LoadedType.start;
    // items.clear();
    // selectedItems.clear();
    // isSelectedAll.value = false;
    // final result = await mainController.requestApi(() => cartUsecase.getCart(token), context!);
    rxLoadedList.value = LoadedType.finish;
    // if (result.msg!.errorMsg == 'success') {
    //   items.value.addAll(result.data ?? []);
    // } else {
    //   showTopSnackBarError(context!, 'Đã xảy ra lỗi. Vui lòng thử lại!');
    // }
  }

  onChangeSelectAllItem() {
    // if (selectedItems.value.length == items.value.length) {
    //   selectedItems.clear();
    //   isSelectedAll.value = false;
    // } else {
    //   List<ProductCartEntity> selectedProducts = [];
    //   selectedProducts.addAll(items.value);
    //   selectedItems.clear();
    //   selectedItems.value.addAll(selectedProducts);
    //   isSelectedAll.value = true;
    // }
  }

  @override
  void onReady() async {
    super.onReady();
    await getProductsList();
  }
}
