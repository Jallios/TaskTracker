import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_tracker_flutter/core/emm/entity/projectUserRole_entity.dart';
import 'package:task_tracker_flutter/core/emm/entity/project_entity.dart';
import 'package:task_tracker_flutter/core/error/failure.dart';
import 'package:task_tracker_flutter/features/project/domain/repository/project_repository.dart';

class ProjectUseCase {
  final ProjectRepository repository;

  ProjectUseCase(this.repository);

  Future<Either<Failure, List<ProjectUserRoleEntity>>> getProjectsUser() async {
    try {
      return await repository.getProjectsUser();
    } catch (_) {
      throw Exception();
    }
  }

  Future<Either<Failure, Response>> addProjectUserRole(
      ProjectUserRoleEntity entity) async {
    try {
      return await repository.addProjectUserRole(entity);
    } catch (_) {
      throw Exception();
    }
  }

  Future<Either<Failure, Response>> deleteProjectUserRole(int id) async {
    try {
      return await repository.deleteProjectUserRole(id);
    } catch (_) {
      throw Exception();
    }
  }

  Future<Either<Failure, ProjectEntity>> getProjectUserRoleById(int id) async {
    try {
      return await repository.getProjectUserRoleById(id);
    } catch (_) {
      throw Exception();
    }
  }
}
