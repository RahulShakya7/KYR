import 'package:flutter/material.dart';

import '../../../../config/constants/theme_constant.dart';

class AppInformationView extends StatelessWidget {
  const AppInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "About Us",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColorConstant.primaryColor,
          foregroundColor: AppColorConstant.secondaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenWidth,
                color: AppColorConstant.primaryColor,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Image.asset(
                      'assets/logo/logo-white.png',
                      width: screenWidth * 0.9,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'This app aims to provide quality news about the latest vehicle trends, know about your vehicles and review them',
                    style: TextStyle(fontSize: screenWidth > 900 ? 40 : 20),
                  )),
              Center(
                child: Container(
                    width: screenWidth,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Us:',
                          style: TextStyle(
                            fontSize: screenWidth > 900 ? 40 : 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(
                            'Kathmandu. Nepal',
                            style: TextStyle(
                                fontSize: screenWidth > 900 ? 28 : 20),
                          ),
                          subtitle: const Text('Teku, Ward no. 20'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(
                            '+977 9813945865',
                            style: TextStyle(
                                fontSize: screenWidth > 900 ? 28 : 20),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: Text(
                            'knowyourride@gmail.com.np',
                            style: TextStyle(
                                fontSize: screenWidth > 900 ? 28 : 20),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
