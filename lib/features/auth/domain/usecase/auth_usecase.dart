import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_tracker_flutter/core/emm/entity/user_entity.dart';
import 'package:task_tracker_flutter/core/error/failure.dart';
import 'package:task_tracker_flutter/features/auth/domain/repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<Either<Failure, Response>> signIn(UserEntity entity) async {
    try {
      return await repository.signIn(entity);
    } catch (_) {
      throw Exception();
    }
  }

  Future<Either<Failure, Response>> signUp(UserEntity entity) async {
    try {
      return await repository.signUp(entity);
    } catch (_) {
      throw Exception();
    }
  }

  Future<Either<Failure, Response>> emailSendCode(UserEntity entity) async {
    try {
      return await repository.emailSendCode(entity);
    } catch (_) {
      throw Exception();
    }
  }

  Future<Either<Failure, Response>> passwordReset(UserEntity entity) async {
    try {
      return await repository.passwordReset(entity);
    } catch (_) {
      throw Exception();
    }
  }
}
