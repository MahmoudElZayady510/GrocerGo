import 'package:flutter/material.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _tile('Saved Address'),
            _tile('Change email'),
            _tile('Change password'),
            Divider(
              color: AppColors.secondBackgroundColor,
              thickness: 5,
            ),
            _tile('Language'),
          ],
        ),
      ),
    );
  }
  Widget _tile (String title) {
    return ListTile(
      onTap: (){},
      title: Text(title,
        style: TextStyle(
          fontSize: 14
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14,),
    );
  }
}
