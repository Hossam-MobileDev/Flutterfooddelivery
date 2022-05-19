import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/controllers/cart_controller.dart';
import 'package:fooddelivery/controllers/popular_product_controller.dart';
import 'package:fooddelivery/controllers/recommended_product_controller.dart';
import 'package:fooddelivery/home/main_food_page.dart';
import 'package:fooddelivery/routes/route_helper.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/widgets/app_icon.dart';
import 'package:fooddelivery/widgets/big_text.dart';
import 'package:fooddelivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../utils/app_constants.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 20,
              right: 20,
              top: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(MainFoodPage());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: 24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: 24,
                  ),
                ],
              )),
          Positioned(
              top: 80,
              left: 20,
              right: 20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: 15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController) {
                    var cartList = cartController.getItems;
                    return ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (_, index) {
                          return Container(
                            height: 80,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var popularIndex =
                                        Get.find<PopularProductController>()
                                            .popularPrroductList
                                            .indexOf(cartList[index].product);
                                    if (popularIndex >= 0) {
                                      Get.toNamed(RouteHelper.getPopularFood(
                                          popularIndex,"cart-page"));
                                    } else {
                                      var recommendIndex = Get.find<
                                              RecommendedProductController>()
                                          .recomendedPrroductList
                                          .indexOf(cartList[index].product);
                                      Get.toNamed(
                                          RouteHelper.getRecommendedFood(
                                              recommendIndex,"cart-page"));
                                    }
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL +
                                                  "/uploads/" +
                                                  cartController
                                                      .getItems[index].img!),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Container(
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                          text: cartController
                                              .getItems[index].name!),
                                      SmallText(text: "spiceyy"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            text: cartController
                                                .getItems[index].price
                                                .toString(),
                                            color: Colors.redAccent,
                                          ),
                                          Container(
                                            color: Colors.brown,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          cartList[index]
                                                              .product!,
                                                          -1);
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color:
                                                          AppColors.signColor,
                                                    )),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                // BigText(text: popularproductControler.quantity.toString()),
                                                BigText(
                                                    text: cartList[index]
                                                        .quantity
                                                        .toString()),

                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          cartList[index]
                                                              .product!,
                                                          1);
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color:
                                                          AppColors.signColor,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          );
                        });
                  }),
                ),
              ))
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartControler) {
            return Container(
              height: 80,
              padding: EdgeInsets.only(right: 5, left: 5),
              color: Colors.grey,
/*
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.remove,color: AppColors.signColor,),
              SizedBox(width: 5,),
              BigText(text: popularproductControler.quantity.toString()),
              SizedBox(width: 5,),
              GestureDetector(
                  onTap: (){
                    popularproductControler.setQuantity(true);
                  },
                  child: Icon(Icons.add,color: AppColors.mainColor,))
            ],
          ),
*/
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    color: Colors.brown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        SizedBox(
                          width: 5,
                        ),
                        // BigText(text: popularproductControler.quantity.toString()),
                        BigText(
                            text:"\$ "+
                            cartControler.totalAmount.toString()),

                        SizedBox(
                          width: 5,
                        ),

                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    color: Colors.amber,
                    child: GestureDetector(
                        onTap: () {
                         // popularproductControler.addItem(product);
                        },
                        child: Center(
                            child: BigText(
                              text: "Checkout",
                            ))),
                  )
                ],
              ),
            );
          },
        )
    );


  }
}
