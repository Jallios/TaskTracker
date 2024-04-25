import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_flutter/core/emm/entity/user_entity.dart';
import 'package:task_tracker_flutter/core/error/failure.dart';
import 'package:task_tracker_flutter/features/auth/domain/usecase/auth_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.useCase) : super(AuthInitial());

  final AuthUseCase useCase;

  Future<void> signIn(UserEntity entity) async {
    emit(AuthLoad());
    final result = await useCase.signIn(entity);
    result.fold((l) {
      emit(AuthError(error: _mapFailureToMessage(l)));
    }, (r) {
      emit(AuthSuccess(message: r.data));
    });
  }

  Future<void> signUp(UserEntity entity) async {
    emit(AuthLoad());
    final result = await useCase.signUp(entity);
    result.fold((l) {
      emit(AuthError(error: _mapFailureToMessage(l)));
    }, (r) {
      emit(AuthSuccess(message: r.data));
    });
  }

  Future<void> emailSendCode(UserEntity entity) async {
    emit(AuthLoad());
    final result = await useCase.emailSendCode(entity);
    result.fold((l) {
      emit(AuthError(error: _mapFailureToMessage(l)));
    }, (r) {
      emit(AuthSuccess(message: r.data.toString()));
    });
  }

  Future<void> passwordReset(UserEntity entity) async {
    emit(AuthLoad());
    final result = await useCase.passwordReset(entity);
    result.fold((l) {
      emit(AuthError(error: _mapFailureToMessage(l)));
    }, (r) {
      emit(AuthSuccess(message: r.data.toString()));
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
