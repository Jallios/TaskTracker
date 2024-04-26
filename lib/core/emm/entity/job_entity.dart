import 'package:task_tracker_flutter/core/emm/entity/priority_entity.dart';
import 'package:task_tracker_flutter/core/emm/entity/project_entity.dart';
import 'package:task_tracker_flutter/core/emm/entity/status_entity.dart';
import 'package:task_tracker_flutter/core/emm/entity/user_entity.dart';

class JobEntity {
  int? idJob;
  String? title;
  String? description;
  DateTime? publish;
  DateTime? deadline;
  int? createdUserId;
  int? executorUserId;
  int? projectId;
  int? priorityId;
  int? statusId;
  UserEntity? createdUser;
  UserEntity? executorUser;
  PriorityEntity? priority;
  ProjectEntity? project;
  StatusEntity? status;

  JobEntity(
      {this.idJob,
      this.title,
      this.description,
      this.publish,
      this.deadline,
      this.createdUserId,
      this.executorUserId,
      this.projectId,
      this.priorityId,
      this.statusId,
      this.createdUser,
      this.executorUser,
      this.priority,
      this.project,
      this.status});
}
