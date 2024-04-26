part of 'job_cubit.dart';

sealed class JobState {}

final class JobInitial extends JobState {}

final class JobLoad extends JobState {}

final class JobError extends JobState {
  final String? error;

  JobError({required this.error});
}

final class JobSuccess extends JobState {
  final List<JobEntity>? entities;
  
  JobSuccess({required this.entities});
}