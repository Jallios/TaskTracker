import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker_flutter/features/project/presentation/cubit/project_cubit.dart';
import 'package:task_tracker_flutter/router/app_router.dart';
import 'package:task_tracker_flutter/router/router_utils.dart';

class EditProject extends StatefulWidget {

  const EditProject({super.key});

  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  DateTime? pickedDate = DateTime.now();
  TimeOfDay? pickedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Project"), centerTitle: true),
      body: Form(
          key: _keyForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  controller: _deadlineController,
                  onTap: () async {
                    pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    pickedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (pickedDate == null) return;
                    if (pickedTime == null) return;
                    pickedDate = DateTime(pickedDate!.year, pickedDate!.month,
                        pickedDate!.day, pickedTime!.hour, pickedTime!.minute);
                    _deadlineController.text =
                        DateFormat("yyyy-MM-dd – kk:mm").format(pickedDate!);
                  },
                  decoration: const InputDecoration(
                    label: Text('Deadline'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              BlocConsumer<ProjectCubit, ProjectState>(
                listener: (context, state) {
                  if (state is ProjectSuccess) {
                    AppRouter.router
                        .pushReplacementNamed(Pages.projects.screenName);
                  }
                  if (state is ProjectError) {
                    ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(
                        content: Text('${state.error}'),
                        actions: [
                          IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentMaterialBanner();
                              },
                              icon: const Icon(Icons.clear))
                        ],
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return switch (state) {
                    ProjectLoad() => const LinearProgressIndicator(),
                    _ => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilledButton(
                          onPressed: () {
                            if (!_keyForm.currentState!.validate()) return;
                          },
                          style: FilledButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            "Add",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                  };
                },
              ),
            ],
          )),
    );
  }
}
