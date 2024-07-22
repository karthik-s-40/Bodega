import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(fontFamily: 'Pacifico', fontSize: 26),
        ),
        backgroundColor: Color.fromARGB(255, 225, 225, 161), // Yellow color for AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 255, 245, 204), Color.fromARGB(255, 255, 236, 179)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 2),
                child: Text(
                  'About Us',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Lobster'),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Bodega revolutionizes your grocery shopping experience with seamless convenience at your fingertips. As a cutting-edge grocery delivery app, Bodega allows you to browse through a vast selection of fresh produce, pantry staples, household essentials, and specialty items from local markets—all from the comfort of your home.',
                style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 16.0),
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 2),
                child: Text(
                  'Imagine effortlessly planning meals with intuitive search and filtering options, ensuring you find exactly what you need. With Bodega, placing orders is simple and efficient, with flexible delivery options to fit your schedule. Whether you\'re stocking up for the week or craving something specific, Bodega ensures your groceries arrive promptly and in pristine condition.',
                  style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                ),
              ),
              SizedBox(height: 16.0),
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 2),
                child: Text(
                  'What sets Bodega apart is its commitment to supporting local businesses and offering personalized recommendations based on your preferences. From farm-fresh ingredients to gourmet treats, Bodega transforms grocery shopping into a delightful experience tailored to your lifestyle.',
                  style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                ),
              ),
              SizedBox(height: 16.0),
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 2),
                child: Text(
                  'Experience the future of grocery shopping with Bodega—a smart, reliable, and user-friendly app that brings the market to your doorstep.',
                  style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
