import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';

import '../../user_profile/blocs/user_info_bloc.dart';
import '../blocs/signup_bloc/sign_up_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Continue with email',
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: "First name"),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: "Last name"),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "Choose password"),
                  obscureText: true,
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: "address"),
                ),
                SizedBox(height: 10,),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    if (state is SignUpFailure) {
                      return Visibility(
                          child: Container(
                            child: Text(
                              state.error,
                              style: TextStyle(color: Colors.red[900]),
                            ),
                          ));
                    }
                    else{
                      return Container();
                    }
                  },
                ),
                Row(
                  children: [
                    Text('Already has an account?'),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/signin');
                      },
                      child: Text(' SignIn',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryColor
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: BlocConsumer<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpSuccess){
                    print('signed up');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signup Successful!')),
                    );
                    Navigator.of(context).pushReplacementNamed('/');
                  }
                  else if (state is SignUpFailure){
                    print('signup failed');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signup Failed: ${state.error}')),
                    );
                  }
                  else {
                    print('wtf is that state');
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is SignUpLoading ? null : () {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      final firstName = firstNameController.text.trim();
                      final lastName = lastNameController.text.trim();
                      final address = addressController.text.trim();
                      context.read<SignUpBloc>().add(
                          SignUpRequested(email, password, firstName, lastName, address));
                    },
                    child: state is SignUpLoading ? CircularProgressIndicator() : Text('Sign up'),);
                },
              ),
            )
            // BlocConsumer<SignUpBloc, SignUpState>(
            //   listener: (context, state) {
            //     if (state is SignUpSuccess) {
            //       Navigator.pushReplacementNamed(context, '/');
            //       // ScaffoldMessenger.of(context).showSnackBar(
            //       //   SnackBar(content: Text("Sign-Up Successful!")),
            //       // );
            //       // Navigator.pop(context); // Go back to the previous screen
            //     } else if (state is SignUpFailure) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text("Error: ${state.error}")),
            //       );
            //     }
            //   },
            //   builder: (context, state) {
            //     if (state is SignUpLoading) {
            //       return CircularProgressIndicator();
            //     }
            //     return ElevatedButton(
            //       onPressed: () {
            //         final email = emailController.text.trim();
            //         final password = passwordController.text.trim();
            //
            //         context.read<SignUpBloc>().add(
            //           SignUpRequested(email, password),
            //         );
            //       },
            //       child: Text("Sign Up"),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
