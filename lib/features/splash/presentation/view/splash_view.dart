import 'dart:async';
import 'dart:io';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import '../viewmodel/splash_viewmodel.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with WidgetsBindingObserver {
  double _proximityValue = 0;
  bool _isScreenOff = false;
  final List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  // ignore: unused_field
  int _isMounted = 0;

  @override
  void initState() {
    // Wait for 2 seconds and then navigate
    Future.delayed(const Duration(seconds: 2), () {
      ref.read(splashViewModelProvider.notifier).init(context);
    });
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isMounted++;

    _streamSubscriptions.add(proximityEvents!.listen((ProximityEvent event) {
      if (mounted &&
          WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
        setState(() {
          _proximityValue = event.proximity;
          if (_proximityValue <= 4) {
            _turnOffScreen();
          } else {
            _turnOnScreen();
          }
        });
      }
    }));
  }

  // @override
  // void dispose() {
  //   for (var subscription in _streamSubscriptions) {
  //     subscription.cancel();
  //   }
  //   WidgetsBinding.instance.removeObserver(this);
  //   _turnOnScreen();
  //   super.dispose();
  // }

  void _turnOffScreen() async {
    if (!_isScreenOff) {
      _isScreenOff = true;
      if (Platform.isAndroid) {
        await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      }
    }
  }

  void _turnOnScreen() async {
    if (_isScreenOff) {
      _isScreenOff = false;
      if (Platform.isAndroid) {
        await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        // App is now visible and active
        _streamSubscriptions
            .add(proximityEvents!.listen((ProximityEvent event) {
          if (mounted) {
            setState(() {
              _proximityValue = event.proximity;
              if (_proximityValue <= 4) {
                _turnOffScreen();
              } else {
                _turnOnScreen();
              }
            });
          }
        }));
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        // App is paused or inactive
        for (var subscription in _streamSubscriptions) {
          subscription.cancel();
        }
        _turnOnScreen(); // Make sure the screen is turned on when the app is paused or inactive
        break;
      case AppLifecycleState.detached:
        dispose();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'KnowYourRide',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.asset('assets/images/hondacivic.jpg'),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const LinearProgressIndicator(),
            ),
            // const SizedBox(height: 20),
            // const Text(
            //   'Developed by: oopsie',
            //   style: TextStyle(fontSize: 14),
            // ),
          ],
        ),
      ),
    );
  }
}
