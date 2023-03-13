import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:magento_app/common/config/network/network_config.dart';

import 'dio_interceptor.dart';

Dio dio = Dio(BaseOptions(
  connectTimeout: NetworkConfig.connectTimeout,
  receiveTimeout: NetworkConfig.responseTimeout,
  contentType: NetworkConfig.contentType,
  headers: {'Accept': 'application/json'},
  baseUrl: NetworkConfig.baseUrl,
))
  ..interceptors.add(logInterceptor)
  ..interceptors.add(DioInterceptor());

LogInterceptor logInterceptor = LogInterceptor(
  requestHeader: kDebugMode,
  requestBody: kDebugMode,
  responseBody: kDebugMode,
  responseHeader: false,
);
