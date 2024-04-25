import 'package:task_tracker_flutter/core/emm/model/project_model.dart';
import 'package:task_tracker_flutter/core/emm/model/role_model.dart';
import 'package:task_tracker_flutter/core/emm/model/user_model.dart';

class ProjectUserRoleModel {
  int? idProjectUser;
  int? roleId;
  int? userId;
  int? projectId;
  ProjectModel? project;
  RoleModel? role;
  UserModel? user;

  ProjectUserRoleModel(
      {this.idProjectUser,
      this.roleId,
      this.userId,
      this.projectId,
      this.project,
      this.role,
      this.user});

  factory ProjectUserRoleModel.fromJson(Map<String, dynamic> json) {
    return ProjectUserRoleModel(
      idProjectUser: json['idProjectUser'],
      roleId: json['roleId'],
      userId: json['userId'],
      projectId: json['projectId'],
      project: json['project'] != null
          ? ProjectModel.fromJson(json['project'])
          : null,
      role: json['role'] != null ? RoleModel.fromJson(json['role']) : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idProjectUser': idProjectUser,
      'roleId': roleId,
      'userId': userId,
      'projectId': projectId,
      'project': project?.toJson(),
      'role': role?.toJson(),
      'user': user?.toJson()
    };
  }
}
