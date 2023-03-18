import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/domain/usecases/category_usecase.dart';
import 'package:magento_app/domain/usecases/home_usecase.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
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

  final mainController = Get.find<MainController>();

  HomeController({
    required this.homeUseCase,
    required this.productUseCase,
    required this.categoryUseCase,
    required this.accountUseCase,
  });

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  Future<void> getCategoriesTree() async {
    categories.clear();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);

      return;
    }

    final result = await categoryUseCase.getCategorysWithAttribute();
    if (result != null) {
      categories.addAll(result.childrenData ?? []);
      debugPrint('==========$categories');
    } else {
      showTopSnackBarError(context, TransactionConstants.unknownError.tr);
    }
  }

  Future<void> getHotItems() async {
    hotItems.clear();
    final result = await productUseCase.getProductsWithAttribute();
    if (result != null) {
      hotItems.value = result.items ?? [];
    } else {
      showTopSnackBarError(context, TransactionConstants.unknownError);
    }
  }

  Future<void> loginWithUsername() async {
    String? username =
        await accountUseCase.getSecureData(StringConstants.keyEmail);
    String? password =
        await accountUseCase.getSecureData(StringConstants.keyPassword);

    if (isNullEmpty(username) || isNullEmpty(password)) {
      mainController.token.value = '';
      mainController.rxCustomer.value = null;
    } else {
      final result =
          await accountUseCase.login(username: username!, password: password!);

      try {
        if (result != null) {
          debugPrint('đăng nhập thành công');
          await accountUseCase.saveToken(result);
          mainController.token.value = result;
          final customerInfo = await accountUseCase.getCustomerInformation();

          if (customerInfo != null) {
            await accountUseCase.saveCustomerInformation(customerInfo);
            mainController.rxCustomer.value = customerInfo;
          } else {
            showTopSnackBarError(context, TransactionConstants.unknownError.tr);
          }
        } else {
          mainController.token.value = '';
          mainController.rxCustomer.value = null;
        }
        mainController.updateLogin();
      } catch (e) {
        debugPrint(e.toString());
        mainController.token.value = '';
        mainController.rxCustomer.value = null;
        showTopSnackBarError(context, TransactionConstants.unknownError.tr);
      }
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    rxLoadedList.value = LoadedType.start;
    await getCategoriesTree();
    await getHotItems();
    await loginWithUsername();
    rxLoadedList.value = LoadedType.finish;
  }
}
