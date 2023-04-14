import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';

class MessageController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;
}
