// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:to/style/theme.dart';
//
// import '../../custom/BorderIcon.dart';
// import '../../custom/OptionButton.dart';
// import '../../utils/constants.dart';
// import '../../utils/widget_functions.dart';
// import 'DetailPage.dart';
// import 'LandingPage.dart';
//
// class AnnonceScreen extends StatefulWidget{
//   @override
//   _AnnonceScreenState createState() => _AnnonceScreenState();
//
// }
//
// class _AnnonceScreenState extends State<AnnonceScreen>{
//
//   _AnnonceScreenState(){
//     categorieSelectedVal = categories[0];
//     typeSelectedVal = types[0];
//     localisationSelectedVal = localisations[0];
//   }
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   final localisation = TextEditingController();
//   final description = TextEditingController();
//
//
//   List<String> categories = ["OK", "Thx"];
//   List<String> types = ["OK", "Thx"];
//   List<String> localisations = ["OK", "Thx"];
//   String categorieSelectedVal = "";
//   String typeSelectedVal = "";
//   String localisationSelectedVal = "";
//   int currentStep = 0;
//
//
//
//   DropdownButtonFormField _dropdownButtonFormField(List<String> elements , int what , String label){
//     return DropdownButtonFormField(
//       value: categorieSelectedVal,
//       items: elements.map((e) => DropdownMenuItem(child: Text(e) , value: e,)).toList(),
//       onChanged: (val){
//         setState(() {
//           if(what == 1){
//             categorieSelectedVal = val as String;
//           }else if(what == 2){
//             typeSelectedVal = val as String;
//           }else if(what == 3){
//             localisationSelectedVal = val as String;
//           }
//
//         });
//       },
//       icon: const Icon(
//         Icons.arrow_drop_down_circle,
//         color: COLOR_BLACK,
//       ),
//       decoration: InputDecoration(
//         prefixIcon: Icon(
//           Icons.grading_sharp,
//           color: COLOR_BLACK,
//         ),
//         labelText: label,
//       ),
//     );
//   }
//
//   List<Step> getSteps() {
//     List<Step> steps = [
//       Step(
//           state: currentStep > 0 ? StepState.complete : StepState.indexed,
//           isActive: currentStep >= 0,
//           title: Text("Main Info"),
//           content: Column(
//             children: <Widget>[
//               _dropdownButtonFormField(categories , 1 , "Choose Category"),
//               addVerticalSpace(20),
//               _dropdownButtonFormField(types, 2 , "Choose Type"),
//               addVerticalSpace(20),
//               _dropdownButtonFormField(types, 3 , "Choose Localisation"),
//               addVerticalSpace(20),
//               TextFormField(decoration: InputDecoration(labelText: "Description"),)
//             ],
//           )
//       ),
//       Step(
//           state: currentStep > 1 ? StepState.complete : StepState.indexed,
//           isActive: currentStep >= 1,
//           title: Text("Features"),
//           content: Column(
//             children: <Widget>[
//               _dropdownButtonFormField(categories , 1 , "Choose Category"),
//               addVerticalSpace(20),
//               _dropdownButtonFormField(types, 2 , "Choose Type"),
//               addVerticalSpace(20),
//               _dropdownButtonFormField(types, 3 , "Choose Localisation"),
//               addVerticalSpace(20),
//               TextField(
//                 maxLines: 10,
//                 decoration: InputDecoration.collapsed(hintText: "Enter the description here"),
//               )
//             ],
//           )
//       ),
//       Step(
//           state: currentStep > 2 ? StepState.complete : StepState.indexed,
//           isActive: currentStep >= 2,
//           title: Text("Images"),
//           content: Container(child: const Text("Images"),)
//       ),
//     ].toList() ;
//     return steps;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final ThemeData themeData = Theme.of(context);
//     double padding = 25;
//     final sidePadding = EdgeInsets.symmetric(horizontal: padding);
//
//     return SafeArea(
//       child: Scaffold(
//         body: Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(primary: COLOR_BLACK)
//           ),
//           child: Column(
//             children: [
//               addVerticalSpace(padding),
//               Padding(
//                 padding: sidePadding,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       // padding: sidePadding,
//                         children:
//                         [
//                           InkWell(
//                             onTap: (){
//                               Navigator.pop(context);
//                             },
//                             child: BorderIcon(
//                               height: 50,
//                               width: 50,
//                               key: null,
//                               padding: null,
//                               child: Icon(Icons.keyboard_backspace,color: COLOR_BLACK,),
//                             ),
//                           ),
//                         ]
//                     ),
//                     BorderIcon(
//                       height: 50,
//                       width: 50,
//                       child: Icon(
//                         Icons.notifications_active,
//                         color: COLOR_BLACK,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                   padding: sidePadding,
//                   child: Divider(
//                     height: 25,
//                     color: COLOR_GREY,
//                   )),
//               Padding(
//                   padding: sidePadding,
//                   child: Text(
//                     "Make an Notice",
//                     style: themeData.textTheme.headline1,
//                   )),
//               Padding(
//                   padding: sidePadding,
//                   child: Divider(
//                     height: 25,
//                     color: COLOR_GREY,
//                   )),
//               addVerticalSpace(10),
//               Expanded(
//                 child: Stepper(
//                   type: StepperType.horizontal,
//                   steps: getSteps(),
//                   onStepTapped: (step) => setState(() => currentStep = step),
//                   onStepContinue: () {
//                     final isLastStep = currentStep == getSteps().length - 1;
//                     if(isLastStep){
//                       //form here
//                     }
//                     else{
//                       setState(() => currentStep++);
//                     }
//                   },
//                   onStepCancel: () => currentStep == 0 ? null : setState(() => currentStep--),
//                 ),
//               ),
//             ]
//           ),
//         ),
//       ),
//     );
//
//   }
//
//
// }