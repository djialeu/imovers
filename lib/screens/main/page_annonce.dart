import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';

class MakeAnnouncement extends StatefulWidget {
  const MakeAnnouncement({Key? key}) : super(key: key);

  @override
  State<MakeAnnouncement> createState() => _MakeAnnouncementState();
}

class _MakeAnnouncementState extends State<MakeAnnouncement> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 1,
        toolbarHeight: 130,
        title: Column(
          children: [
            Row(
              children: [
                _customIconWidget(Icons.newspaper_outlined,Colors.white),
                _customTextWidget("Annonce",AppDimensions.font25,FontWeight.bold, Colors.white)
              ],
            ),
            SizedBox(height: AppDimensions.height10,),
            TabBar(
              controller:  tabController,
              indicatorColor: Colors.redAccent,
              //indicatorWeight: 10,
              labelColor: Colors.redAccent,
              unselectedLabelColor: Colors.white.withOpacity(0.7),

              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),

              tabs: [
                Container(
                  height: AppDimensions.height35,
                  child: Center(
                    child: Text(
                      "Maison",
                      style: TextStyle(
                        fontSize: AppDimensions.font20,fontWeight: FontWeight.bold
                      )
                    ),
                  )
                ),
                Container(
                    height: AppDimensions.height35,
                    child: Center(
                      child: Text(
                          "Agence",
                          style: TextStyle(
                              fontSize: AppDimensions.font20,fontWeight: FontWeight.bold
                          )
                      ),
                    )
                ),
                Container(
                    height: AppDimensions.height35,
                    child: Center(
                      child: Text(
                          "Location",
                          style: TextStyle(
                              fontSize: AppDimensions.font20,fontWeight: FontWeight.bold
                          )
                      ),
                    )
                ),
              ],
            )
          ],
        ),
      ),
      body:TabBarView(
        controller: tabController,
        children: [
          _customListWidget(),
          _customListWidget(),
          _customListWidget()
        ],
      ),


    );
  }

  // Customized Text Function
  _customTextWidget(String text, [double? size, FontWeight? fontweight, Color? color, TextAlign? textAlign]){
    return Text(
      text,
      textAlign: textAlign ,
      style: TextStyle(
        fontWeight: fontweight==null?FontWeight.normal:fontweight,
        fontSize: size==null? AppDimensions.font20:size,
        color: color==null ? Colors.black:color,
      ),
    );
  }

  // Customized Icon Widget
  _customIconWidget(IconData icon, [Color? iconColor, Color? backgroundColor,double? radius ,double? size]){
    return CircleAvatar(
      backgroundColor:  backgroundColor == null? Colors.transparent: backgroundColor,
      radius: radius==null ? AppDimensions.radius30: radius,
      child: Icon(
        icon,
        size: size==null ? 24 : size,
        color: iconColor==null ? Colors.black : iconColor,
      ),
    );
  }

  // Custom Tabs
  _customListWidget(){
    return ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context,index){
        return Container(
          //height: 300,

          margin: EdgeInsets.only(bottom: AppDimensions.height10,top: AppDimensions.height15,
              left: AppDimensions.width5,right:  AppDimensions.width5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radius20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.shade400,
                offset: Offset(3, 5),
                spreadRadius: 5,
                blurRadius: 5
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image(image: AssetImage("assets/images/Profile.png"),fit: BoxFit.cover,),
                    ),
                    SizedBox(width: AppDimensions.width5,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _customTextWidget("SIG ltd.",AppDimensions.font20,FontWeight.bold),
                        _customTextWidget("20 Mai 2022"),
                      ],
                    )
                  ],
                ),
              ),
              //SizedBox(height: AppDimensions.height5,),
              Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: AssetImage("assets/images/im1.jpg",),fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: AppDimensions.width5),
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined,size: AppDimensions.icon30),
                    SizedBox(width: AppDimensions.width5,),
                    _customTextWidget("Yaounde",
                        AppDimensions.font22,FontWeight.w500,Colors.black.withOpacity(0.8)),

                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: AppDimensions.width5),
                child: Row(
                  children: [
                    Icon(Icons.monetization_on_outlined,size: AppDimensions.icon30,),
                    SizedBox(width: AppDimensions.width5,),
                    _customTextWidget("20500FCFA / Mois",
                        AppDimensions.font22,FontWeight.w500,Colors.black.withOpacity(0.8)),

                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.all(AppDimensions.width10),
                child: Column(
                  children: [
                    _customTextWidget("Description du c'ontenu cest ici"
                        "Description du c'ontenu cest ici"
                        "Description du c'ontenu cest ici"
                        "Description du c'ontenu cest ici"
                        "Description du c'ontenu cest ici",
                      AppDimensions.font20,FontWeight.w400,Colors.black.withOpacity(0.5)),

                  ],
                ),
              ),
              SizedBox(height: AppDimensions.height5,)
            ],
          ),
        );
      });
  }



}
