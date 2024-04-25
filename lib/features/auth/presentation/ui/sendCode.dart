import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_flutter/core/emm/entity/user_entity.dart';
import 'package:task_tracker_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task_tracker_flutter/router/app_router.dart';
import 'package:task_tracker_flutter/router/router_utils.dart';

class SendCode extends StatefulWidget {
  const SendCode({super.key});

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
  final TextEditingController _emailController = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send code"),
        centerTitle: true,
      ),
      body: Form(
        key: _keyForm,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your email';
                }
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return 'Enter correct email';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text('Email*'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                AppRouter.router.pushNamed(Pages.passwordReset.screenName,
                    queryParameters: {
                      'code': state.message!,
                      'email': _emailController.text
                    });
              }
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    content: Text('${state.error}'),
                    actions: [
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                );
              }
            },
            builder: (context, state) {
              return switch (state) {
                AuthLoad() => const LinearProgressIndicator(),
                _ => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: () {
                        if (!_keyForm.currentState!.validate()) return;
                        context.read<AuthCubit>().emailSendCode(
                            UserEntity(email: _emailController.text));
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Send code",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
              };
            },
          ),
        ]),
      ),
    );
  }
}
