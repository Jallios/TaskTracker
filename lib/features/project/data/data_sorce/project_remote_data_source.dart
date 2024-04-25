import 'package:dio/dio.dart';
import 'package:task_tracker_flutter/core/emm/model/projectUserRole_model.dart';
import 'package:task_tracker_flutter/core/emm/model/project_model.dart';
import 'package:task_tracker_flutter/core/error/exeption.dart';
import 'package:task_tracker_flutter/core/network/api_entrypoints.dart';

abstract interface class ProjectRemote {
  Future<List<ProjectUserRoleModel>> getProjectsUser();
  Future<Response> addProjectUserRole(ProjectUserRoleModel model);
  Future<Response> deleteProjectUserRole(int id);
  Future<ProjectModel> getProjectUserRoleById(int id);
  Future<Response> updateProjectUserRole(int id, ProjectModel model);
}

class ProjectRemoteImpl implements ProjectRemote {
  final Dio dio;

  ProjectRemoteImpl({required this.dio});

  @override
  Future<List<ProjectUserRoleModel>> getProjectsUser() async {
    try {
      final response = await dio.get(ApiEndpoints.projectUserRoles);
      return (response.data as List)
          .map((e) => ProjectUserRoleModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw UserExeption(message: e.response?.data);
      } else {
        throw ServerExeption();
      }
    }
  }

  @override
  Future<Response> addProjectUserRole(ProjectUserRoleModel model) async {
    try {
      final response =
          await dio.post(ApiEndpoints.projectUserRoles, data: model.toJson());
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
  Future<Response> deleteProjectUserRole(int id) async{
    try {
      final response =
          await dio.delete("${ApiEndpoints.projects}/$id");
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
  Future<ProjectModel> getProjectUserRoleById(int id) async{
    try {
      final response =
          await dio.get("${ApiEndpoints.projects}/$id");
      return ProjectModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw UserExeption(message: e.response?.data);
      } else {
        throw ServerExeption();
      }
    }
  }
  
  @override
  Future<Response> updateProjectUserRole(int id, ProjectModel model) {
    // TODO: implement updateProjectUserRole
    throw UnimplementedError();
  }
}
