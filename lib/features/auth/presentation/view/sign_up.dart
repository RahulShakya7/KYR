// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_review_app/config/router/app_route.dart';
import 'package:news_review_app/features/auth/domain/entity/user_entity.dart';

import '../../../../config/constants/theme_constant.dart';
import '../viewmodel/auth_viewmodel.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
//   void checkServerAccessibility() async {
//     var url =
//         Uri.parse('http://10.0.2.2:3000/'); // Replace with your server's URL
//     try {
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         print('Server is accessible');
//       } else {
//         print('Server is not accessible. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error connecting to the server: $e');
//     }
//   }

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'oopsie');
  final _fnameController = TextEditingController(text: 'Rahul');
  final _lnameController = TextEditingController(text: 'Shakya');
  final _emailController = TextEditingController(text: 'oopsie@gmail.com');
  final _passwordController = TextEditingController(text: 'oopsie123');

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
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
      // backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: AppColorConstant.secondaryColor),
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColorConstant.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _fnameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _lnameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
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
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // checkServerAccessibility();
                          var user = UserEntity(
                            username: _usernameController.text,
                            firstname: _fnameController.text,
                            lastname: _lnameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                          ref
                              .read(authViewModelProvider.notifier)
                              .signUpUser(user);

                          // if (authState.error != null) {
                          //   showSnackBar(
                          //     message: authState.error.toString(),
                          //     context: context,
                          //     color: Colors.red,
                          //   );
                          // } else {
                          //   showSnackBar(
                          //     message: 'Registered successfully',
                          //     context: context,
                          //     color: Colors.green,
                          //   );
                          // }
                          Navigator.pushNamed(context, AppRoute.loginRoute);
                        }
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
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.loginRoute);
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
