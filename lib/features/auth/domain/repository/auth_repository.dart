import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_tracker_flutter/core/emm/entity/user_entity.dart';
import 'package:task_tracker_flutter/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Response>> signIn(UserEntity entity);
  Future<Either<Failure, Response>> signUp(UserEntity entity);
  Future<Either<Failure, Response>> emailSendCode(UserEntity entity);
  Future<Either<Failure, Response>> passwordReset(UserEntity entity);
  Future<void> refresh();
}
