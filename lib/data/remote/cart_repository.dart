import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/config/network/api_endpoints.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/common/utils/translations/app_translations.dart';
import 'package:magento_app/domain/models/cart_information_model.dart';
import 'package:magento_app/domain/models/estimate_shipping_methods_model.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class CartRepository {
  final Dio _dio;

  CartRepository(this._dio);

  Future<CartInformationModel?> getCartInfor(String token) async {
    try {
      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.cart}',
              options: Options(
                method: 'GET',
                headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
              ));
      if (result.statusCode == 200) {
        return CartInformationModel.fromJson(result.data);
      }
      // if (result.statusCode == 404) {
      //   return null;
      // }
      // showTopSnackBarError(Get.context!,
      //     result.statusMessage ?? TransactionConstants.unknownError.tr);
      return null;
    } catch (e) {
      //   showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      debugPrint(e.toString());
      return null;
    }
  }

  Future<int?> createCart(String token) async {
    try {
      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.cart}',
              options: Options(
                method: 'POST',
                headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
              ));
      if (result.statusCode == 200) {
        return result.data;
      }
      showTopSnackBarError(Get.context!,
          result.statusMessage ?? TransactionConstants.unknownError.tr);
      return null;
    } catch (e) {
      showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> addToCart({
    required String sku,
    required int qty,
    required String token,
    required String image,
  }) async {
    try {
      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.cartItem}',
              data: {
                "cartItem": {
                  "sku": sku,
                  "qty": qty,
                  "product_option": {
                    "extension_attributes": {
                      "custom_options": [
                        {
                          "option_id": "image",
                          "option_value": image,
                        }
                      ]
                    }
                  }
                }
              },
              options: Options(
                method: 'POST',
                headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
              ));
      if (result.statusCode == 200) {
        return true;
      }
      showTopSnackBarError(Get.context!,
          result.statusMessage ?? TransactionConstants.unknownError.tr);
      return false;
    } catch (e) {
      showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<CartItem>?> getCartItems(String token) async {
    try {
      final products = <CartItem>[];

      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.cartItem}',
              options: Options(
                method: 'GET',
                headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
              ));

      if (result.statusCode == 200 && result.data is List) {
        for (var element in (result.data as List)) {
          final product = CartItem.fromJson(element);
          products.add(product);
        }
      }
      return products;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteItem(
      {required String token, required String itemId}) async {
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.cartItem}/$itemId',
          options: Options(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
          ));

      if (result.statusCode == 200) {
        return result.data;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<List<EstimateShippingMethodsModel>> getEstimateShippingMethods(
      {required String token, required int addressId}) async {
    try {
      final methods = <EstimateShippingMethodsModel>[];

      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.cart}/estimate-shipping-methods-by-address-id',
          data: {"addressId": addressId},
          options: Options(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
          ));

      if (result.statusCode == 200 && result.data is List) {
        for (var element in (result.data as List)) {
          final method = EstimateShippingMethodsModel.fromJson(element);
          methods.add(method);
        }
      }
      return methods;
    } catch (e) {
      return [];
    }
  }
}
