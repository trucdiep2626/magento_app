import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/domain/models/search_criteria_model.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/domain/usecases/category_usecase.dart';
import 'package:magento_app/domain/usecases/home_usecase.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/snack_bar/app_snack_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductDetailController extends GetxController with MixinController {
  Rx<ProductModel> product = ProductModel().obs;

  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;
  RxList<CategoryTreeModel> categories = <CategoryTreeModel>[].obs;
  final ProductUseCase productUseCase;
//  final CategoryUseCase categoryUseCase;

  //final mainController = Get.find<MainController>();
  Rx<int?> categoryId = (null as int?).obs;
  RxInt quantity = 1.obs;


  ProductDetailController({
    required this.productUseCase,
  //  required this.categoryUseCase,
  });


  void increaseQuantity()
  {
    quantity.value = quantity.value +1;
  }

  void decreaseQuantity()
  {
    if(quantity.value > 0 )
      {
        quantity.value =  quantity.value -1;
      }
  }


  Future<void> getProductList() async {
    // rxLoadedList.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    // final result = await productUseCase.getProductsWithAttribute(
    //   pageSize: 10,
    //   currentPage: currentPage.value,
    //   sortOrders: _getSortOrders(),
    //   filters: _getFilters(),
    // );
    // if (result != null) {
    //   products.addAll(result.items ?? []);
    //   // totalPurchaseOrder.value = (result).items?.total ?? 0;
    //   currentPage.value = currentPage.value + 1;
    //   canLoadMore.value = products.value.length < (result.totalCount ?? 0);
    // } else {
    //   showTopSnackBarError(context, TransactionConstants.unknownError.tr);
    // }
    // //  displayPurchaseOrderList.value = purchaseOrderList;
    // // rxLoadedList.value = LoadedType.finish;
    // productRefreshController.loadComplete();
  }

  goToDetail(ProductModel productModel) async {
    // final result = await Get.toNamed(AppRoute.purchaseOrderDetail, arguments: {
    //   'id': purchaseOrderEntity.id,
    //   'order_number': purchaseOrderEntity.orderNumber,
    //   'status_id': purchaseOrderEntity.status
    // });
    // if (result['is_canceled'] || result['is_deposited']) {
    //   if (result['is_deposited']) {
    //     shouldRefresh.value = true;
    //   }
    //   await getPurchaseOrderList();
    // }
  }






  @override
  void onInit() async {
    super.onInit();
    Map? args = Get.arguments;
    categoryId.value = args?['category_id'];
    debugPrint('============${categoryId.value}');
  }

  @override
  void onReady() async {
    super.onReady();
   // await onRefresh();
   // await getCategoriesTree();
    // searchController.addListener(() {
    //   if (AppUtils.isNullEmpty(searchController.text.trim())) {
    //     displayPurchaseOrderList.value = purchaseOrderList;
    //   }
    // });
  }
}
