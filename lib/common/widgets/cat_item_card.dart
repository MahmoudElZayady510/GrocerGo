// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:groceries/main.dart';
// import 'package:groceries/presentation/home/blocs/products_bloc.dart';
// import 'package:palette_generator/palette_generator.dart';
//
// class CartegoryItemCard extends StatefulWidget {
//   final String image;
//   final String category;
//   final VoidCallback onTap;
//   final bool isSelected;
//
//   const CartegoryItemCard({
//     super.key,
//     required this.category,
//     required this.image,
//     required this.onTap,
//     required this.isSelected,
//   });
//
//   @override
//   State<CartegoryItemCard> createState() => _CartegoryItemCardState();
// }
//
// class _CartegoryItemCardState extends State<CartegoryItemCard> {
//   Color _backgroundColor = const Color(0xff7ED43E); // Default color
//   PaletteGenerator? _paletteGenerator;
//
//   @override
//   void initState() {
//     super.initState();
//     _generatePalette();
//   }
//
//   Future<void> _generatePalette() async {
//     try {
//       _paletteGenerator = await PaletteGenerator.fromImageProvider(AssetImage('assets/pics/8-82858_download-sack-of-rice-png 1.png'));
//       final dominantColor = _paletteGenerator?.dominantColor?.color;
//       if (dominantColor != null) {
//         setState(() {
//           _backgroundColor = dominantColor;
//         });
//       }
//     } catch (error) {
//       print('Error generating palette: $error');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: _backgroundColor,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Row(
//             children: [
//               Image.asset('assets/pics/8-82858_download-sack-of-rice-png 1.png'),
//               const SizedBox(width: 20),
//               Text(
//                 widget.category,
//                 style: TextStyle(fontSize: 18),
//               ),
//               const SizedBox(width: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';
import 'package:groceries/main.dart';
import 'package:groceries/presentation/home/blocs/products_bloc.dart';

class CartegoryItemCard extends StatelessWidget {
  final String image;
  final String category;
  final VoidCallback onTap;
  final bool isSelected;
  const CartegoryItemCard(
      {super.key, required this.category, required this.image, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap

        // Navigator.pushNamed(context, '/category',arguments:category);
        // context.read<ProductsBloc>().add(FetchGroceryListByCategory(category: category));
      ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected? AppColors.secondaryColor :AppColors.primaryColor, // the dynamic color i want
            borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            children: [
              Image.network(image,
              height: 60,
                width: isSelected? 120:70,
              ),
              SizedBox(width: 20,),
              Text(category,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isSelected? FontWeight.bold : FontWeight.normal
                ),
              ),
              SizedBox(width: 20,)
            ],
          ),
        ),
        // child: Column(
        //   children: [
        //     ClipRRect(
        //       borderRadius: BorderRadius.circular(10),
        //       child: Image.network(
        //         image,
        //         width: 80,
        //         height: 50,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //     Text(
        //       category,
        //       style: TextStyle(
        //           color: isSelected? Colors.blue : Colors.black,
        //           fontWeight: FontWeight.w500),
        //     )
        //   ],
        // ),
      ),
    );
    ;
  }
}
