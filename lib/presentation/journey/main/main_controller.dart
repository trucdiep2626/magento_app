import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/customer_model.dart';
import 'package:magento_app/domain/models/store_config_response_model.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/presentation/controllers/app_controller.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class MainController extends GetxController with MixinController {
  RxInt rxCurrentNavIndex = 0.obs;
  Rx<StoreConfigResponseModel> storeConfig = StoreConfigResponseModel().obs;
  final AccountUseCase accountUseCase;
  RxString token = ''.obs;
  Rx<LoadedType> rxCustomerLoaded = LoadedType.start.obs;

  final AppController _appController = Get.find<AppController>();

  RxBool isLogin = false.obs;

  Rx<CustomerModel?> rxCustomer = (null as CustomerModel?).obs;

  Rx<int?> cartId = (null as int?).obs;

  MainController({required this.accountUseCase});

  Future<void> getToken() async {
    token.value = accountUseCase.getToken() ?? '';
  }

  void updateLogin() {
    isLogin.value = token.value.isNotEmpty && rxCustomer.value != null;
  }

  onWillPop() {
    if (rxCurrentNavIndex.value == 0) {
      _appController.exitApp(context);
    } else {
      rxCurrentNavIndex.value = 0;
    }
    return Future.value(false);
  }

  // Future<void> getUserProfile() async {
  //   rxCustomer.value = await accountUseCase.getCustomerInformation();
  // }

  void onChangedNav(int index) {
    rxCurrentNavIndex.value = index;
  }

  Future<void> getUserProfile() async {
    rxCustomerLoaded.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxCustomer.value = accountUseCase.getCustomerInformationLocal();
      rxCustomerLoaded.value = LoadedType.finish;
      return;
    }

    final customerInfo = await accountUseCase.getCustomerInformation();

    if (customerInfo != null) {
      await accountUseCase.saveCustomerInformation(customerInfo);
      rxCustomer.value = customerInfo;
      // mainController.updateLogin();
      // //go to main screen
      // Get.back();
    } else {
      showTopSnackBarError(context, TransactionConstants.unknownError.tr);
    }

    rxCustomerLoaded.value = LoadedType.finish;
  }

  @override
  void onInit() {
    super.onInit();
    setStatusBarStyle(statusBarStyleType: StatusBarStyleType.dark);
  }

  @override
  void onReady() async {
    super.onReady();
    await getToken();
    await getUserProfile();
    updateLogin();
  }
}
