import 'package:flutter/material.dart';
import 'package:fooddelivery/controllers/cart_controller.dart';
import 'package:fooddelivery/models/cart_model.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:get/get.dart';

import '../data/repository/popular_product_repo.dart';
import '../models/products_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];

  List<dynamic> get popularPrroductList => _popularProductList;
  late CartController _cartController;
  int _quantity = 0;

  int get quantity => _quantity;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      _isLoaded = true;
      update();
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item count", "You cant reduce more !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item count", "You cant add more !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else
      return quantity;
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cart;
    var exist = false;
    exist = _cartController.existInCart(product);
    if (exist) {
      _inCartItems = _cartController.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    // if(_quantity>0){
    _cartController.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cartController.getQuantity(product);
    _cartController.items.forEach((key, value) {
      print("the id is" + value.id.toString());
    });

    /*  }else{

      Get.snackbar("Item count", "You should add at least one item !",
          backgroundColor: AppColors.mainColor,colorText: Colors.white);
    }*/
    update();
  }

  int get totalItems {
    return _cartController.totalItems;
  }
  List<CartModel> get getItems{
    return _cartController.getItems;
  }
}
