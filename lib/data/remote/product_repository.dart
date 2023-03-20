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

  Future<ProductsResponseModel?> getProductsWithAttribute(
      {int pageSize = 10,
      int currentPage = 1,
      Map<String, dynamic>? filters,
      Map<String, dynamic>? sortOrders,
      String? fields}) async {
    // String searchKey = getSearchKey(
    //   pageSize: pageSize,
    //   currentPage: currentPage,
    //   conditionType: conditionType,
    //   attributeCode: attributeCode,
    //   attributeValue: attributeValue,
    //   fields: fields,
    // );

    Map<String, dynamic> _params = {
      searchKeyPageSize: pageSize,
      searchKeyCurrentPage: currentPage,
    };

    if (filters != null) {
      _params.addAll(filters);
    }

    if (sortOrders != null) {
      _params.addAll(sortOrders);
    }

    if (fields != null) {
      _params.addAll({searchKeyFields: fields});
    }

    debugPrint('=====$_params');

    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.getProducts}',
          queryParameters: _params,
          options: Options(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
          ));
      final ProductsResponseModel response =
          ProductsResponseModel.fromJson(result.data);
      return response;
    } catch (e) {
      return null;
    }
  }

  String getSearchKey({
    int pageSize = 10,
    int currentPage = 1,
    String? conditionType,
    String? attributeCode,
    String? attributeValue,
    String? fields,
  }) {
    debugPrint('-----------$currentPage');
    String searchKey =
        '$searchKeyCurrentPage=$currentPage&$searchKeyPageSize=$pageSize';

    if (attributeCode != null)
      searchKey += '&${searchKeyFieldName}=$attributeCode';

    if (attributeValue != null)
      searchKey += '&${searchKeyFieldValue}=$attributeValue';

    if (conditionType != null)
      searchKey += '&${searchKeyConditionType}=$conditionType';

    if (fields != null) searchKey += '&${searchKeyFields}=$fields';

    debugPrint('-----------$searchKey');
    return searchKey;
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
