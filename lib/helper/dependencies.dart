
import 'package:fooddelivery/controllers/cart_controller.dart';
import 'package:fooddelivery/controllers/popular_product_controller.dart';
import 'package:fooddelivery/data/api/api_client.dart';
import 'package:fooddelivery/data/repository/cart_repo.dart';
import 'package:fooddelivery/data/repository/popular_product_repo.dart';
import 'package:fooddelivery/utils/app_constants.dart';
import 'package:get/get.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';
Future<void> init()async {
Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));

Get.lazyPut(() => RecommmendedProductRepo(apiClient: Get.find()));
Get.lazyPut(() => RecommendedProductController(recommmendedProductRepo: Get.find()));

Get.lazyPut(() => CartRepo());
Get.lazyPut(() => CartController(cartRepo: Get.find()));

}