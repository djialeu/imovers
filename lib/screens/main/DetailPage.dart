import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newimovers/models/ChatParams.dart';
import 'package:newimovers/screens/chat/chatScreen.dart';
import 'package:newimovers/utils/app_dimensions.dart';
import '../../custom/BorderIcon.dart';
import '../../custom/OptionButton.dart';
import '../../models/Annonce.dart';
import '../../repositories/repositories.dart';
import '../../utils/constants.dart';
import '../../utils/custom_functions.dart';
import '../../utils/widget_functions.dart';

class DetailPage extends StatelessWidget {
  final mainUrl = "${Repository.mainUrl}/image/";
  final Annonce itemData;
  final AppUser connectedUser;

  DetailPage({Key? key,required this.itemData, required this.connectedUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = AppDimensions.width25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_WHITE,
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(itemData.filenames!.isEmpty ? "assets/images/image_2.jpg" : mainUrl + itemData.filenames!.split(";").first),
                        Positioned(
                          width: size.width,
                          top: padding,
                          child: Padding(
                            padding: sidePadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: BorderIcon(
                                    height: AppDimensions.height50,
                                    width: AppDimensions.width50,
                                    child: Icon(Icons.keyboard_backspace,color: COLOR_BLACK,),
                                  ),
                                ),
                                BorderIcon(
                                  height: AppDimensions.height50,
                                  width: AppDimensions.width50,
                                  child: Icon(Icons.favorite_border,color: COLOR_BLACK,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(formatCurrency(itemData.price!),style: themeData.textTheme.headline4,),
                              addVerticalSpace(5),
                              Text("${itemData.localisation}",style: themeData.textTheme.bodyLarge,),
                            ],
                          ),
                          BorderIcon(
                            padding:  EdgeInsets.symmetric(vertical: AppDimensions.font15, horizontal: AppDimensions.font15),
                            child: Text(DateFormat('dd/MM/yy, HH:mm').format(DateTime.fromMillisecondsSinceEpoch(itemData.datepublication! * 1000)),
                              style: themeData.textTheme.bodyMedium,),)
                        ],
                      ),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text("Information sur la maison",style: themeData.textTheme.headline6,),
                    ),
                    addVerticalSpace(padding),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          InformationTile(content: "${itemData.superficie}",name: "M\u00B2",),
                          InformationTile(content: "${itemData.nbChambres}",name: "Chambres",),
                          InformationTile(content: "${itemData.nbDouches}",name: "Douches",),
                          InformationTile(content: "${itemData.nbGarages}",name: "Garage",)
                        ],
                      ),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text(itemData.description!
                        ,textAlign: TextAlign.justify , style: TextStyle(fontFamily: 'Raleway' , fontSize: 20 , fontWeight: FontWeight.w300 , fontStyle: FontStyle.italic)),
                    ),
                    // addVerticalSpace(AppDimensions.height100),
                  ],
                ),
              ),
              Positioned(
                bottom: AppDimensions.height20,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width*0.35,
                      child: FlatButton(
                          color: COLOR_DARK_BLUE,
                          splashColor: Colors.white.withAlpha(55),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          onPressed: () => pushToSms(context, itemData.author!.username!),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.message,
                                color: COLOR_WHITE,
                              ),
                              addHorizontalSpace(10),
                              Text(
                                "Message",
                                style: TextStyle(color: COLOR_WHITE),
                              )
                            ],
                          )),
                      ),
                    addHorizontalSpace(AppDimensions.width10),
                    Container(
                      width: size.width*0.35,
                      child: FlatButton(
                          color: COLOR_DARK_BLUE,
                          splashColor: Colors.white.withAlpha(55),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          onPressed: () => pushToSms(context, itemData.author!.username!),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.call,
                                color: COLOR_WHITE,
                              ),
                              addHorizontalSpace(10),
                              Text(
                                "Appel",
                                style: TextStyle(color: COLOR_WHITE),
                              )
                            ],
                          )),
                      ),
                    // OptionButton(text: "Message",icon: Icons.message,width: size.width*0.35,onclick: () => pushToSms(context), ),

                    // OptionButton(text: "Call",icon: Icons.call,width: size.width*0.35,onclick: () => pushToSms(context)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void pushToSms(BuildContext context , String chattername){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatScreen(chatParams: ChatParams(fromUser: connectedUser, toUser: itemData.author!.username!))));
  }
}

class InformationTile extends StatelessWidget{

  final String? content;
  final String? name;

  const InformationTile({Key? key,this.content,this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final double tileSize = size.width*0.20;
    return Container(
      margin: EdgeInsets.only(left: AppDimensions.width20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BorderIcon(
              width: AppDimensions.width100,
              height: tileSize,
              child: Text(content!,style: themeData.textTheme.headline6,)),
          addVerticalSpace(AppDimensions.height15),
          Text(name!,style: themeData.textTheme.bodyLarge,)
        ],
      ),
    );

  }

}
