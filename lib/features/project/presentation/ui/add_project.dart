import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker_flutter/core/emm/entity/project_entity.dart';
import 'package:task_tracker_flutter/features/project/presentation/cubit/project_cubit.dart';
import 'package:task_tracker_flutter/features/project/presentation/widget/pickedDateTime.dart';
import 'package:task_tracker_flutter/router/app_router.dart';
import 'package:task_tracker_flutter/router/router_utils.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _publishController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  DateTime? dateTimePublish;

  DateTime? dateTimeDeadline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add project"),
        centerTitle: true,
      ),
      body: Form(
        key: _keyForm,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                textAlign: TextAlign.center,
                readOnly: true,
                controller: _publishController,
                onTap: () async {
                  dateTimePublish = await pickDateTime(context);
                  _publishController.text = DateFormat('dd/MM/yyyy - HH:mm')
                      .format(dateTimePublish ?? DateTime.now());
                },
                decoration: const InputDecoration(
                  label: Text('Publish'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: _deadlineController,
                readOnly: true,
                onTap: () async {
                  dateTimeDeadline = await pickDateTime(context);
                  _deadlineController.text = DateFormat('dd/MM/yyyy - HH:mm')
                      .format(dateTimeDeadline ?? DateTime.now());
                },
                decoration: const InputDecoration(
                  label: Text('Deadline'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocConsumer<ProjectCubit, ProjectState>(
              listener: (context, state) {
                if (state is ProjectSuccess) {
                  AppRouter.router
                      .pushReplacementNamed(Pages.projects.screenName);
                }
                if (state is ProjectError) {
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(content: Text("${state.error}"), actions: [
                      IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .hideCurrentMaterialBanner();
                          },
                          icon: const Icon(Icons.clear))
                    ]),
                  );
                }
              },
              builder: (context, state) {
                return switch (state) {
                  ProjectLoad() => LinearProgressIndicator(),
                  _ => FilledButton(
                      onPressed: () {
                        if (!_keyForm.currentState!.validate()) return;
                        context.read<ProjectCubit>().addProjectUserRole(
                            ProjectEntity(
                                title: _titleController.text,
                                deadline: dateTimeDeadline,
                                publish: dateTimePublish));
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Confrim",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                };
              },
            ),
          )
        ]),
      ),
    );
  }
}
