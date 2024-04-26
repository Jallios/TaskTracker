import 'package:task_tracker_flutter/core/emm/model/priority_model.dart';
import 'package:task_tracker_flutter/core/emm/model/project_model.dart';
import 'package:task_tracker_flutter/core/emm/model/status_model.dart';
import 'package:task_tracker_flutter/core/emm/model/user_model.dart';

class JobModel {
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
  UserModel? createdUser;
  UserModel? executorUser;
  PriorityModel? priority;
  ProjectModel? project;
  StatusModel? status;

  JobModel(
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

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
        idJob: json['idJob'],
        title: json['title'],
        description: json['description'],
        publish:
            json['publish'] != null ? DateTime.tryParse(json['publish']) : null,
        deadline: json['deadline'] != null
            ? DateTime.tryParse(json['publish'])
            : null,
        createdUserId: json['createdUserId'],
        executorUserId: json['executorUserId'],
        projectId: json['projectId'],
        priorityId: json['priorityId'],
        statusId: json['statusId'],
        createdUser: json['createdUser'] != null
            ? UserModel.fromJson(json['createdUser'])
            : null,
        executorUser: json['executorUser'] != null
            ? UserModel.fromJson(json['executorUser'])
            : null,
        priority: json['priority'] != null
            ? PriorityModel.fromJson(json['priority'])
            : null,
        project: json['project'] != null
            ? ProjectModel.fromJson(json['project'])
            : null,
        status: json['status'] != null
            ? StatusModel.fromJson(json['status'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'idJob': idJob,
      'title': title,
      'description': description,
      'publish': publish?.toIso8601String(),
      'deadline': deadline?.toIso8601String(),
      'createdUserId': createdUserId,
      'executorUserId': executorUserId,
      'projectId': projectId,
      'priorityId': priorityId,
      'statusId': statusId,
      'createdUser': createdUser?.toJson(),
      'executorUser': executorUser?.toJson(),
      'priority': priority?.toJson(),
      'project': project?.toJson(),
      'status': status?.toJson()
    };
  }
}
