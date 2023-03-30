import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/cart/cart_controller.dart';
import 'package:magento_app/presentation/journey/estimate_shipping/estimate_shipping_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/journey/payment/payment_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CheckoutController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedList = LoadedType.finish.obs;

  Rx<LoadedType> rxLoadedButton = LoadedType.finish.obs;

  final mainController = Get.find<MainController>();
  final cartController = Get.find<CartController>();
  final shippingController = Get.find<EstimateShippingController>();
  final paymentController = Get.find<PaymentController>();
}
