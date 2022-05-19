import 'package:fooddelivery/FoodDetail/Food/popular_food_detail.dart';
import 'package:fooddelivery/FoodDetail/Food/recommended_food_detail.dart';
import 'package:fooddelivery/home/main_food_page.dart';
import 'package:fooddelivery/pages/cart_page.dart';
import 'package:fooddelivery/pages/splash_page.dart';
import 'package:get/get.dart';

import '../pages/home_page.dart';

class RouteHelper {
  static const String initial = "/";
static String splashPage = "/splash-page";
  static String getInitial() => '$initial';
  static const String popularFood = "/popular-food";
static const String cartPage = "/cart-page";

static String getSplashPage()=>'$splashPage';
static String getCartPage()=>'$cartPage';

  static String getPopularFood(int pagId,String page) =>
      '$popularFood?pageId=$pagId&page=$page';

  static const String recommendedFood = "/recommended-food";

  static String getRecommendedFood(int pageId,String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page:()=> SplashPage()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!,);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];

          return RecommendedFoodDetail(pageId: int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn),
    GetPage(name: cartPage, page: () => CartPage()),
  ];
}
