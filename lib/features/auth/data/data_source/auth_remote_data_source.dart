import 'package:dio/dio.dart';
import 'package:task_tracker_flutter/core/emm/model/user_model.dart';
import 'package:task_tracker_flutter/core/error/exeption.dart';
import 'package:task_tracker_flutter/core/network/api_entrypoints.dart';

abstract interface class AuthRemote {
  Future<Response> signIn(UserModel model);
  Future<Response> signUp(UserModel model);
  Future<Response> emailSendCode(UserModel model);
  Future<Response> passwordReset(UserModel model);
  Future<Response> refresh();
  Future fetch(RequestOptions options);
}

class AuthRemoteImpl implements AuthRemote {
  final Dio dio;

  AuthRemoteImpl({required this.dio});

  @override
  Future fetch(RequestOptions options) {
    try {
      return dio.fetch(options);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> refresh() async {
    try {
      final response = await dio.post(ApiEndpoints.refresh, data: {});
      return response;
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future<Response> signIn(UserModel model) async {
    try {
      final response =
          await dio.post(ApiEndpoints.signIn, data: model.toJson());
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw UserExeption(message: e.response?.data);
      } else {
        throw ServerExeption();
      }
    }
  }

  @override
  Future<Response> signUp(UserModel model) async {
    try {
      final response =
          await dio.post(ApiEndpoints.signUp, data: model.toJson());
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw UserExeption(message: e.response?.data);
      } else {
        throw ServerExeption();
      }
    }
  }

  @override
  Future<Response> emailSendCode(UserModel model) async {
    try {
      final response =
          await dio.post(ApiEndpoints.emailSendCode, data: model.toJson());
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw UserExeption(message: e.response?.data);
      } else {
        throw ServerExeption();
      }
    }
  }

  @override
  Future<Response> passwordReset(UserModel model) async {
    try {
      final response =
          await dio.post(ApiEndpoints.passwordReset, data: model.toJson());
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw UserExeption(message: e.response?.data);
      } else {
        throw ServerExeption();
      }
    }
  }
}
