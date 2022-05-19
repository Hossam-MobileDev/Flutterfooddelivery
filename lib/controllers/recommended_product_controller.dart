
import 'package:get/get.dart';

import '../data/repository/popular_product_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController {
  final RecommmendedProductRepo recommmendedProductRepo;

  RecommendedProductController({required this.recommmendedProductRepo});

  List<dynamic> _recomendedProductList = [];

  List<dynamic> get recomendedPrroductList => _recomendedProductList;

  bool _isLoaded = false;
  bool get isLoaded =>_isLoaded;
  Future<void> getRecommendedProductList() async {
    Response response = await recommmendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      print("got products recommeded");
      _recomendedProductList = [];
      _recomendedProductList.addAll(Product.fromJson(response.body).products);
      print(_recomendedProductList);
      _isLoaded = true;
      update();
    }
  }
}