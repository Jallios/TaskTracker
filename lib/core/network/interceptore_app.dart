import 'package:dio/dio.dart';
import 'package:task_tracker_flutter/di/service.dart';
import 'package:task_tracker_flutter/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:task_tracker_flutter/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_tracker_flutter/features/auth/domain/repository/auth_repository.dart';

class InterceptorsApp extends QueuedInterceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Authorization'] =
        "Bearer ${service<AuthLocal>().getToken()}";
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      try {
        await service<AuthRepository>().refresh();
        final response = await service<AuthRemote>().fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        super.onError(err, handler);
      }
    } else {
      super.onError(err, handler);
    }
  }
}
