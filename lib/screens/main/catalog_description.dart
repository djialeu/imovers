import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom/big_text.dart';
import '../../custom/custom_icon.dart';
import '../../custom/small_text.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';


class CatalogDescription extends StatefulWidget {
  const CatalogDescription({Key? key}) : super(key: key);

  @override
  State<CatalogDescription> createState() => _CatalogDescriptionState();
}

class _CatalogDescriptionState extends State<CatalogDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [

          SliverAppBar(
            pinned: true,
            expandedHeight: AppDimensions.height620,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIcon(icon: Icons.arrow_back,backgroundColor: AppColors.mainColor,iconColor: Colors.white,size: AppDimensions.icon30,),
              ],
            ),
            toolbarHeight: AppDimensions.height150,
            flexibleSpace: FlexibleSpaceBar(
              background:  Column(
                children: [
                  Container(
                    height: AppDimensions.height350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppDimensions.radius50),
                          bottomRight:  Radius.circular(AppDimensions.radius50),
                        ),
                        image: DecorationImage(
                            image: AssetImage("assets/images/image_1.jpg"),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  SizedBox(height: AppDimensions.height10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                              text: "\$200,000",
                              fontWeight:FontWeight.bold,
                              size: AppDimensions.font35,
                              textColor: AppColors.mainColor),
                          BigText(text: "Jenison, MI31231, SF",
                              fontWeight:FontWeight.bold,
                              size: AppDimensions.font20,
                              textColor: AppColors.bodyTextColor),
                        ],
                      ),
                      Container(
                        // margin: EdgeInsets.only(
                        //     top: AppDimensions.height20,
                        //     bottom: AppDimensions.height10,
                        //     right: AppDimensions.width20,
                        //     left: AppDimensions.width20),
                        height:AppDimensions.height70,
                        width: AppDimensions.width200,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.bodyTextColor,
                            ),
                            borderRadius: BorderRadius.circular(AppDimensions.radius10)
                        ),
                        child: Center(
                          child: BigText(
                              text: "25/10/2021 at 09:19AM",
                              fontWeight:FontWeight.bold,
                              size: AppDimensions.font17,
                              textColor: AppColors.mainColor
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(AppDimensions.height180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: AppDimensions.width25,top: AppDimensions.height50),
                    child: BigText(
                        text: "House Information",
                        fontWeight:FontWeight.bold,
                        size: AppDimensions.font25,
                        textColor: AppColors.mainColor),
                  ),
                  _customHorizontalView()
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.width15),
              child: SmallText(
                  text: "La Structure Organisationnelle du projet"
                      " ou Organizational Breakdown Structure (en Anglais)"
                      " est un schéma qui représente les responsabilités de chaque "
                      "membre pour chaque tache d’un projet. Elle peut se présenter sous "
                      "forme d’un model ou organigramme bien structuré qui identifie de "
                      "façon très précis les rôles et responsabilité de chaque acteur dans"
                      " la réalisation de chaque partie d’un projet."
                      "La Structure Organisationnelle du projet"
                      " ou Organizational Breakdown Structure (en Anglais)"
                      " est un schéma qui représente les responsabilités de chaque "
                      "membre pour chaque tache d’un projet. Elle peut se présenter sous "
                      "forme d’un model ou organigramme bien structuré qui identifie de "
                      "façon très précis les rôles et responsabilité de chaque acteur dans"
                      " la réalisation de chaque partie d’un projet."
                      "La Structure Organisationnelle du projet"
                      " ou Organizational Breakdown Structure (en Anglais)"
                      " est un schéma qui représente les responsabilités de chaque "
                      "membre pour chaque tache d’un projet. Elle peut se présenter sous "
                      "forme d’un model ou organigramme bien structuré qui identifie de "
                      "façon très précis les rôles et responsabilité de chaque acteur dans"
                      " la réalisation de chaque partie d’un projet.",
                  fontWeight:FontWeight.bold,
                  textAlign: TextAlign.justify,

                  textSize: AppDimensions.font22,
                  textColor: AppColors.bodyTextColor),
            ),
          )

        ],
      ),
      bottomNavigationBar: Container(
        height: AppDimensions.height100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: AppDimensions.height80,
              width: AppDimensions.screenWidth/2.1,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(AppDimensions.radius5)
              ),
              child: Center(
                child: BigText(
                    text: "Message",
                    fontWeight:FontWeight.bold,
                    size: AppDimensions.font25,
                    textColor: Colors.white),
              ),
            ),
            Container(
              height: AppDimensions.height80,
              width: AppDimensions.screenWidth/2.1,
              decoration: BoxDecoration(
                  color: AppColors.redSecondaryColor,
                  borderRadius: BorderRadius.circular(AppDimensions.radius5)
              ),
              child: Center(
                child: BigText(
                    text: "Call",
                    fontWeight:FontWeight.bold,
                    size: AppDimensions.font25,
                    textColor: Colors.white),
              ),
            )
          ],
        ),

      ),
    );
  }
  _customHorizontalView(){
    return Container(
      height: AppDimensions.height180,
     // color: Colors.redAccent,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: AppDimensions.height20,
                  bottom: AppDimensions.height10,
                  right: AppDimensions.width20,
                  left: AppDimensions.width20),
                height:AppDimensions.height120,
                width: AppDimensions.width120,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: AppColors.bodyTextColor,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radius10)
                ),
                child: Center(
                  child: BigText(
                      text: "1000",
                      fontWeight:FontWeight.bold,
                      size: AppDimensions.font23,
                      textColor: AppColors.mainColor
                  ),
                ),
              ),

              BigText(
                  text: "Square foot",
                  fontWeight:FontWeight.bold,
                  size: AppDimensions.font20,
                  textColor: AppColors.mainColor),
            ],

          );
      }),
    );
  }
}
