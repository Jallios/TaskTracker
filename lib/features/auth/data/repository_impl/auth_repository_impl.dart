import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_tracker_flutter/core/emm/entity/user_entity.dart';
import 'package:task_tracker_flutter/core/emm/mapper/user_mapper.dart';
import 'package:task_tracker_flutter/core/error/exeption.dart';
import 'package:task_tracker_flutter/core/error/failure.dart';
import 'package:task_tracker_flutter/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:task_tracker_flutter/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_tracker_flutter/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemote remote;
  final AuthLocal local;

  AuthRepositoryImpl({required this.remote, required this.local});

  @override
  Future<void> refresh() async {
    try {
      final result = await remote.refresh();
      local.setToken(result.data);
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future<Either<Failure, Response>> signIn(UserEntity entity) async {
    try {
      final result = await remote.signIn(entity.toModel());
      local.setToken(result.data);
      return Right(result);
    } on ServerExeption {
      return Left(ServerFailure());
    } on UserExeption catch (e) {
      return Left(UserFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Response>> signUp(UserEntity entity) async {
    try {
      final result = await remote.signUp(entity.toModel());
      return Right(result);
    } on ServerExeption {
      return Left(ServerFailure());
    } on UserExeption catch (e) {
      return Left(UserFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Response>> emailSendCode(UserEntity entity) async {
    try {
      final result = await remote.emailSendCode(entity.toModel());
      return Right(result);
    } on ServerExeption {
      return Left(ServerFailure());
    } on UserExeption catch (e) {
      return Left(UserFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Response>> passwordReset(UserEntity entity) async {
    try {
      final result = await remote.passwordReset(entity.toModel());
      return Right(result);
    } on ServerExeption {
      return Left(ServerFailure());
    } on UserExeption catch (e) {
      return Left(UserFailure(message: e.message));
    }
  }
}
