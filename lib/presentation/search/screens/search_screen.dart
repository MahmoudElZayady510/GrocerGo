import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/common/widgets/back_arrow.dart';
import 'package:groceries/common/widgets/search_field.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';

import '../../../common/widgets/product_card.dart';
import '../blocs/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  String firstSuggestion = 'Fruits';
  String secondSuggestion = 'Vegs';
  String thirdSuggestion = 'Drinks';
  final TextEditingController controller = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             decoration: BoxDecoration(
               color: AppColors.orange,
               borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
             ),
             child: SafeArea(
               child: Column(
                 children: [
                   SizedBox(height: 5,),
                   Row(
                     children: [
                       BackArrow(),
                       Padding(
                         padding: const EdgeInsets.only(right: 10),
                         child: SearchField(
                           controller: controller,
                           enable: true,
                           width: 305,
                           onTap: () {},
                         ),
                       ),
                       IconButton(onPressed: (){
                         Navigator.pushNamed(context, '/filters');
                       },
                           icon: Icon(Icons.settings_outlined))
                     ],
                   ),
                   SizedBox(height: 10,)
                 ],
               ),
             ),
           ),
           BlocConsumer<SearchBloc, SearchState>(
             listener: (context, state) {
               // TODO: implement listener
             },
             builder: (context, state) {
               if (state is SearchInitial) {
                 return Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 20),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         'What are you thinking about?',
                         style:
                             TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                       ),
                       SizedBox(
                         height: 10,
                       ),
                       SizedBox(
                         height: 200,
                         child: ListView(
                           scrollDirection: Axis.horizontal,
                           children: <Widget>[
                             GestureDetector(
                                 onTap: () {
                                   controller.text = firstSuggestion;
                                   context
                                       .read<SearchBloc>()
                                       .add(FetchSearch(firstSuggestion));
                                 },
                                 child: SuggestionCard(
                                     text: firstSuggestion,
                                   image: 'https://i.ibb.co/3kGJzZn/pngegg.png',
                                 )),
                             SizedBox(
                               width: 20,
                             ),
                             GestureDetector(
                                 onTap: () {
                                   controller.text = secondSuggestion;
                                   context
                                       .read<SearchBloc>()
                                       .add(FetchSearch(secondSuggestion));
                                 },
                                 child: SuggestionCard(
                                     text: secondSuggestion,
                                   image: 'https://i.ibb.co/WVNJz9G/pngfuel-6.png',
                                 )),
                             SizedBox(
                               width: 20,
                             ),
                             GestureDetector(
                                 onTap: () {
                                   controller.text = thirdSuggestion;
                                   context
                                       .read<SearchBloc>()
                                       .add(FetchSearch(thirdSuggestion));
                                 },
                                 child: SuggestionCard(
                                     text: thirdSuggestion,
                                   image: 'https://i.ibb.co/FBym2R8/pngfuel-8.png',
                                 )),
                             SizedBox(
                               width: 20,
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 );
               }
               if (state is SearchLoading) {
                 return Center(child: CircularProgressIndicator());
               }
               if (state is SearchLoaded) {
                 if (state.groceries.length == 0) {
                   return Center(child: Text('No results',
                     style: TextStyle(
                       fontSize: 24,
                       fontWeight: FontWeight.bold
                     ),
                   ));
                 } else {
                   return Expanded(
                     child: GridView.builder(
                       padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 20),
                         gridDelegate:
                             const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 2, // 2 items per row
                           crossAxisSpacing: 10.0,
                           mainAxisSpacing: 10.0,
                           childAspectRatio:
                               1, // Adjust this to match your card ratio
                         ),
                         itemCount: state.groceries.length,
                         itemBuilder: (context, index) {
                           final item = state.groceries[index];
                           return ProductCard(
                             id: item.id,
                             name: item.name,
                             image: item.image,
                             price: item.price,
                             description: item.description,
                             category: item.category,
                             unit: item.unit,
                           );
                         }),
                   );
                 }
               }
               if (state is SearchFailed) {
                 print(state.error);
                 return Text('Failed');
               } else {
                 return Text('Error');
               }
             },
           ),
         ],
              ));
  }
}

class SuggestionCard extends StatelessWidget {
  final String text;
  final String image;

  const SuggestionCard({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // SizedBox(
          //   height: 100,
          //   width: 100,
          //   child: ClipRRect(
          //     // borderRadius: BorderRadius.circular(10),
          //     child: Image.network(image,
          //     fit: BoxFit.scaleDown,
          //     ),
          //   ),
          // ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 59,
            backgroundImage: NetworkImage(
                image,
            ),
          ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          )
        ],
      ),
    );
  }
}
