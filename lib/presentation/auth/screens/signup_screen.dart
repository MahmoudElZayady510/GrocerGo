import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/signup_bloc/sign_up_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            BlocConsumer<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  Navigator.pushReplacementNamed(context, '/');
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text("Sign-Up Successful!")),
                  // );
                  // Navigator.pop(context); // Go back to the previous screen
                } else if (state is SignUpFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${state.error}")),
                  );
                }
              },
              builder: (context, state) {
                if (state is SignUpLoading) {
                  return CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    context.read<SignUpBloc>().add(
                      SignUpRequested(email, password),
                    );
                  },
                  child: Text("Sign Up"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
