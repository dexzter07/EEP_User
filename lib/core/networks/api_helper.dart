import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dio_client.dart';

final apiHelperProvider = Provider<ApiHelper>((ref) => ApiHelper(ref));

class ApiHelper {
  final Ref _ref;

  ApiHelper(this._ref);

  Dio get _dio => _ref.read(dioProvider);

  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParams,
  }) async {
    return await _dio.get(endPoint, queryParameters: queryParams);
  }

  Future<Response> post({
    required String endPoint,
    Map<String, dynamic>? queryParams,
    dynamic data,
    Options? options,
    bool? isDelete,
    bool? isPut,
  }) async {
    return isDelete == true
        ? await _dio.delete(
            options: options,
            endPoint,
            queryParameters: queryParams,
            data: data,
          )
        : isPut == true
            ? await _dio.put(
                options: options,
                endPoint,
                queryParameters: queryParams,
                data: data,
              )
            : await _dio.post(
                options: options,
                endPoint,
                queryParameters: queryParams,
                data: data,
              );
  }
}
