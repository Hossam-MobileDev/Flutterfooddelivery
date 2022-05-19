
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooddelivery/routes/route_helper.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../controllers/recommended_product_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
Future<void>loadResources() async {
  await Get.find<PopularProductController>().getPopularProductList();
  await Get.find<RecommendedProductController>().getRecommendedProductList();
  await Get.find<CartController>();
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadResources();
    animationController=AnimationController
      (vsync: this,duration: Duration(seconds:2 ))..forward();
    animation = new CurvedAnimation(parent: animationController, curve:
    Curves.linear);

    Timer(
      Duration(seconds: 3),()=>Get.offNamed(RouteHelper.getInitial())
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
              child: Center(child: Image.asset("assets/image/logo part 1.png",width: 250,))),
          Center(child: Image.asset("assets/image/logo part 2.png",width: 250,))

        ],
      ),
    );
  }
}
