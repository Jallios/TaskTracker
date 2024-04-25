import 'package:task_tracker_flutter/core/emm/entity/project_entity.dart';
import 'package:task_tracker_flutter/core/emm/entity/role_entity.dart';
import 'package:task_tracker_flutter/core/emm/entity/user_entity.dart';

class ProjectUserRoleEntity {
  int? idProjectUser;
  int? roleId;
  int? userId;
  int? projectId;
  ProjectEntity? project;
  RoleEntity? role;
  UserEntity? user;

  ProjectUserRoleEntity(
      {this.idProjectUser,
      this.roleId,
      this.userId,
      this.projectId,
      this.project,
      this.role,
      this.user});
}
