import 'package:magento_app/common/config/app_config.dart';

class ApiEndpoints {
  // static endpoints

  static String cmsHome = '/rest/default/V1/cmsBlock/${AppConfig.cmsHomeBlock}';
  static String getCategoriesList = '/rest/default/V1/categories/list';
  static String getProducts = '/rest/default/V1/products';
  static String getCategoriesTree = '/rest/default/V1/categories';
  static String login = '/rest/default/V1/integration/customer/token';
  static String getCustomerInfor = '/rest/V1/customers/me';
  static String getStoreConfig = '/rest/default/V1/store/storeConfigs';
  static String register = '/rest/V1/customers';
}
