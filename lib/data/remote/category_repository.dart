import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:magento_app/common/config/network/api_endpoints.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/domain/models/get_products_of_category_response_model.dart';

class CategoryRepository {
  final Dio _dio;

  CategoryRepository(this._dio);

  Future<CategoryTreeModel?> getCategoriesTree() async {
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.getCategoriesTree}',
          options: Options(
            method: 'GET',
          ));
      final CategoryTreeModel response =
          CategoryTreeModel.fromJson(result.data);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<List<GetProductsOfCategoryResponseModel>?> getProsuctsOfCategory(
      int categoryId) async {
    try {
      final products = <GetProductsOfCategoryResponseModel>[];

      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.getCategoriesTree}/$categoryId/products',
          options: Options(
            method: 'GET',
          ));

      if (result.data is List) {
        for (var element in (result.data as List)) {
          debugPrint('------------$element');
          final product = GetProductsOfCategoryResponseModel.fromJson(element);
          products.add(product);
        }
      }
      return products;
    } catch (e) {
      return null;
    }
  }

  // Future<String?> getCategoryImage() async {
  //   try {
  //     final result = await _dio.request(
  //         '${NetworkConfig.baseUrl}${ApiEndpoints.getCategoriesTree}',
  //         options: Options(
  //           method: 'GET',
  //           headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
  //         ));
  //     final CategoryTreeModel response =
  //     CategoryTreeModel.fromJson(result.data);
  //     return response;
  //   } catch (e) {
  //     return null;
  //   }
  // }

// getCategoryProducts: (id, offset = 0, sortOrder, pageSize = PAGE_SIZE) =>
// magento.admin.getProductsWithAttribute(
// 'category_id',
// id,
// offset,
// sortOrder,
// pageSize,
// 'eq',
// ),
//
// getProductsWithAttribute: (
// attributeCode,
// attributeValue,
// offset = 0,
// sortOrder,
// pageSize = PAGE_SIZE,
// conditionType = 'like',
// ) => {
// const currentPage = parseInt(offset / pageSize, 10) + 1;
// const params = {
// 'searchCriteria[filterGroups][0][filters][0][field]': attributeCode,
// 'searchCriteria[filterGroups][0][filters][0][value]': attributeValue,
// 'searchCriteria[filterGroups][0][filters][0][conditionType]': conditionType,
// 'searchCriteria[filterGroups][1][filters][0][field]': 'visibility',
// 'searchCriteria[filterGroups][1][filters][0][value]': '4',
// 'searchCriteria[filterGroups][1][filters][0][conditionType]': 'eq',
// 'searchCriteria[pageSize]': pageSize,
// 'searchCriteria[currentPage]': currentPage,
// };
// if (sortOrder) {
// params['searchCriteria[sortOrders][0][field]'] = getSortFieldName(
// sortOrder,
// );
// params['searchCriteria[sortOrders][0][direction]'] = getSortDirection(
// sortOrder,
// );
// }
// return magento.admin.getProductsWithSearchCritaria(params);
// },

}
