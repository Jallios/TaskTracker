import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_flutter/core/emm/entity/user_entity.dart';
import 'package:task_tracker_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task_tracker_flutter/router/app_router.dart';
import 'package:task_tracker_flutter/router/router_utils.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        centerTitle: true,
      ),
      body: Form(
        key: _keyForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _loginController,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter login';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Login*'),
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
                    child: Icon(_showPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  InkWell(
                    child: const Text("No account?",
                        style: TextStyle(fontSize: 16)),
                    onTap: () {
                      AppRouter.router.pushNamed(Pages.signUp.screenName);
                    },
                  ),
                  const Spacer(),
                  InkWell(
                    child: const Text("Restore password",
                        style: TextStyle(fontSize: 16)),
                    onTap: () {
                      AppRouter.router.pushNamed(Pages.sendCode.screenName);
                    },
                  ),
                ],
              ),
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  AppRouter.router.pushNamed(Pages.projects.screenName);
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
                          context.read<AuthCubit>().signIn(
                                UserEntity(
                                    login: _loginController.text,
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
                          "Sign In",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
