import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tracker_flutter/core/network/api_entrypoints.dart';
import 'package:task_tracker_flutter/core/network/interceptore_app.dart';
import 'package:task_tracker_flutter/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:task_tracker_flutter/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_tracker_flutter/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:task_tracker_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:task_tracker_flutter/features/auth/domain/usecase/auth_usecase.dart';
import 'package:task_tracker_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task_tracker_flutter/features/project/data/data_sorce/project_local_data_source.dart';
import 'package:task_tracker_flutter/features/project/data/data_sorce/project_remote_data_source.dart';
import 'package:task_tracker_flutter/features/project/data/repository_impl/project_repository_impl.dart';
import 'package:task_tracker_flutter/features/project/domain/repository/project_repository.dart';
import 'package:task_tracker_flutter/features/project/domain/usecase/project_usecase.dart';
import 'package:task_tracker_flutter/features/project/presentation/cubit/project_cubit.dart';

final service = GetIt.instance;

Future<void> init() async {
  //Auth
  service.registerFactory(() => AuthCubit(service()));
  service.registerLazySingleton(() => AuthUseCase(service()));
  service
      .registerLazySingleton<AuthRemote>(() => AuthRemoteImpl(dio: service()));
  service.registerLazySingleton<AuthLocal>(() => AuthLocalImpl(service()));
  service.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remote: service(), local: service()));
  //Project
  service.registerFactory(() => ProjectCubit(service()));
  service.registerLazySingleton(() => ProjectUseCase(service()));
  service.registerLazySingleton<ProjectRemote>(
      () => ProjectRemoteImpl(dio: service()));
  service
      .registerLazySingleton<ProjectLocal>(() => ProjectLocalImpl(service()));
  service.registerLazySingleton<ProjectRepository>(
      () => ProjectRepositoryImpl(remote: service(), local: service()));

  //SharedPreferences
  final preferences = await SharedPreferences.getInstance();
  service.registerLazySingleton(() => preferences);
  //Dio
  service.registerLazySingleton(() {
    return Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
      ),
    )..interceptors.addAll(
        [
          InterceptorsApp(),
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
        ],
      );
  });
}
