import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/domain/usecases/home_usecase.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/widgets/snack_bar/app_snack_bar.dart';

class HomeController extends GetxController with MixinController {
  RxList<ProductModel> hotItems = <ProductModel>[].obs;

  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;

  final HomeUseCase homeUseCase;
  final ProductUseCase productUseCase;

  HomeController({required this.homeUseCase, required this.productUseCase});

  Future<void> getHotItems() async {
    rxLoadedList.value = LoadedType.start;
    hotItems.clear();
    final result = await productUseCase.getProductsWithAttribute();
    if (result != null) {
      hotItems.value = result.items ?? [];
    } else {
      showTopSnackBarError(context, TransactionConstants.unknownError);
    }
    rxLoadedList.value = LoadedType.finish;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getHotItems();
  }
}
