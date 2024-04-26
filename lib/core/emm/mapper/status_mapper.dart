import 'package:task_tracker_flutter/core/emm/entity/status_entity.dart';
import 'package:task_tracker_flutter/core/emm/model/status_model.dart';

extension StatusMapperModel on StatusModel {
  StatusEntity toEntity() {
    return StatusEntity(idStatus: idStatus, title: title);
  }
}

extension StatusMapperEntity on StatusEntity {
  StatusModel toModel() {
    return StatusModel(idStatus: idStatus, title: title);
  }
}
