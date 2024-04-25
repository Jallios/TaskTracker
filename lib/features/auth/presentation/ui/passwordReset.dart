import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_flutter/core/emm/entity/user_entity.dart';
import 'package:task_tracker_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task_tracker_flutter/router/app_router.dart';
import 'package:task_tracker_flutter/router/router_utils.dart';

class PasswordReset extends StatefulWidget {
  final String? email;
  final String? code;
  const PasswordReset({super.key, required this.code, required this.email});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confrimPasswordController =
      TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  bool _showPassword = false;
  bool _showConfrimPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restore password"),
        centerTitle: true,
      ),
      body: Form(
        key: _keyForm,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _codeController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your code';
                }
                if (value != widget.code) {
                  return 'Wrong code';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text('Code*'),
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
              obscureText: !_showPassword,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
              ],
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter password';
                }
                if (value.length < 8) {
                  return '< 8';
                }
                if (!value.contains(RegExp(r'[A-ZА-Я]'))) {
                  return '[A-ZА-Я]';
                }
                if (!value.contains(RegExp(r'[a-zа-я]'))) {
                  return '[a-zа-я]';
                }
                if (!value.contains(RegExp(r'[0-9]'))) {
                  return '[0-9]';
                }
                if (!value.contains(RegExp(r'[$!@#%^&*(),.?":{}|<>]'))) {
                  return r'[$!@#%^&*(),.?":{}|<>]';
                }
                return null;
              },
              decoration: InputDecoration(
                label: const Text('Password*'),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  child: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: !_showConfrimPassword,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
              ],
              controller: _confrimPasswordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter password';
                }
                if (value != _passwordController.text) {
                  return 'Don`t match';
                }
                return null;
              },
              decoration: InputDecoration(
                label: const Text('Repeat password*'),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showConfrimPassword = !_showConfrimPassword;
                    });
                  },
                  child: Icon(_showConfrimPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
            ),
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('${state.message}')));
                AppRouter.router.pushReplacementNamed(Pages.signIn.screenName);
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
                        context.read<AuthCubit>().passwordReset(
                              UserEntity(
                                  email: widget.email,
                                  password: _passwordController.text),
                            );
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
