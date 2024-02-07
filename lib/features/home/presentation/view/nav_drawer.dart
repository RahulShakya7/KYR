import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/theme_constant.dart';
import '../../../../config/router/app_route.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/presentation/viewmodel/auth_viewmodel.dart';

class NavDrawer extends ConsumerStatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends ConsumerState<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(authViewModelProvider);
    UserEntity? user = userState.user;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColorConstant.primaryColor,
            ),
            child: Text(
              'Welcome ${user?.username ?? "User"}',
              style: const TextStyle(
                color: AppColorConstant.secondaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => {Navigator.pushNamed(context, AppRoute.homeRoute)},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => {Navigator.pushNamed(context, AppRoute.profile)},
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Sign In'),
            onTap: () => {Navigator.pushNamed(context, AppRoute.loginRoute)},
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: const Text('Create an account'),
            onTap: () => {Navigator.pushNamed(context, AppRoute.registerRoute)},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('App Information'),
            onTap: () => {Navigator.pushNamed(context, AppRoute.appInfo)},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              ref.watch(authViewModelProvider.notifier).signout(context);
            },
          ),
        ],
      ),
    );
  }
}
