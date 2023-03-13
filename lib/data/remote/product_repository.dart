import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/app_config.dart';
import 'package:magento_app/common/config/network/api_endpoints.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/cms_block_response_model.dart';
import 'package:magento_app/domain/models/products_response_model.dart';

class ProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

  Future<ProductsResponseModel> getProductsWithAttribute(
      {int currentPage = 1}) async {
    final result = await _dio.request(
        '${NetworkConfig.baseUrl}${ApiEndpoints.getProducts}?${searchKeyCurrentPage}=$currentPage&$searchKeyPageSize=$pageSize',
        options: Options(
          method: 'GET',
          headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
        ));
    final ProductsResponseModel response =
        ProductsResponseModel.fromJson(result.data);
    return response;
  }

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
