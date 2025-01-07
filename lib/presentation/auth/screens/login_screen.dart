import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';

import '../blocs/signin_bloc/sign_in_bloc.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool invalid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.orange,
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Continue with email',
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Email'),
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                      if (state is SignInError) {
                        return Visibility(
                            child: Container(
                              child: Text(
                                state.message,
                                style: TextStyle(color: Colors.red[900]),
                              ),
                            ));
                      }
                      else{
                        return Container();
                      }
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            backgroundColor: AppColors.backgroundColor),
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/signup');
                        },
                        child: Text(
                          'Create an account',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            backgroundColor: AppColors.backgroundColor),
                      ),
                    ],
                  ),
                ],
              ),
              BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {
                  if (state is SignInSuccess) {
                    print('signed up');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signup Successful!')),
                    );
                    Navigator.of(context).pushReplacementNamed('/');
                  } else if (state is SignInError) {
                    print('signup failed');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Signup Failed: ${state.message}')),
                    );
                  } else {
                    print('wtf is that state');
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is SignInLoading
                            ? null
                            : () {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                context.read<SignInBloc>().add(SignInRequested(
                                    email: email, password: password));
                              },
                        child: state is SignInLoading
                            ? CircularProgressIndicator()
                            : Text('Log in',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ));
                },
              )
            ],
          ),
        )
        // body: BlocConsumer<SignInBloc, SignInState>(
        //   listener: (context, state) {
        //     if (state is SignInSuccess) {
        //       // Navigate to the main app screen
        //       Navigator.pushReplacementNamed(context, '/main');
        //     } else if (state is SignInError) {
        //       // Show a SnackBar with the error message
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(content: Text(state.message)),
        //       );
        //     }
        //   },
        //   builder: (context, state) {
        //     if (state is SignInLoading) {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //
        //     return Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: Column(
        //         children: [
        //           TextField(
        //             controller: emailController,
        //             decoration: const InputDecoration(labelText: 'Email'),
        //           ),
        //           TextField(
        //             controller: passwordController,
        //             decoration: const InputDecoration(labelText: 'Password'),
        //             obscureText: true,
        //           ),
        //           const SizedBox(height: 20),
        //           ElevatedButton(
        //             onPressed: () {
        //               final email = emailController.text.trim();
        //               final password = passwordController.text.trim();
        //
        //               context.read<SignInBloc>().add(
        //                 SignInRequested(email: email, password: password),
        //               );
        //             },
        //             child: const Text('Sign In'),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),
        );
  }
}
