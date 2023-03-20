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

enum SortType {
  none,
  asc,
  desc,
}

class ProductController extends GetxController with MixinController {
  RxList<ProductModel> products = <ProductModel>[].obs;

  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;
  RxList<CategoryTreeModel> categories = <CategoryTreeModel>[].obs;
  final ProductUseCase productUseCase;
  final CategoryUseCase categoryUseCase;
  RxInt currentPage = 1.obs;
  RxBool canLoadMore = true.obs;
  final scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  // RxInt totalPurchaseOrder = 0.obs;
  RxBool shouldRefresh = false.obs;
  final RefreshController productRefreshController =
      RefreshController(initialRefresh: false);
  final mainController = Get.find<MainController>();
  int? categoryId;

  Rx<SortType> sortByName = SortType.none.obs;
  Rx<SortType> sortByPrice = SortType.none.obs;

  ProductController({
    required this.productUseCase,
    required this.categoryUseCase,
  });

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  Future<void> onChangeSortByName() async {
    switch (sortByName.value) {
      case SortType.none:
        sortByName.value = SortType.asc;
        break;
      case SortType.asc:
        sortByName.value = SortType.desc;
        break;
      case SortType.desc:
        sortByName.value = SortType.none;
        break;
    }
    await onRefresh();
  }

  Future<void> onChangeSortByPrice() async {
    switch (sortByPrice.value) {
      case SortType.none:
        sortByPrice.value = SortType.asc;
        break;
      case SortType.asc:
        sortByPrice.value = SortType.desc;
        break;
      case SortType.desc:
        sortByPrice.value = SortType.none;
        break;
    }
    await onRefresh();
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

  Future<void> getProductList() async {
    // rxLoadedList.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    final result = await productUseCase.getProductsWithAttribute(
      pageSize: 10,
      currentPage: currentPage.value,
      sortOrders: _getSortOrders(),
      filters: _getFilters(),
    );
    if (result != null) {
      products.addAll(result.items ?? []);
      // totalPurchaseOrder.value = (result).items?.total ?? 0;
      currentPage.value = currentPage.value + 1;
      canLoadMore.value = products.value.length < (result.totalCount ?? 0);
    } else {
      showTopSnackBarError(context, TransactionConstants.unknownError.tr);
    }
    //  displayPurchaseOrderList.value = purchaseOrderList;
    // rxLoadedList.value = LoadedType.finish;
    productRefreshController.loadComplete();
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

  Map<String, dynamic> _getSortOrders() {
    Map<String, dynamic> sortOrders = {};

    if (sortByPrice.value != SortType.none) {
      SortOrders sortPrice =
          SortOrders(field: 'price', direction: sortByPrice.value.name);
      sortOrders.addAll(sortPrice.toJson());
    }

    if (sortByName.value != SortType.none) {
      SortOrders sortName =
          SortOrders(field: 'name', direction: sortByName.value.name);
      sortOrders.addAll(sortName.toJson(index: 1));
    }

    return sortOrders;
  }

  Map<String, dynamic> _getFilters() {
    Map<String, dynamic> filters = {};
    int index1 = 0;
    int index2 = 0;

    if (searchController.text.trim().isNotEmpty) {
      Filters searchFilter = Filters(
        field: 'name',
        value: '%${searchController.text.trim()}%',
        conditionType: 'like',
      );
      filters.addAll(searchFilter.toJson(index1: index1, index2: index2));
      index1++;
    }

    if (categoryId != null) {
      Filters categoryFilter = Filters(
        field: 'category_id',
        value: categoryId.toString(),
        conditionType: 'in',
      );
      filters.addAll(categoryFilter.toJson(index1: index1, index2: index2));
      index1++;
    }

    return filters;
  }

  Future<void> onRefresh() async {
    rxLoadedList.value = LoadedType.start;
    currentPage.value = 1;
    products.clear();
    await getProductList();
    //  await onSearch(searchController.text.trim());
    productRefreshController.refreshCompleted();
    rxLoadedList.value = LoadedType.finish;
  }

  Future<void> onSearch() async {
    // rxPurchaseOrderLoaded.value = LoadedType.start;
    // if (value.isNotEmpty) {
    //   List<PurchaseOrderEntity> resultPurchaseOrderList = [];
    //   for (PurchaseOrderEntity purchaseOrder in purchaseOrderList) {
    //     if (purchaseOrder.orderNumber!.toUpperCase().contains(value.toUpperCase())) {
    //       resultPurchaseOrderList.add(purchaseOrder);
    //     }
    //   }
    //   displayPurchaseOrderList.value = resultPurchaseOrderList;
    // } else {
    //   displayPurchaseOrderList.value = purchaseOrderList;
    // }
    // rxPurchaseOrderLoaded.value = LoadedType.finish;
  }

  @override
  void onInit() async {
    super.onInit();
    Map? args = Get.arguments;
    categoryId = args?['category_id'];
    debugPrint('============$categoryId');
  }

  @override
  void onReady() async {
    super.onReady();
    await onRefresh();
    // searchController.addListener(() {
    //   if (AppUtils.isNullEmpty(searchController.text.trim())) {
    //     displayPurchaseOrderList.value = purchaseOrderList;
    //   }
    // });
  }
}
