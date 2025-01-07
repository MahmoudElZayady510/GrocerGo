import 'package:flutter/material.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';

import '../../../common/widgets/socail_button.dart';

class HeyThereScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo and image at the top
            Center(
              child: Image.asset(
                'assets/pics/GrocerGoo.png', // Use your asset path here
                // height: 180.0, // Adjust height as needed
                // width: double.infinity,
              ),
            ),
            SizedBox(height: 40,),
            // "Hey there!" and message
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    'Hey there!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Log in or sign up for a more personalized ordering experience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            // Sign-in buttons
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SocialButton(
                    //   icon: Icons.g_mobiledata,
                    //   label: 'Continue with Google',
                    //   onPressed: () {
                    //     // Handle Google sign-in
                    //   },
                    // ),
                    // SizedBox(height: 10),
                    // SocialButton(
                    //   icon: Icons.facebook,
                    //   label: 'Continue with Facebook',
                    //   onPressed: () {
                    //     // Handle Facebook sign-in
                    //   },
                    // ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 60,
                      child: SocialButton(
                        icon: null,
                        color: Color(0xff7ED43E),
                        label: 'Get Started',
                        onPressed: () {
                          // Handle Email sign-in
                          Navigator.of(context).pushReplacementNamed('/continue');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

