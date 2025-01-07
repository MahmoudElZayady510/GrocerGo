import 'package:flutter/material.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';

import '../../../common/widgets/socail_button.dart';

class ContiueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Logo and image at the top
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(170),
                  child: Image.asset(
                    'assets/pics/continue.png', // Use your asset path here
                    // height: 180.0, // Adjust height as needed
                    // width: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: 80,),
              // "Hey there!" and message
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: Text(
                      'Get your groceries \n with GrocerGo',
                      style: TextStyle(

                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(height: 10),
                ],
              ),
              SizedBox(height: 30,),
              // Sign-in buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                      child: SocialButton(
                        icon: Icons.g_mobiledata,
                        color: Color(0xff5383EC),
                        label: 'Continue with Google',
                        onPressed: () {
                          // Handle Google sign-in
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 60,
                      child: SocialButton(
                        icon: Icons.facebook,
                        color: Color(0xff4A66AC),
                        label: 'Continue with Facebook',
                        onPressed: () {
                          // Handle Facebook sign-in
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 60,
                      child: SocialButton(
                        icon: Icons.mail,
                        color: Color(0xffDF4D3A),
                        label: 'Continue with email',
                        onPressed: () {
                          // Handle Email sign-in
                          Navigator.of(context).pushReplacementNamed('/signin');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

