import 'package:task_tracker_flutter/core/emm/entity/priority_entity.dart';
import 'package:task_tracker_flutter/core/emm/model/priority_model.dart';

extension PriorityMapperModel on PriorityModel {
  PriorityEntity toEntity() {
    return PriorityEntity(idPriority: idPriority, title: title);
  }
}

extension PriorityMapperEntity on PriorityEntity {
  PriorityModel toModel() {
    return PriorityModel(idPriority: idPriority, title: title);
  }
}
