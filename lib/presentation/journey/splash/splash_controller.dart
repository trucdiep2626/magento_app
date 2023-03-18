import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';

class SplashController extends GetxController with MixinController {
  SplashController();

  @override
  void onInit() {
    super.onInit();
    setStatusBarStyle(statusBarStyleType: StatusBarStyleType.light);
  }

  @override
  void onReady() {
    super.onReady();
    rxLoadedType.value = LoadedType.start;
    Future.delayed(const Duration(seconds: 1)).then((_) async {
      rxLoadedType.value = LoadedType.finish;
      Get.offAndToNamed(AppRoutes.main);
    });
  }
}
