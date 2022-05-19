
import 'package:flutter/material.dart';
import 'package:fooddelivery/home/main_food_page.dart';
import 'package:fooddelivery/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedindex = 0;
  List pages=[
    MainFoodPage(),
    Container(child: Center(child: Text("next page")),),
    Container(child: Center(child: Text("next next page")),),
    Container(child: Center(child: Text("next next next page")),),

  ];
  void onTapNav(int index){
    setState(() {
      selectedindex=index;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:AppColors.mainColor ,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectedindex,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined)
            ,label:"home"),
        BottomNavigationBarItem(icon: Icon(Icons.archive)
            ,label:"history"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart)
            ,label:"cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person)
            ,label:"me"),
      ],

      ),
    );
  }
}
