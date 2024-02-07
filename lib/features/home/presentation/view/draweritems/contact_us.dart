import 'package:flutter/material.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('About Us'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Name and Logo
              Container(
                width: screenWidth,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Company Name',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Image.asset(
                      'assets/images/logo/logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              ),

              //brief summary
              Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Our company offers a wide range of high-quality products and services to meet the needs of our customers.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
              Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Us:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('123 Main Street'),
                        subtitle: Text('Anytown, USA 12345'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('(123) 456-7890'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.email),
                        title: Text('info@company.com'),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}

class Testimonial {
  final String author;
  final String text;

  Testimonial(this.author, this.text);
}
