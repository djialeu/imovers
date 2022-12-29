import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/app_dimensions.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 1,
        toolbarHeight: AppDimensions.height70,
        title: Row(
          children: [
            InkWell(
              onTap: (){},
              child:  _customIconWidget(Icons.arrow_back),
            ),
            _customTextWidget("Aide",AppDimensions.font25,FontWeight.bold,)
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: AppDimensions.height5,),
            _customTextWidget(
                "Lorem ipsum dolor sit amet consectetur, adipisicing elit. "
                    "Sapiente blanditiis impedit expedita repellendus distinctio neque dolores, "
                    "minus debitis sequi! Nam a earum commodi recusandae officiis, "
                    "alias non amet voluptates eos?"
                    "Lorem ipsum dolor sit amet consectetur, adipisicing elit. "
                    "Sapiente blanditiis impedit expedita repellendus distinctio neque dolores, "
                    "minus debitis sequi! Nam a earum commodi recusandae officiis, "
                    "alias non amet voluptates eos?"
                    "Lorem ipsum dolor sit amet consectetur, adipisicing elit. "
                    "Sapiente blanditiis impedit expedita repellendus distinctio neque dolores, "
                    "minus debitis sequi! Nam a earum commodi recusandae officiis, "
                    "alias non amet voluptates eos?",
                AppDimensions.font20,
                FontWeight.w400,
                Colors.black.withOpacity(0.4),
                TextAlign.center
            ),
            SizedBox(height: AppDimensions.height10,),
            // Further question on email
            _customTextWidget("Avez vous des questions? envoyez nous un email"),
            SizedBox(height: AppDimensions.height5,),
           InkWell(
             onTap: (){

             },
             child:  _customIconWidget(Icons.email_outlined, Colors.redAccent, Colors.white,40,30),
           )

          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: AppDimensions.height60,

        child:  Column(
          children: [
            _customTextWidget("Copyright © 2022 Imovers", AppDimensions.font20,FontWeight.bold,Colors.redAccent.withOpacity(1)),
            _customTextWidget("Version : 1.0",AppDimensions.font20),
          ],
        ),
      )
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
}
