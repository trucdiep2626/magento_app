import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/domain/usecases/cart_usecase.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/cart/cart_controller.dart';
import 'package:magento_app/presentation/widgets/snack_bar/app_snack_bar.dart';

class ProductDetailController extends GetxController with MixinController {
  Rx<ProductModel> product = ProductModel().obs;

  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;
  RxList<CategoryTreeModel> categories = <CategoryTreeModel>[].obs;
  final ProductUseCase productUseCase;
  final CartUseCase cartUseCase;

  //final mainController = Get.find<MainController>();
  String? sku;
  RxInt quantity = 1.obs;

  ProductDetailController({
    required this.productUseCase,
    required this.cartUseCase,
    //  required this.categoryUseCase,
  });

  void increaseQuantity() {
    if ((product.value.extensionAttributes?.stockItem?.qty ?? 1) >
        quantity.value) {
      quantity.value = quantity.value + 1;
    }
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value = quantity.value - 1;
    }
  }

  Future<void> getProductDetail() async {
    rxLoadedList.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    if (sku == null) return;

    final result = await productUseCase.getProductDetail(sku: sku!);
    if (result != null) {
      product.value = result;
    }

    rxLoadedList.value = LoadedType.finish;
  }

  Future<void> addToCart() async {
    rxLoadedList.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    if (sku == null) return;

    final result = await cartUseCase.addToCart(
        sku: sku!,
        qty: quantity.value,
        image: product.value.mediaGalleryEntries?.first.file ?? '');
    if (result) {
      showTopSnackBar(context,
          message: TransactionConstants.successfully.tr,
          type: SnackBarType.done);
      await Get.find<CartController>().getProductsList();
      await getProductDetail();
    }

    rxLoadedList.value = LoadedType.finish;
  }

  @override
  void onInit() async {
    super.onInit();
    sku = Get.arguments;
    debugPrint('============${sku}');
  }

  @override
  void onReady() async {
    super.onReady();
    await getProductDetail();
    // await getCategoriesTree();
    // searchController.addListener(() {
    //   if (AppUtils.isNullEmpty(searchController.text.trim())) {
    //     displayPurchaseOrderList.value = purchaseOrderList;
    //   }
    // });
  }
}
