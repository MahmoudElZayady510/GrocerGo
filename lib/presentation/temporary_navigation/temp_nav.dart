import 'package:flutter/material.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';
import 'package:groceries/presentation/cart/screens/cart_screen.dart';
import 'package:groceries/presentation/home/screens/home_screen.dart';
import 'package:groceries/presentation/user_profile/screens/user_screen.dart';
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}
final screens = [
  HomeScreen(),
  CartScreen(),
  UserScreen(),
];
int currentPage = 0;
class _NavigationScreenState extends State<NavigationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPage = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPage],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          // elevation: 100,
          selectedLabelStyle: TextStyle(
            fontSize: 14
          ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
                color: Colors.lightGreen
            ),
            selectedItemColor: AppColors.primaryColor,

            selectedIconTheme: IconThemeData(
                size: 30
            ),
            selectedFontSize: 17,
            unselectedIconTheme: IconThemeData(
                size: 25
            ),
            // iconSize: 40,
            type : BottomNavigationBarType.fixed,
            backgroundColor: Color(0xffFFFFFF),
            currentIndex: currentPage,
            onTap:(int newindex){
              setState(() {
                currentPage = newindex;
                //  if(currentindex == 0) Navigator.pushNamed(context, 'home');
              }
              );
            } ,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                activeIcon: Icon(Icons.home_filled, color: AppColors.primaryColor,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  activeIcon: Icon(Icons.shopping_cart, color: AppColors.primaryColor,),
                  label: 'Cart'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                activeIcon: Icon(Icons.person, color:  AppColors.primaryColor,),
                label: 'User',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.account_circle),
              //   label: 'المستخدم',
              //   activeIcon: Icon(Icons.account_circle, color: Color(0xff5ec9ef),),
              // ),
              // BottomNavigationBarItem(
              //   icon: Icon( Icons.view_list, ),
              //   activeIcon: Icon(Icons.view_list, color: Color(0xff5ec9ef),),
              //   label: 'المزيد',
              //
              // ),
            ]),
      ),
    );
  }
}
