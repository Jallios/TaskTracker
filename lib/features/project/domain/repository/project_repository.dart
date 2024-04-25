import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_tracker_flutter/core/emm/entity/projectUserRole_entity.dart';
import 'package:task_tracker_flutter/core/emm/entity/project_entity.dart';
import 'package:task_tracker_flutter/core/error/failure.dart';

abstract interface class ProjectRepository {
  Future<Either<Failure, List<ProjectUserRoleEntity>>> getProjectsUser();
  Future<Either<Failure, Response>> addProjectUserRole(
      ProjectUserRoleEntity entity);

  Future<Either<Failure, Response>> deleteProjectUserRole(int id);

  Future<Either<Failure, ProjectEntity>> getProjectUserRoleById(int id);
}
