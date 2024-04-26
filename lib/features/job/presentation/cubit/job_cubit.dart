import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_flutter/core/emm/entity/job_entity.dart';
import 'package:task_tracker_flutter/features/job/domain/usecase/job_usecase.dart';

part 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  JobCubit(this.useCase) : super(JobInitial());

  final JobUseCase useCase;
}
