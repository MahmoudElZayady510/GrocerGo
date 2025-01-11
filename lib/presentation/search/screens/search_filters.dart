import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/common/widgets/cat_item_card.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';
import 'package:groceries/presentation/search/blocs/search_bloc.dart';

class SearchFilters extends StatefulWidget {

  SearchFilters({super.key});

  @override
  State<SearchFilters> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  String? sortOption = '';
  String? filterCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
            ),
            child: SafeArea(
              child: Row(
                children:[
                  FloatingActionButton(
                      mini: true,
                      elevation: 0,
                      // backgroundColor: AppColors.secondBackgroundColor,
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.close),
                      onPressed: (){
                        Navigator.of(context).pop();
                      }),
                  Expanded(
                    child: Center(
                      child: Text('Filters',
                      style: TextStyle(
                        height: 2.5,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                      heroTag: "disabled_filter_button", // Unique tag
                      mini: true,
                      elevation: 0,
                      // backgroundColor: AppColors.secondBackgroundColor,
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.close,color: Colors.transparent,),
                      onPressed: null),
                ]
              ),
            ),
            ),
          SizedBox(height: 20,),
          Expanded(child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text('Categories',
                  //   style: TextStyle(
                  //     fontSize: 26,
                  //     fontWeight: FontWeight.bold
                  //   ),
                  // ),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //         value: true,
                  //         onChanged: (value){
                  //          setState(() {
                  //            if (value == true){
                  //              filterCategory = 'Fruits';
                  //            }
                  //          });
                  //         },
                  //       fillColor: MaterialStateProperty.all(AppColors.secondaryColor),
                  //     ),
                  //     Text('Fruits',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         color: AppColors.secondaryColor
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sort',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'aToz',
                            groupValue: sortOption,
                            onChanged: (value){
                              setState(() {
                                sortOption = value;
                              });
                            },
                          ),
                          SizedBox(width: 5,),
                          Text('Name a to z',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'priceLowToHigh',
                            groupValue: sortOption,
                            onChanged: (value){
                              setState(() {
                                sortOption = value;
                              });
                            },
                          ),
                          SizedBox(width: 5,),
                          Text('Price low to high',
                            style: TextStyle(
                                fontSize: 16
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'priceHighToLow',
                            groupValue: sortOption,
                            onChanged: (value){
                              setState(() {
                                sortOption = value;
                              });
                            },
                          ),
                          SizedBox(width: 5,),
                          Text('Price high to low',
                            style: TextStyle(
                                fontSize: 16
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: (){
                          context.read<SearchBloc>().add(SearchSort(sortOptions: sortOption ?? '',));
                          Navigator.pop(context);
                        },
                        child: Text('Apply filters')),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
