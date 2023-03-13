import 'package:magento_app/common/config/app_config.dart';

class ApiEndpoints {
  // static endpoints

  static String cmsHome = '/rest/default/V1/cmsBlock/${AppConfig.cmsHomeBlock}';
  static String getCategoriesList = '/rest/default/V1/categories/list';
  static String getProducts = '/rest/default/V1/products';
}
