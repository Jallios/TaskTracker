import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_flutter/core/emm/entity/projectUserRole_entity.dart';
import 'package:task_tracker_flutter/core/emm/entity/project_entity.dart';
import 'package:task_tracker_flutter/core/error/failure.dart';
import 'package:task_tracker_flutter/features/project/domain/usecase/project_usecase.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit(this.useCase) : super(ProjectInitial());

  final ProjectUseCase useCase;

  Future<void> getProjectsUser() async {
    emit(ProjectLoad());
    final result = await useCase.getProjectsUser();
    result.fold((l) {
      emit(ProjectError(error: _mapFailureToMessage(l)));
    }, (r) {
      emit(ProjectSuccess(entities: r, entity: ProjectEntity()));
    });
  }

  Future<void> addProjectUserRole(ProjectUserRoleEntity entity) async {
    emit(ProjectLoad());
    final result = await useCase.addProjectUserRole(entity);
    result.fold((l) {
      emit(ProjectError(error: _mapFailureToMessage(l)));
    }, (r) {
      emit(ProjectSuccess(entities: List.empty(), entity: ProjectEntity()));
    });
  }

  Future<void> deleteProjectUserRole(int id) async {
    emit(ProjectLoad());
    final result = await useCase.deleteProjectUserRole(id);
    result.fold((l) {
      emit(ProjectError(error: _mapFailureToMessage(l)));
    }, (r) {
      emit(ProjectSuccess(entities: List.empty(), entity: ProjectEntity()));
    });
  }

  Future<void> getProjectUserRoleById(int id) async {
    emit(ProjectLoad());
    final result = await useCase.getProjectUserRoleById(id);
    result.fold((l) {
      emit(ProjectError(error: _mapFailureToMessage(l)));
    }, (r) {
      emit(ProjectSuccess(entities: List.empty(), entity: r));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    return switch (failure) {
      ServerFailure() => "Server error, try again later",
      UserFailure(:final message) => message,
      _ => "Unexpected Error"
    };
  }
}
