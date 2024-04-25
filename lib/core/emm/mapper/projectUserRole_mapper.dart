import 'package:task_tracker_flutter/core/emm/entity/projectUserRole_entity.dart';
import 'package:task_tracker_flutter/core/emm/mapper/project_mapper.dart';
import 'package:task_tracker_flutter/core/emm/mapper/role_mapper.dart';
import 'package:task_tracker_flutter/core/emm/mapper/user_mapper.dart';
import 'package:task_tracker_flutter/core/emm/model/projectUserRole_model.dart';

extension ProjectUserRoleMapperModel on ProjectUserRoleModel {
  ProjectUserRoleEntity toEntity() {
    return ProjectUserRoleEntity(
        idProjectUser: idProjectUser,
        roleId: roleId,
        userId: userId,
        projectId: projectId,
        project: project?.toEntity(),
        role: role?.toEntity(),
        user: user?.toEntity());
  }
}

extension ProjectMapperEntity on ProjectUserRoleEntity {
  ProjectUserRoleModel toModel() {
    return ProjectUserRoleModel(
        idProjectUser: idProjectUser,
        roleId: roleId,
        userId: userId,
        projectId: projectId,
        project: project?.toModel(),
        role: role?.toModel(),
        user: user?.toModel());
  }
}
