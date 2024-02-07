import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_review_app/config/constants/theme_constant.dart';
import 'package:news_review_app/config/router/app_route.dart';
import 'package:news_review_app/features/auth/domain/entity/user_entity.dart';
import 'package:permission_handler/permission_handler.dart';

import '../viewmodel/auth_viewmodel.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  bool _isEditing = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  String _currentUsername = '';
  String _currentEmail = '';
  String _currentFirstName = '';
  String _currentLastName = '';

  File? img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  void updateUserProfile(GlobalKey<FormState> formKey) async {
    var userState = ref.watch(authViewModelProvider);
    UserEntity profile = userState.user!;
    if (formKey.currentState!.validate()) {
      final changedFields = <String, dynamic>{};
      if (_currentUsername.isNotEmpty && _currentUsername != profile.username) {
        changedFields['username'] = _currentUsername;
      }
      if (_currentEmail.isNotEmpty && _currentEmail != profile.email) {
        changedFields['email'] = _currentEmail;
      }
      if (_currentFirstName.isNotEmpty &&
          _currentFirstName != profile.firstname) {
        changedFields['firstname'] = _currentFirstName;
      }
      if (_currentLastName.isNotEmpty && _currentLastName != profile.lastname) {
        changedFields['lastname'] = _currentLastName;
      }

      // Merge the changed fields into the original profile
      final mergedUser = profile.copyWith(
        username: changedFields['username'] ?? profile.username,
        email: changedFields['email'] ?? profile.email,
        firstname: changedFields['firstname'] ?? profile.firstname,
        lastname: changedFields['lastname'] ?? profile.lastname,
      );

      // print('Merged user data: $mergedUser');
      ref
          .watch(authViewModelProvider.notifier)
          .updateProfile(context, mergedUser);
      await _refreshProfile();
    }
  }

  Future<void> _refreshProfile() async {
    await ref.read(authViewModelProvider.notifier).getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(authViewModelProvider);
    UserEntity? profile = userState.user;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final key = GlobalKey<FormState>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshProfile,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (profile != null) ...{
                Center(
                  child: Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100.0),
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        _isEditing
                            ? _buildTextField(_usernameController, "Username",
                                _isEditing, profile.username)
                            : _buildText(_isEditing, profile.username),
                        const SizedBox(height: 10.0),
                        _isEditing
                            ? _buildTextField(_emailController, "Email",
                                _isEditing, profile.email)
                            : _buildText(_isEditing, profile.email),
                        const SizedBox(height: 10.0),
                        _isEditing
                            ? _buildTextField(_firstNameController,
                                "First Name", _isEditing, profile.firstname)
                            : _buildText(_isEditing, profile.firstname),
                        const SizedBox(height: 10.0),
                        _isEditing
                            ? _buildTextField(_lastNameController, "Last Name",
                                _isEditing, profile.lastname)
                            : _buildText(_isEditing, profile.lastname),
                        const SizedBox(height: 20.0),
                        _isEditing
                            ? Container(
                                width: screenWidth * 0.95,
                                height: screenHeight * 0.06,
                                margin: const EdgeInsets.all(2),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColorConstant.accentColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    updateUserProfile(key);

                                    // Save changes to user profile
                                    setState(() {
                                      _isEditing = false;
                                      // Perform save logic here
                                    });
                                  },
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                        color: AppColorConstant.primaryColor),
                                  ),
                                ),
                              )
                            : SizedBox(height: screenHeight * 0.04),
                        const SizedBox(height: 4),
                        Container(
                          width: screenWidth * 0.95,
                          height: screenHeight * 0.06,
                          margin: const EdgeInsets.all(2),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColorConstant.accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              setState(() {
                                _isEditing = !_isEditing;
                              });
                            },
                            child: _isEditing
                                ? const Text(
                                    "Back",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : const Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: screenWidth * 0.95,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .watch(authViewModelProvider.notifier)
                                  .signout(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColorConstant.accentColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                  color: AppColorConstant.primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              } else ...{
                Center(
                    child: Container(
                  margin: screenHeight > 900
                      ? EdgeInsets.only(top: screenHeight * 0.5)
                      : EdgeInsets.only(top: screenHeight * 0.28),
                  height: 100,
                  width: 300,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.loginRoute);
                    },
                    child: const Center(
                      child: Text(
                        'Please Log in',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColorConstant.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )),
              },
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(bool isEditing, String value) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        value,
        style: TextStyle(
            fontSize: screenWidth > 600 ? 32 : 24,
            color: AppColorConstant.secondaryColor),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      bool isEditing, String value) {
    return TextFormField(
      initialValue: value,
      onChanged: (newValue) {
        if (label == "Username") {
          _currentUsername = newValue;
          // print(_currentUsername);
        } else if (label == "Email") {
          _currentEmail = newValue;
        } else if (label == "First Name") {
          _currentFirstName = newValue;
        } else if (label == "Last Name") {
          _currentLastName = newValue;
        }
      },
      readOnly: !isEditing,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
