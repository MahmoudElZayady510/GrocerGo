import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';
import 'package:groceries/presentation/auth/blocs/signout_bloc/signout_bloc.dart';

import '../blocs/user_info_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocConsumer<UserInfoBloc, UserInfoState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is UserInfoLoading) {
                  context.read<UserInfoBloc>().add(FetchUserInfo());
                }
                if (state is UserInfoLoaded) {
                  return ListTile(
                    leading: CircleAvatar(),
                    title: Text(state.userData.firstName),
                    subtitle: Row(
                      children: [
                        Icon(Icons.flare),
                        Text(' Egypt'),
                      ],
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.settings_outlined)),
                  );
                }
                else {
                  return Text('state Error');
                }
              },
            ),
            Divider(
              color: AppColors.secondBackgroundColor,
              thickness: 10,
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard_sharp),
              title: Text('Orders'),
            ),
            ListTile(
              leading: Icon(Icons.question_mark_rounded),
              title: Text('About app'),
            ),
            BlocConsumer<SignoutBloc, SignoutState>(
              listener: (context, state) {
                if (state is SignoutSuccess){
                  Navigator.pushReplacementNamed(context, '/');
                }
              },
              builder: (context, state) {
                return ListTile(
                  onTap: () async {
                    bool? result = await showLogoutConfirmationDialog(context);
                    if (result == true) {
                      context.read<SignoutBloc>().add(SignOutRequested());
                    }
                    else{

                    }
                  },
                  leading: Icon(Icons.output_sharp),
                  title: Text('Log out'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
Future<bool?> showLogoutConfirmationDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // User must tap a button
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Return false
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Return true
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}