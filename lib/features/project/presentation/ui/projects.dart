import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker_flutter/features/project/presentation/cubit/project_cubit.dart';
import 'package:task_tracker_flutter/router/app_router.dart';
import 'package:task_tracker_flutter/router/router_utils.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      context.read<ProjectCubit>().getProjectsUser();
    });
  }

  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Projects"), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    search = value.toLowerCase();
                  });
                },
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ProjectCubit, ProjectState>(
                builder: (context, state) {
                  return switch (state) {
                    ProjectSuccess(:final entities) => ListView.builder(
                        itemCount: entities!.length,
                        itemBuilder: (context, index) {
                          return entities[index]
                                  .project!
                                  .title!
                                  .toLowerCase()
                                  .contains(search)
                              ? Card(
                                  child: ListTile(
                                    title: Text(
                                        '${entities[index].project!.title}'),
                                    subtitle: Text(
                                        'Deadline: ${entities[index].project?.deadline == null ? "No deadline" : DateFormat("yyyy-MM-dd – kk:mm").format(entities[index].project!.deadline!)}'),
                                    trailing: Builder(
                                      builder: (context) {
                                        if (entities[index].roleId == 1) {
                                          return IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                AppRouter.router.pushNamed(
                                                    Pages.updateProject.screenName,
                                                    extra: entities[index]
                                                        .project);
                                              });
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      },
                                    ),
                                    onTap: () {},
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (_) => AlertDialog(
                                          title: Text("Are you sure?"),
                                          content: Text(
                                              "Delete project ${entities[index].project!.title}"),
                                          actions: [
                                            TextButton(
                                              child: Text("Yes"),
                                              onPressed: () {
                                                context
                                                    .read<ProjectCubit>()
                                                    .deleteProjectUserRole(
                                                        entities[index]
                                                            .project!
                                                            .idProject!);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text("No"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ),
                                      ).then((_) => setState(() {
                                            _refresh();
                                          }));
                                    },
                                  ),
                                )
                              : Container();
                        },
                      ),
                    ProjectError(:final error) => Center(child: Text('$error')),
                    _ => const Center(child: CircularProgressIndicator())
                  };
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.router.pushNamed(Pages.addProject.screenName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
