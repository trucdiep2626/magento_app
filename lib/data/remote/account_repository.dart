import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/config/network/api_endpoints.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/common/utils/translations/app_translations.dart';
import 'package:magento_app/domain/models/customer_model.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class AccountRepository {
  final Dio _dio;

  AccountRepository(this._dio);

  Future<String?> login({
    required String username,
    required String password,
  }) async {
    final params = {
      'username': username,
      'password': password,
    };
    try {
      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.login}',
              data: params,
              options: Options(
                method: 'POST',
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

  Future<CustomerModel?> getCustomerInfor(String token) async {
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.getCustomerInfor}',
          options: Options(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
          ));
      if (result.statusCode == 200) {
        return CustomerModel.fromJson(result.data);
      }
      showTopSnackBarError(Get.context!,
          result.statusMessage ?? TransactionConstants.unknownError.tr);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      return null;
    }
  }

  Future<bool> register({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final params = {
      "customer": {
        "email": username,
        "firstname": firstName,
        "lastname": lastName
      },
      "password": password
    };
    try {
      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.customer}',
              data: params,
              options: Options(
                method: 'POST',
              ));
      if (result.statusCode == 200) {
        return true;
      }
      showTopSnackBarError(Get.context!,
          result.statusMessage ?? TransactionConstants.unknownError.tr);
      return false;
    } catch (e) {
      debugPrint(e.toString());
      showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      return false;
    }
  }

  Future<CustomerModel?> updateCustomer(
      {required CustomerModel customer}) async {
    final params = {
      "customer": {...customer.toUpdateCustomer()},
    };
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.customer}/${customer.id ?? 0}',
          data: params,
          options: Options(
            method: 'PUT',
            headers: <String, dynamic>{
              r'Authorization': '${NetworkConfig.token}'
            },
          ));
      if (result.statusCode == 200) {
        return CustomerModel.fromJson(result.data);
      }
      showTopSnackBarError(Get.context!,
          result.statusMessage ?? TransactionConstants.unknownError.tr);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      return null;
    }
  }

  Future<bool> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) async {
    final params = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    };
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.changePassword}',
          data: params,
          options: Options(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
          ));
      if (result.statusCode == 200) {
        return true;
      }
      showTopSnackBarError(Get.context!,
          result.statusMessage ?? TransactionConstants.unknownError.tr);
      return false;
    } catch (e) {
      debugPrint(e.toString());
      showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      return false;
    }
  }
}
