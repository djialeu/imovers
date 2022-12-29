import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom/big_text.dart';
import '../../custom/custom_icon.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppDimensions.height180,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: AppDimensions.height70,
                  width: AppDimensions.width80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo_v2.png"),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                Row(
                  children: [
                    // Search icon
                    InkWell(
                      onTap:(){

                      },
                      child: Icon(Icons.search,color: Colors.black54,size: AppDimensions.icon40,)),
                    SizedBox(width: AppDimensions.width15,),
                    // Notification Icon
                    InkWell(
                      onTap: (){

                      },
                      child: CustomIcon(
                        icon: Icons.notifications_active,
                        size: AppDimensions.icon40,
                        iconColor:Colors.black54,
                      ),
                    )
                    //Icon(Icons.notifications_none_outlined,color: Colors.black54,size: 30,),
                  ],
                ),

              ],
            ),
            _customFilterIconList()
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppDimensions.height10,),
            Padding(
              padding: EdgeInsets.only(left: AppDimensions.width10),
              child: BigText(
                text: "Activité Populaire",
                fontWeight: FontWeight.bold,
                size: AppDimensions.font23,
                textColor:AppColors.mainColor,
              ),
            ),
            _customAdsList(),
            SizedBox(height: AppDimensions.height5,),
            Padding(
              padding: EdgeInsets.only(left: AppDimensions.width10, right: AppDimensions.width5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(
                    text: "Logement recommandé",
                    fontWeight: FontWeight.bold,
                    size: AppDimensions.font23,
                    textColor:AppColors.mainColor,
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: CustomIcon(
                      icon: Icons.arrow_right_alt_rounded,
                      iconColor: Colors.white,
                      size: AppDimensions.icon35,
                      backgroundColor: AppColors.mainColor,
                    ),
                  )
                ],
              ),
            ),

           _customHorizontalList()

            // _customHorizontalList(),

          ],
        ),
      ),

    );
  }
  _customFilterIconList(){
    return Container(
      height: AppDimensions.height100,
      decoration: BoxDecoration(
        //color: Colors.grey.shade100
      ),
      child:ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.all(10),
              //height: 350,
              width: AppDimensions.width200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radius5),
                 border:Border.all(
                   color: Colors.black12,
                   width: 1
                 )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.house,size: AppDimensions.icon40,color: AppColors.redSecondaryColor,),
                  BigText(text: "Demenagement",size: AppDimensions.font22,fontWeight: FontWeight.bold,textColor: AppColors.bodyTextColor,)
                ],
              ),
            );
          }),

    );
  }
  _customAdsList(){
    return Container(
      height: AppDimensions.height250,
      child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.all(AppDimensions.width5),
              //height: 350,
              width: AppDimensions.width300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radius20),
                border: Border.all(
                  width: 2,
                  color : AppColors.mainColor
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/image_1.jpg"),
                  fit: BoxFit.cover
                )
                //color: AppColors.redSecondaryColor
              ),
            );
          }),
    );
  }
  _customHorizontalList(){
    return Container(
      height: AppDimensions.height420,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.all(10),
            //height: 350,
            width: AppDimensions.width400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radius40),
              color: Colors.transparent,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  offset: Offset(4, 4),
                  spreadRadius: 5
                )
              ]
            ),
            child: Column(
              children: [
                Container(
                  height: AppDimensions.height300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/image_1.jpg"),
                      fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radius40),

                    color: AppColors.mainColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: AppDimensions.width5,right: AppDimensions.width5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              BigText(
                                text: "\$200,000",
                                fontWeight:FontWeight.bold,
                                size: AppDimensions.font35,
                                textColor: AppColors.mainColor),
                            ],
                          ),
                          SizedBox(width: AppDimensions.width10,),
                          BigText(text: "Jenison, MI31231, SF",
                              fontWeight:FontWeight.bold,
                              size: AppDimensions.font20,
                              textColor: AppColors.bodyTextColor),
                        ],
                      ),
                      SizedBox(height: AppDimensions.height5,),
                      BigText(
                        text: "4 bedrooms/ 2 bathrooms/ 14234 sqft",
                        fontWeight:FontWeight.bold,
                        size: AppDimensions.font20,
                        textColor: AppColors.mainColor),



                    ],
                  ),
                )

              ],
            ),
          );
        }),
    );
  }
}
