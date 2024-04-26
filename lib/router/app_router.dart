import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_flutter/core/emm/entity/project_entity.dart';
import 'package:task_tracker_flutter/di/service.dart';
import 'package:task_tracker_flutter/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:task_tracker_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task_tracker_flutter/features/auth/presentation/ui/passwordReset.dart';
import 'package:task_tracker_flutter/features/auth/presentation/ui/sendCode.dart';
import 'package:task_tracker_flutter/features/auth/presentation/ui/signIn.dart';
import 'package:task_tracker_flutter/features/auth/presentation/ui/signUp.dart';
import 'package:task_tracker_flutter/features/project/presentation/cubit/project_cubit.dart';
import 'package:task_tracker_flutter/features/project/presentation/ui/add_project.dart';
import 'package:task_tracker_flutter/features/project/presentation/ui/projects.dart';
import 'package:task_tracker_flutter/features/project/presentation/ui/update_project.dart';
import 'package:task_tracker_flutter/router/router_utils.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Pages.signIn.screenPath,
        name: Pages.signIn.screenName,
        redirect: (context, state) {
          if (service<AuthLocal>().isUserSignIn()) {
            return Pages.projects.screenPath;
          }
          return null;
        },
        builder: (context, state) => BlocProvider(
          create: (context) => service<AuthCubit>(),
          child: const SignIn(),
        ),
        routes: [
          GoRoute(
            path: Pages.signUp.screenPath,
            name: Pages.signUp.screenName,
            builder: (context, state) => BlocProvider(
              create: (context) => service<AuthCubit>(),
              child: const SignUp(),
            ),
          ),
          GoRoute(
            path: Pages.sendCode.screenPath,
            name: Pages.sendCode.screenName,
            builder: (context, state) => BlocProvider(
              create: (context) => service<AuthCubit>(),
              child: const SendCode(),
            ),
            routes: [
              GoRoute(
                path: Pages.passwordReset.screenPath,
                name: Pages.passwordReset.screenName,
                builder: (context, state) => BlocProvider(
                  create: (context) => service<AuthCubit>(),
                  child: PasswordReset(
                    code: state.uri.queryParameters['code'],
                    email: state.uri.queryParameters['email'],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
          path: Pages.projects.screenPath,
          name: Pages.projects.screenName,
          builder: (context, state) => BlocProvider(
                create: (context) => service<ProjectCubit>()..getProjectsUser(),
                child: const Projects(),
              ),
          routes: [
            GoRoute(
              path: Pages.addProject.screenPath,
              name: Pages.addProject.screenName,
              builder: (context, state) => BlocProvider(
                create: (context) => service<ProjectCubit>(),
                child: const AddProject(),
              ),
            ),
            GoRoute(
              path: Pages.updateProject.screenPath,
              name: Pages.updateProject.screenName,
              builder: (context, state) => BlocProvider(
                create: (context) => service<ProjectCubit>(),
                child: UpdateProject(entity: state.extra as ProjectEntity),
              ),
            ),
          ]),
    ],
  );
}
