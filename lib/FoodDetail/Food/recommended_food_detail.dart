import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooddelivery/controllers/popular_product_controller.dart';
import 'package:fooddelivery/controllers/recommended_product_controller.dart';
import 'package:fooddelivery/pages/cart_page.dart';
import 'package:fooddelivery/routes/route_helper.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/widgets/app_icon.dart';
import 'package:fooddelivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId,required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recomendedPrroductList[pageId];
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 60,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
             if(page=="cart-page") {
               Get.to(RouteHelper.getCartPage());
             }else{
               Get.to(RouteHelper.getInitial());
             }
        },
                      child: AppIcon(icon: Icons.clear)),
                 // AppIcon(icon: Icons.shopping_cart_outlined)
                  GetBuilder<PopularProductController>(
                      builder: (popcontroller) {
                        return Stack(
                            children: [
                              AppIcon(icon: Icons.shopping_bag_outlined),
                              popcontroller.totalItems >= 1
                                  ? Positioned(
                                right:0,top:0,
                                child: GestureDetector(
                                  onTap:(){
Get.to(CartPage());
                        },
                                  child: AppIcon(icon: Icons.circle,size: 20,
                                    iconColor: Colors.transparent,backgroundColor: AppColors.mainColor,),
                                ),
                              )
                                  : Container(),
                              popcontroller.totalItems>=1?
                              Positioned(
                                  right:3,top:3,
                                  child: BigText(
                                    text: popcontroller.totalItems.toString(),size: 12,color: Colors.white,)
                              ):Container()
                            ]
                        );
                      })
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  color: Colors.white,
                  child: Center(child: Text(product.name!)),
                  width: double.maxFinite,
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL + "/uploads/" + product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    child: Text(product.description!),
                    margin: EdgeInsets.only(left: 20, right: 20),
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (popController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          popController.setQuantity(false);
                        },
                        child: AppIcon(
                            iconSize: 24,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor,
                            icon: Icons.remove)),
                    BigText(
                      text:
                          "\$ ${product.price!} X ${popController.inCartItems}",
                      color: AppColors.mainBlackColor,
                      size: 26,
                    ),
                    GestureDetector(
                        onTap: () {
                          popController.setQuantity(true);
                        },
                        child: AppIcon(
                            iconSize: 24,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor,
                            icon: Icons.add)),
                  ],
                ),
              ),
              Container(
                //height: 80,
                padding: EdgeInsets.only(top: 30, bottom: 30,right: 30,left: 30),
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                      size: 35,
                    ),
                    GestureDetector(
                      onTap: (){
                        popController.addItem(product);
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Center(
                          child: BigText(
                            text: "\$ ${product.price!}|Add to cart",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }));
  }
}
