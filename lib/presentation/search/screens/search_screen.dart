import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/common/widgets/back_arrow.dart';
import 'package:groceries/common/widgets/search_field.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';

import '../../../common/widgets/product_card.dart';
import '../blocs/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  String firstSuggestion = 'Food';
  String secondSuggestion = 'Drinks';
  String thirdSuggestion = 'Toys';
  final TextEditingController controller = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Container(
               decoration: BoxDecoration(
                 color: AppColors.orange,
                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
               ),
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
                       IconButton(onPressed: (){}, 
                           icon: Icon(Icons.settings_outlined))
                     ],
                   ),
                   SizedBox(height: 10,)
                 ],
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
                           height: 100,
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
                                   child: SuggestionCard(text: firstSuggestion)),
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
                                   child: SuggestionCard(text: secondSuggestion)),
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
                                   child: SuggestionCard(text: thirdSuggestion)),
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
                   return CircularProgressIndicator();
                 }
                 if (state is SearchLoaded) {
                   if (state.groceries.length == 0) {
                     return Text('No results');
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
                )),
    );
  }
}

class SuggestionCard extends StatelessWidget {
  final String text;

  const SuggestionCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
                'https://w7.pngwing.com/pngs/739/553/png-transparent-hamburger-veggie-burger-chicken-sandwich-fast-food-hamburger-burger-burger-sandwich-food-recipe-cheeseburger-thumbnail.png'),
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
