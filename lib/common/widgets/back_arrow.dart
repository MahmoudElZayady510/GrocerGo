import 'package:flutter/material.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      elevation: 0,
      // backgroundColor: AppColors.secondBackgroundColor,
        backgroundColor: Colors.transparent,
      child: Icon(Icons.arrow_back_ios_sharp),
        onPressed: (){
          Navigator.of(context).pop();
        });
  }
}
