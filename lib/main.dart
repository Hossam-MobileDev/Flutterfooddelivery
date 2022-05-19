import 'package:flutter/material.dart';
import 'package:fooddelivery/FoodDetail/Food/recommended_food_detail.dart';
import 'package:fooddelivery/controllers/cart_controller.dart';
import 'package:fooddelivery/controllers/recommended_product_controller.dart';
import 'package:fooddelivery/helper/dependencies.dart';
import 'package:fooddelivery/home/food_page_body.dart';
import 'package:fooddelivery/pages/splash_page.dart';
import 'package:fooddelivery/routes/route_helper.dart';
import 'package:get/get.dart';

import 'FoodDetail/Food/popular_food_detail.dart';
import 'controllers/popular_product_controller.dart';
import 'home/main_food_page.dart';
import 'pages/cart_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   /* Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>();*/
   return  GetBuilder<PopularProductController>(builder: (_){
       return GetBuilder<RecommendedProductController>(builder: (_){
       return  GetMaterialApp(
             debugShowCheckedModeBanner: false,
             title: 'Flutter Demo',
             // home: const SplashPage(),
             initialRoute: RouteHelper.getSplashPage(),
             getPages: RouteHelper.routes

         );
       });
     });
  }
}
