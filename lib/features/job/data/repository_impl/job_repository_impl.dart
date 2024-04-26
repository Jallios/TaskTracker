import 'package:task_tracker_flutter/features/job/data/data_source/job_local_data_source.dart';
import 'package:task_tracker_flutter/features/job/data/data_source/job_remote_data_source.dart';
import 'package:task_tracker_flutter/features/job/domain/repository/job_repository.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemote remote;
  final JobLocal local;

  JobRepositoryImpl({required this.remote, required this.local});
}
