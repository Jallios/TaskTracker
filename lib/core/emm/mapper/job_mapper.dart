import 'package:task_tracker_flutter/core/emm/entity/job_entity.dart';
import 'package:task_tracker_flutter/core/emm/mapper/priority_mapper.dart';
import 'package:task_tracker_flutter/core/emm/mapper/project_mapper.dart';
import 'package:task_tracker_flutter/core/emm/mapper/status_mapper.dart';
import 'package:task_tracker_flutter/core/emm/mapper/user_mapper.dart';
import 'package:task_tracker_flutter/core/emm/model/job_model.dart';

extension JobMapperModel on JobModel {
  JobEntity toEntity() {
    return JobEntity(
        idJob: idJob,
        title: title,
        description: description,
        publish: publish,
        deadline: deadline,
        createdUserId: createdUserId,
        executorUserId: executorUserId,
        projectId: projectId,
        priorityId: priorityId,
        statusId: statusId,
        createdUser: createdUser?.toEntity(),
        executorUser: executorUser?.toEntity(),
        priority: priority?.toEntity(),
        project: project?.toEntity(),
        status: status?.toEntity());
  }
}

extension JobMapperEntity on JobEntity {
  JobModel toModel() {
    return JobModel(
        idJob: idJob,
        title: title,
        description: description,
        publish: publish,
        deadline: deadline,
        createdUserId: createdUserId,
        executorUserId: executorUserId,
        projectId: projectId,
        priorityId: priorityId,
        statusId: statusId,
        createdUser: createdUser?.toModel(),
        executorUser: executorUser?.toModel(),
        priority: priority?.toModel(),
        project: project?.toModel(),
        status: status?.toModel());
  }
}
