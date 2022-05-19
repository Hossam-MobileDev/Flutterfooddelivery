import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/controllers/cart_controller.dart';
import 'package:fooddelivery/controllers/popular_product_controller.dart';
import 'package:fooddelivery/dimensions.dart';
import 'package:fooddelivery/home/main_food_page.dart';
import 'package:fooddelivery/pages/cart_page.dart';
import 'package:fooddelivery/routes/route_helper.dart';
import 'package:fooddelivery/utils/app_constants.dart';
import 'package:fooddelivery/widgets/app_icon.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
final String page;
  PopularFoodDetail({Key? key, required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularPrroductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  height: 300,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(AppConstants.BASE_URL +
                              "/uploads/" +
                              product.img!))),
                )),
            Positioned(
                top: 45,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if(page=="cart-page"){
                            Get.to(() =>CartPage());
                          }
                         else Get.to(RouteHelper.getInitial());
                        },
                        child: AppIcon(icon: Icons.arrow_back_ios)),
                    // AppIcon(icon: Icons.shopping_bag_outlined)
                    GetBuilder<PopularProductController>(
                        builder: (popcontroller) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap:(){
Get.to(()=>CartPage());
                      },
                              child: AppIcon(icon: Icons.shopping_bag_outlined)),
                          popcontroller.totalItems >= 1
                              ? Positioned(
                            right:0,top:0,
                                child: AppIcon(icon: Icons.circle,size: 20,
                            iconColor: Colors.transparent,backgroundColor: AppColors.mainColor,),
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
                )),
            Positioned(
                left: 0,
                right: 0,
                top: 250,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  height: 300,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: product.name!,
                        size: 26,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              children: List.generate(
                                  5,
                                  (index) => Icon(
                                        Icons.star,
                                        color: AppColors.mainColor,
                                        size: 15,
                                      )),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SmallText(text: "4.5"),
                          SizedBox(
                            width: 10,
                          ),
                          SmallText(text: "1287"),
                          SizedBox(
                            width: 10,
                          ),
                          SmallText(text: "comments")
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          IconAndTextWidget(
                              iconData: Icons.circle_sharp,
                              text: "normal",
                              iconColor: AppColors.iconColor1),
                          IconAndTextWidget(
                              iconData: Icons.location_on,
                              text: "1.7km",
                              iconColor: AppColors.mainColor),
                          IconAndTextWidget(
                              iconData: Icons.access_time_rounded,
                              text: "32min",
                              iconColor: AppColors.iconColor2),
                        ],
                      ),
                      BigText(text: "hossam"),
                      Expanded(
                          child: SingleChildScrollView(
                              child: Text(product.description!))),
                    ],
                  ),
                )),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularproductControler) {
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
                        GestureDetector(
                            onTap: () {
                              popularproductControler.setQuantity(false);
                            },
                            child: Icon(
                              Icons.remove,
                              color: AppColors.signColor,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        // BigText(text: popularproductControler.quantity.toString()),
                        BigText(
                            text:
                                popularproductControler.inCartItems.toString()),

                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              popularproductControler.setQuantity(true);
                            },
                            child: Icon(
                              Icons.add,
                              color: AppColors.signColor,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    color: Colors.amber,
                    child: GestureDetector(
                        onTap: () {
                          popularproductControler.addItem(product);
                        },
                        child: Center(
                            child: BigText(
                          text: "\$ ${product.price!} | Add to cart",
                        ))),
                  )
                ],
              ),
            );
          },
        ));
  }
}
