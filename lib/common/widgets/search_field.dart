import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/configs/theme/app_colors.dart';
import '../../presentation/search/blocs/search_bloc.dart';

class SearchField extends StatelessWidget {
  final bool enable;
  final double width;
  final VoidCallback onTap;
  final TextEditingController controller;
  const SearchField({super.key, required this.enable, required this.width, required this.onTap, required this.controller, });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('tap');
        context.read<SearchBloc>().add(SearchResetEvent());
        Navigator.pushNamed(context, '/search');
      },
      child: SizedBox(
        width: width,
        height: 40,
        child: TextField(
          onSubmitted: (text){
            context.read<SearchBloc>().add(FetchSearch(text));
          },
          controller: controller,
          enabled: enable,
          decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.secondBackgroundColor,
              hintText: 'Search Products',
              hintStyle: TextStyle(
                // fontSize: 16
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
                size: 25,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}
