// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/config/router/app_route.dart';

import '../../../../config/constants/theme_constant.dart';
import '../viewmodel/auth_viewmodel.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'oopsie');
  final _passwordController = TextEditingController(text: '12345678');

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: InkWell(
      //   onTap: () {
      //     Navigator.of(context).pop();
      //   },
      //   child: Container(
      //     padding: const EdgeInsets.all(16),
      //     alignment: Alignment.center,
      //     width: 60,
      //     height: 60,
      //     decoration: const BoxDecoration(
      //       shape: BoxShape.circle,
      //       color:
      //           Color.fromARGB(255, 205, 205, 205), // Set button color to grey
      //     ),
      //     child: const Icon(
      //       Icons.arrow_back_ios_new,
      //       color: AppColorConstant.secondaryColor,
      //       size: 30,
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // backgroundColor: AppColorConstant.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColorConstant.secondaryColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColorConstant.accentColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColorConstant.primaryColor)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    key: const ValueKey('password'),
                    controller: _passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColorConstant.secondaryColor)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }),
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot password action
                        // Add your logic here
                      },
                      child: const Text(
                        'Forgot Password?',
                        style:
                            TextStyle(color: AppColorConstant.secondaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref.read(authViewModelProvider.notifier).signInUser(
                                context,
                                _usernameController.text,
                                _passwordController.text,
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorConstant.accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: AppColorConstant.primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.registerRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorConstant.accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: AppColorConstant.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
