import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:magento_app/common/config/network/api_exceptions.dart';
import 'package:magento_app/common/config/network/network_state.dart';
import 'package:magento_app/common/utils/logger.dart';

class ApiClient {
  // Base URL by flavor
  //static String baseUrl = Flavor.baseURL;
  // Default language
  static String defaultLang = 'en';
  // No internet message
  static String noInternetMsg = 'Không có kết nối Internet.';

  static Map<String, String> header = {
    //   'Content-Type': 'application/json; charset=utf-8',
    'Accept': '*/*'
  };

  static Future<dynamic> getRequest(String endpoint) async {
    if (!(await NetworkState.isConnected)) {
      throw FetchDataError(message: noInternetMsg);
    }

    final uri = Uri.parse(endpoint);

    try {
      _logRequest(url: uri, headers: header, params: '', type: 'GET');

      final result = http
          .get(
            uri,
            headers: header,
          )
          .then((value) => _handleResponse(value));

      return result;
    } on TimeoutException catch (_) {
      throw TimeOutError(
        code: _.message,
      );
    } on SocketException catch (_) {
      throw FetchDataError(
        message: noInternetMsg,
        code: _.message,
      );
    }
  }

  static Future<dynamic> postRequest(
    String endpoint, {
    required dynamic params,
  }) async {
    if (!(await NetworkState.isConnected)) {
      throw FetchDataError(message: noInternetMsg);
    }

    final uri = Uri.parse(endpoint);

    try {
      _logRequest(
        url: uri,
        headers: header,
        params: params,
        type: 'POST',
      );

      final result = http
          .post(
            uri,
            headers: header,
            body: json.encode(params),
          )
          .then((value) => _handleResponse(value));

      return result;
    } on TimeoutException catch (_) {
      throw TimeOutError(
        code: _.message,
      );
    } on SocketException catch (_) {
      throw FetchDataError(
        message: noInternetMsg,
        code: _.message,
      );
    }
  }

  static dynamic _handleError(dynamic onError) {
    logger.e(
      onError.toString(),
      'Error',
    );

    if (onError is TimeoutException) {
      logger.e('Timeout');
    } else if (onError is SocketException) {
      logger.e('Socket');
    }
  }

  static dynamic _handleResponse(
    http.Response response, {
    bool isLogResponse = true,
  }) async {
    final statusCode = response.statusCode;
    debugPrint('===============${response.body}');
    final url = response.request?.url.toString();
    var message = 'Đã có lỗi xảy ra';

    if (statusCode == 500) {
      throw InternalServerError(
        code: 500,
        message: message,
        success: false,
      );
    }

    logger.v(
      isLogResponse ? json.decode(response.body) : 'No log',
      'Response │ Status: $statusCode\n$url',
    );

    final code = json.decode(response.body)['code'] == null
        ? json.decode(response.body)['statusCode']
        : json.decode(response.body)['code'];
    message = json.decode(response.body)['message'].toString();
    // final success = json.decode(response.body)['success'];

    switch (code) {
      case 200:
        return json.decode(utf8.decode(response.bodyBytes))['data'];
      case 400:
        throw BadRequestError(
          code: code,
          message: message,
          //success: success,
        );
      case 401:
        throw WrongPasswordError(code: code, message: 'Đăng nhập thất bại');
      case 403:
        //await Utils.handleUnauthorizedError(indexTabbar);
        throw UnauthorizedError(
          code: code,
          message: message,
          //success: success,
        );
      case 404:
        throw NotFoundError(
          code: 404,
          message: message,
          // success: success,
        );
      case 500:
        throw InternalServerError(
          code: 500,
          message: message,
          // success: success,
        );
      default:
        throw FetchDataError(
          code: code,
          message: message,
          // success: success,
        );
    }
  }

  static dynamic _logRequest({
    required dynamic url,
    required dynamic headers,
    required dynamic params,
    required dynamic type,
  }) {
    logger
      ..i(
        url,
        'Request │ $type',
      )
      ..i(headers, 'Headers')
      ..i(params, 'Request Parameters');
  }
}
