import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/signin_bloc/sign_in_bloc.dart';


class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            // Navigate to the main app screen
            Navigator.pushReplacementNamed(context, '/main');
          } else if (state is SignInError) {
            // Show a SnackBar with the error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is SignInLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    context.read<SignInBloc>().add(
                      SignInRequested(email: email, password: password),
                    );
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
