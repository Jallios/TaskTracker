import 'package:task_tracker_flutter/core/emm/entity/project_entity.dart';
import 'package:task_tracker_flutter/core/emm/model/project_model.dart';

extension ProjectMapperModel on ProjectModel {
  ProjectEntity toEntity() {
    return ProjectEntity(
        idProject: idProject,
        title: title,
        publish: publish,
        deadline: deadline);
  }
}

extension ProjectMapperEntity on ProjectEntity {
  ProjectModel toModel() {
    return ProjectModel(
        idProject: idProject,
        title: title,
        publish: publish,
        deadline: deadline);
  }
}
