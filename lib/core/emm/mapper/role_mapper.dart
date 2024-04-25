import 'package:task_tracker_flutter/core/emm/entity/role_entity.dart';
import 'package:task_tracker_flutter/core/emm/model/role_model.dart';

extension RoleMapperModel on RoleModel {
  RoleEntity toEntity() {
    return RoleEntity(idRole: idRole, title: title);
  }
}

extension UserMapperEntity on RoleEntity {
  RoleModel toModel() {
    return RoleModel(idRole: idRole, title: title);
  }
}
