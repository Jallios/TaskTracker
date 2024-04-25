import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_tracker_flutter/core/emm/entity/projectUserRole_entity.dart';
import 'package:task_tracker_flutter/core/emm/entity/project_entity.dart';
import 'package:task_tracker_flutter/core/emm/mapper/projectUserRole_mapper.dart';
import 'package:task_tracker_flutter/core/emm/mapper/project_mapper.dart';
import 'package:task_tracker_flutter/core/error/exeption.dart';
import 'package:task_tracker_flutter/core/error/failure.dart';
import 'package:task_tracker_flutter/features/project/data/data_sorce/project_local_data_source.dart';
import 'package:task_tracker_flutter/features/project/data/data_sorce/project_remote_data_source.dart';
import 'package:task_tracker_flutter/features/project/domain/repository/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemote remote;
  final ProjectLocal local;

  ProjectRepositoryImpl({required this.remote, required this.local});

  @override
  Future<Either<Failure, List<ProjectUserRoleEntity>>> getProjectsUser() async {
    try {
      final result = await remote.getProjectsUser();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerExeption {
      return Left(ServerFailure());
    } on UserExeption catch (e) {
      return Left(UserFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Response>> addProjectUserRole(
      ProjectUserRoleEntity entity) async {
    try {
      final result = await remote.addProjectUserRole(entity.toModel());
      return Right(result);
    } on ServerExeption {
      return Left(ServerFailure());
    } on UserExeption catch (e) {
      return Left(UserFailure(message: e.message));
    }
  }
  
  @override
  Future<Either<Failure, Response>> deleteProjectUserRole(int id) async {
    try {
      final result = await remote.deleteProjectUserRole(id);
      return Right(result);
    } on ServerExeption {
      return Left(ServerFailure());
    } on UserExeption catch (e) {
      return Left(UserFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> getProjectUserRoleById(int id) async{
    try {
      final result = await remote.getProjectUserRoleById(id);
      return Right(result.toEntity());
    } on ServerExeption {
      return Left(ServerFailure());
    } on UserExeption catch (e) {
      return Left(UserFailure(message: e.message));
    }
  }
}
