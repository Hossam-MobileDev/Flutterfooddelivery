import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/FoodDetail/Food/popular_food_detail.dart';
import 'package:fooddelivery/controllers/popular_product_controller.dart';
import 'package:fooddelivery/controllers/recommended_product_controller.dart';
import 'package:fooddelivery/models/products_model.dart';
import 'package:fooddelivery/routes/route_helper.dart';
import 'package:fooddelivery/utils/app_constants.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/widgets/big_text.dart';
import 'package:fooddelivery/widgets/icon_and_text_widget.dart';
import 'package:fooddelivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  var currentpage = 0.0;
  PageController pageController = PageController(viewportFraction: .85);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentpage = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       GetBuilder<PopularProductController>(builder: (popularProducts){
         return popularProducts.isLoaded? Container(
           //  color: Colors.redAccent,
           height: 320,
           child: PageView.builder(
               controller: pageController,
               itemCount: popularProducts.popularPrroductList.length,
               itemBuilder: (context, position) {
                 return _buildPageItem(position,popularProducts.popularPrroductList[position]);
               }),
         ):CircularProgressIndicator(
           color: AppColors.mainColor,
         );
       }),
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return  new DotsIndicator(
            dotsCount: popularProducts.popularPrroductList.isEmpty?1:popularProducts.popularPrroductList.length,
            position: currentpage,
            decorator:  DotsDecorator(
              color: Colors.black87, // Inactive color
              activeColor: Colors.redAccent,
            ),
          );
        }),
        SizedBox(
          height: 15,
        ),
        Container(
          margin: EdgeInsets.only(left: 30),
          child: Row(
            children: [BigText(text: "Recommended")],
          ),
        ),
      GetBuilder<RecommendedProductController>(builder: (recommededProduct){
        return recommededProduct.isLoaded?  ListView.builder(
            itemCount: recommededProduct.recomendedPrroductList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, possition) {
              return GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getRecommendedFood(possition,"home"));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20,bottom: 10),
                  child: Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                image: NetworkImage(AppConstants.BASE_URL+"/uploads/"+recommededProduct.recomendedPrroductList[possition].img!),

                                //  image: AssetImage("assets/image/food0.png")
                              )
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),

                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   BigText(text: recommededProduct.recomendedPrroductList[possition].name!),
                                   SmallText(text: "yeew uweuee"),

                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                   )

                                 ],
                               )
                             )
                            ),
                          ),

                      ],
                    ),
                  ),
                ),
              );
            }):CircularProgressIndicator(
          color: AppColors.mainColor,
        );
      })
      ],
    );
  }

  _buildPageItem(int index, ProductModel popularProduct) {
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            Get.toNamed(RouteHelper.getPopularFood(index,"home"));
          },
          child: Container(
            height: 220,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Color(0xFF89dad0) : Color(0xFF5c524f),
                image: DecorationImage(
               //   image: AssetImage("assets/image/food0.png"),
                  image: NetworkImage(AppConstants.BASE_URL+"/uploads/"+popularProduct.img!),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 120,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: popularProduct.name!),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();

  }
}
