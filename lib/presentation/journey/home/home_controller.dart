import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/domain/models/store_config_response_model.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/domain/usecases/cart_usecase.dart';
import 'package:magento_app/domain/usecases/category_usecase.dart';
import 'package:magento_app/domain/usecases/home_usecase.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/cart/cart_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/snack_bar/app_snack_bar.dart';

class HomeController extends GetxController with MixinController {
  RxList<ProductModel> hotItems = <ProductModel>[].obs;

  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;
  RxList<CategoryTreeModel> categories = <CategoryTreeModel>[].obs;
  final HomeUseCase homeUseCase;
  final ProductUseCase productUseCase;
  final CategoryUseCase categoryUseCase;
  final AccountUseCase accountUseCase;
 // final CartUseCase cartUseCase;

  final mainController = Get.find<MainController>();

  HomeController({
    required this.homeUseCase,
    required this.productUseCase,
    required this.categoryUseCase,
    required this.accountUseCase,
  //  required this.cartUseCase,
  });

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  Future<void> getStoreConfig() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }
    final result = await homeUseCase.getStoreConfig();
    if (result != null) {
      mainController.storeConfig.value = result;
    } else {
      showTopSnackBarError(context, TransactionConstants.unknownError.tr);
    }
  }

  // Future<void> getCategoriesTree() async {
  //   categories.clear();
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.none) {
  //     showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
  //     return;
  //   }
  //   final result = await categoryUseCase.getCategorysWithAttribute();
  //   if (result != null) {
  //     categories.addAll(result.childrenData ?? []);
  //   } else {
  //     showTopSnackBarError(context, TransactionConstants.unknownError.tr);
  //   }
  // }

  Future<void> getHotItems() async {
    hotItems.clear();
    final result = await productUseCase.getProductsWithAttribute();
    if (result != null) {
      hotItems.value = result.items ?? [];
    } else {
      // showTopSnackBarError(context, TransactionConstants.unknownError);
    }
  }

  // Future<void> addToCart(ProductModel productModel) async {
  //   rxLoadedList.value = LoadedType.start;
  //
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.none) {
  //     showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
  //     return;
  //   }
  //
  //   if (productModel.sku == null) return;
  //
  //   final result = await cartUseCase.addToCart(
  //       sku: productModel.sku!,
  //       qty: 1,
  //       image: productModel.mediaGalleryEntries?.first.file ?? '');
  //   if (result) {
  //     showTopSnackBar(context,
  //         message: TransactionConstants.successfully.tr,
  //         type: SnackBarType.done);
  //     await Get.find<CartController>().getProductsList();
  //   }
  //
  //   rxLoadedList.value = LoadedType.finish;
  // }

  @override
  Future<void> onReady() async {
    super.onReady();
    rxLoadedList.value = LoadedType.start;
    await getStoreConfig();
    //  await getCategoriesTree();
    await getHotItems();
    //  await loginWithUsername();
    rxLoadedList.value = LoadedType.finish;
  }
}
