import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/estimate_shipping_methods_model.dart';
import 'package:magento_app/domain/usecases/cart_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/cart/cart_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EstimateShippingController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedList = LoadedType.finish.obs;

  RxList<EstimateShippingMethodsModel> methods =
      <EstimateShippingMethodsModel>[].obs;

  final RefreshController productRefreshController =
      RefreshController(initialRefresh: false);
  final mainController = Get.find<MainController>();
  final cartController = Get.find<CartController>();

  Rx<EstimateShippingMethodsModel> selectedMethod =
      EstimateShippingMethodsModel().obs;

  final CartUseCase cartUseCase;

  int? addressId;

  EstimateShippingController({required this.cartUseCase});

  Future<void> onRefresh() async {
    // rxLoadedList.value = LoadedType.start;
    // currentPage.value = 1;
    // products.clear();
    // await getProductList();
    //  await onSearch(searchController.text.trim());
    await mainController.getUserProfile();
    productRefreshController.refreshCompleted();
    // rxLoadedList.value = LoadedType.finish;
  }

  Future<void> getMethods() async {
    rxLoadedList.value = LoadedType.start;
    methods.clear();
    final result =
        await cartUseCase.getEstimateShippingMethods(addressId: addressId ?? 0);

    methods.value = result;
    if (methods.isNotEmpty) {
      selectedMethod.value = methods.first;
    }

    rxLoadedList.value = LoadedType.finish;
  }

  updateSelectedMethod(EstimateShippingMethodsModel method) {
    selectedMethod.value = method;
  }

  @override
  void onInit() {
    super.onInit();
    addressId = Get.arguments;
  }

  @override
  void onReady() async {
    super.onReady();

    await getMethods();
  }
}
