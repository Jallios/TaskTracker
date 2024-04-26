part of 'project_cubit.dart';

sealed class ProjectState {}

final class ProjectInitial extends ProjectState {}

final class ProjectLoad extends ProjectState {}

final class ProjectError extends ProjectState {
  final String? error;

  ProjectError({required this.error});
}

final class ProjectSuccess extends ProjectState {
  final List<ProjectUserRoleEntity>? entities;
  
  ProjectSuccess({required this.entities});
}
