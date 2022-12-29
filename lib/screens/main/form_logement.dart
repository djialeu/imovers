import 'dart:developer';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newimovers/models/Annonce.dart';
import 'package:newimovers/screens/main/LandingScreen.dart';
import 'package:newimovers/screens/main/main_screen.dart';
import 'package:newimovers/utils/widget_functions.dart';
import '../../custom/BorderIcon.dart';
import '../../repositories/repositories.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/constants.dart';
import '../../style/theme.dart' as Style;


class FormLogement extends StatefulWidget {
  final UserRepository userRepository;
  final LogementRepository logementRepository;
  final CategorieRepository categorieRepository;
  final AppUser connectedUser;
  const FormLogement({Key? key, required this.userRepository, required this.logementRepository, required this.categorieRepository, required this.connectedUser}) : super(key: key);

  @override
  State<FormLogement> createState() => _FormLogementState(logementRepository,userRepository,categorieRepository,connectedUser);
}

class _FormLogementState extends State<FormLogement> {
  final _pageController = PageController();
  final LogementRepository logementRepository;
  final UserRepository userRepository;
  final CategorieRepository categorieRepository;

  TextEditingController nombreCite = TextEditingController();
  TextEditingController nombrePiece = TextEditingController();
  TextEditingController ville = TextEditingController();
  TextEditingController cite = TextEditingController();
  TextEditingController arrondissement = TextEditingController();
  TextEditingController nomQuartier = TextEditingController();
  TextEditingController action = TextEditingController();
  TextEditingController photo = TextEditingController();

  TextEditingController prix = TextEditingController();
  TextEditingController nombreSalon = TextEditingController();
  TextEditingController nombreChambre = TextEditingController();
  TextEditingController nombreDouche = TextEditingController();
  TextEditingController nombreCuisine = TextEditingController();
  TextEditingController Superficie = TextEditingController();
  TextEditingController photo1 = TextEditingController();
  TextEditingController photo2 = TextEditingController();
  TextEditingController photo3 = TextEditingController();
  TextEditingController photo4 = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController garage = TextEditingController();

  final AppUser connectedUser;

  final _formKey = GlobalKey<FormState>();
  final _imageKey = GlobalKey<FormState>();
  final generalFormKey = GlobalKey<FormState>();
  final imageFormKey = GlobalKey<FormState>();

  String? btnSelectedVal;
  String? selectedValue;
  Categorie? selectedCategorie ;
  Categorie? selectedType ;
  Quartier? selectedQuartier ;

  List<Categorie> categories = [];
  List<Categorie> types = [];
  List<Quartier> quartiers = [];

  File? file;
  List<File> files=[];
  bool already = false;

  int imageTimes = 0;

  _FormLogementState(this.logementRepository , this.userRepository, this.categorieRepository, this.connectedUser);


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    double padding = AppDimensions.width20;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return SafeArea(
        child: Scaffold(
        body: Container(
          child: PageView(
            scrollDirection: Axis.vertical,
            controller:_pageController,
            children: [
              // _firstPageView(),
              generalView(context),
              imageView(context),
            ],
          ),
        )

    ),
      );
  }

  saveAnnouncement() async{
    var result = await logementRepository.saveLogement(selectedCategorie!.name!, selectedType!.name!,selectedQuartier!.name!, "APPROVED", double.parse(prix.text),int.parse(nombreCite.text),int.parse(nombrePiece.text), description.text ,int.parse(nombreChambre.text), "Rue Bastos 211",int.parse(nombreChambre.text), int.parse(nombreSalon.text), int.parse(nombreCuisine.text) ,int.parse(nombreCuisine.text),int.parse(Superficie.text) , garage.text, files);
    // log(result!["description"]);
    return result;
  }

  InputDecoration myInputDecoratinon(String label, Icon icon){
    return InputDecoration(
      prefixIcon: icon,
      // prefixIcon: Icon(EvaIcons.emailOutline, color: Colors.black54),
      enabledBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(AppDimensions.font25)),
      focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(30.0)),
      contentPadding: EdgeInsets.only(
          left: AppDimensions.width10, right: AppDimensions.width10),
      labelText: label,
      hintStyle: TextStyle(
          fontSize: 12.0,
          color: Style.Colors.grey,
          fontWeight: FontWeight.w500),
      labelStyle: TextStyle(
          fontSize: 12.0,
          color: Colors.black54,
          fontWeight: FontWeight.w500),
    );
  }


  generalView(BuildContext context){

    final TextEditingController? _userEditTextController = TextEditingController();
    final ThemeData themeData = Theme.of(context);
    double padding = AppDimensions.width20;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SingleChildScrollView(
      key: _formKey,
      child: Container(
        child: Form(
          key: generalFormKey,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(AppDimensions.width20),
                  Padding(
                    padding: sidePadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: BorderIcon(
                            height: AppDimensions.height60,
                            width: AppDimensions.width80,
                            child: Icon(
                              Icons.keyboard_arrow_left_sharp,
                              color: COLOR_BLACK,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            // if(generalFormKey.currentState!.validate()){
                              _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut)
                            // }
                          },
                          child: BorderIcon(
                            height: AppDimensions.height60,
                            width: AppDimensions.width80,
                            child: Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: COLOR_BLACK,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(AppDimensions.height60),
                  Padding(
                    padding: sidePadding,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Icon(Icons.add_to_photos_rounded , color: COLOR_BLACK)),
                        addHorizontalSpace(AppDimensions.width20),
                        Center(
                          child: Text(
                            "NOUVELLE ANNONCE",
                            style: themeData.textTheme.headline6,
                          ),
                        ),
                      ]
                    ),
                  ),
                  addVerticalSpace(AppDimensions.height80),
                  Padding(
                    padding: sidePadding,
                    child: Text("1/2 - General Informations" , style: themeData.textTheme.caption),
                  ),
                  Padding(
                    padding: sidePadding,
                    child: Divider(
                      height: AppDimensions.height25,
                      color: COLOR_GREY,
                  )),
                  addVerticalSpace(AppDimensions.height10),

                  Padding(
                    padding: sidePadding,
                    child: FutureBuilder(
                        future: categorieRepository.getCategories(),
                        builder: (context, AsyncSnapshot<List<Categorie>> snapshot) {
                          if(!snapshot.hasData){
                            return new CircularProgressIndicator();
                          }else{
                            categories = snapshot.data!;
                            return DropdownSearch<Categorie>(
                              validator: (Categorie? category) {
                                if(category == null){
                                  return "Type Annonce non valide";
                                }else{
                                  return null;
                                }
                              },
                              // clearButtonProps: ClearButtonProps(isVisible: true),
                              // filterFn: (categorie, filter) => categorie.categorieFilterByName(filter),
                              // compareFn: (i, s) => i.name!.contains(s.name!),
                              // items: categories,
                              items: categories,
                              // asyncItems: (String filter) =>  categorieRepository.getCategories() ,
                              itemAsString: (Categorie category) => category.name!,
                              onChanged: (Categorie? data) => setState(() {
                                selectedCategorie = data;
                                print(selectedCategorie!.name);
                              }),
                              popupProps: PopupProps.menu(
                                fit: FlexFit.loose,
                                //comment this if you want that the items do not takes all available height
                                constraints: BoxConstraints.tightFor(),
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: myInputDecoratinon("Type d'annonce" ,Icon(EvaIcons.shoppingBag, color: Colors.black54)),
                              ),
                            );
                          }
                        }
                    ),
                  ),
                  addVerticalSpace(AppDimensions.width20),
                  Padding(
                    padding: sidePadding,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                      controller: cite,
                      validator: (value) =>
                      value!.isEmpty
                          ? "Nom Cite non valide"
                          : null,
                      keyboardType: TextInputType.text,
                      cursorColor: COLOR_BLACK,
                      decoration: InputDecoration(
                        prefixIcon: Icon(EvaIcons.home, color: Colors.black54),
                        enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(AppDimensions.font25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black54),
                            borderRadius: BorderRadius.circular(30.0)),
                        contentPadding: EdgeInsets.only(
                            left: AppDimensions.width10, right: AppDimensions.width10),
                        labelText: "Nom Cite",
                        hintStyle: TextStyle(
                            fontSize: 12.0,
                            color: Style.Colors.grey,
                            fontWeight: FontWeight.w500),
                        labelStyle: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      ),
                      autocorrect: false,
                    ),
                  ),
                  addVerticalSpace(AppDimensions.width20),
                  Padding(
                    padding: sidePadding,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                      controller: nombreCite,
                      validator: (value) =>
                      value!.isEmpty
                          ? "Nombre de Cite non valide"
                          : null,
                      keyboardType: TextInputType.number,
                      cursorColor: COLOR_BLACK,
                      decoration: InputDecoration(
                        prefixIcon: Icon(EvaIcons.moreHorizontal, color: Colors.black54),
                        enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(AppDimensions.font25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black54),
                            borderRadius: BorderRadius.circular(30.0)),
                        contentPadding: EdgeInsets.only(
                            left: AppDimensions.width10, right: AppDimensions.width10),
                        labelText: "Nombre Cite",
                        hintStyle: TextStyle(
                            fontSize: 12.0,
                            color: Style.Colors.grey,
                            fontWeight: FontWeight.w500),
                        labelStyle: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      ),
                      autocorrect: false,
                    ),
                  ),
                  addVerticalSpace(AppDimensions.width20),
                  Padding(
                    padding: sidePadding,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                      controller: nombrePiece,
                      validator: (value) =>
                      value!.isEmpty
                          ? "Nombre de piece non valide"
                          : null,
                      keyboardType: TextInputType.number,
                      cursorColor: COLOR_BLACK,
                      decoration: InputDecoration(
                        prefixIcon: Icon(EvaIcons.moreHorizontal, color: Colors.black54),
                        enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(AppDimensions.font25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black54),
                            borderRadius: BorderRadius.circular(30.0)),
                        contentPadding: EdgeInsets.only(
                            left: AppDimensions.width10, right: AppDimensions.width10),
                        labelText: "Nombre Piece",
                        hintStyle: TextStyle(
                            fontSize: 12.0,
                            color: Style.Colors.grey,
                            fontWeight: FontWeight.w500),
                        labelStyle: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      ),
                      autocorrect: false,
                    ),
                  ),

                  addVerticalSpace(AppDimensions.width20),
                  Padding(
                    padding: sidePadding,
                    child: FutureBuilder(
                      future: categorieRepository.getTypes(),
                      builder: (context, AsyncSnapshot<List<Categorie>> snapshot) {
                        if(!snapshot.hasData){
                          return new CircularProgressIndicator();
                        }else{
                          types = snapshot.data!;
                          return DropdownSearch<Categorie>(
                            // clearButtonProps: ClearButtonProps(isVisible: true),
                            // filterFn: (categorie, filter) => categorie.categorieFilterByName(filter),
                            // compareFn: (i, s) => i.name!.contains(s.name!),
                            // items: categories,
                            items: types,
                            validator: (Categorie? category) {
                              if(category == null){
                                return "Type Logement non valide";
                              }else{
                                return null;
                              }
                            },
                            // asyncItems: (String filter) =>  categorieRepository.getCategories() ,
                            itemAsString: (Categorie category) => category.name!,
                            onChanged: (Categorie? data) => setState(() {
                              selectedType = data;
                              print(selectedType!.name);
                            }),
                            popupProps: PopupProps.menu(
                              fit: FlexFit.loose,
                              //comment this if you want that the items do not takes all available height
                              constraints: BoxConstraints.tightFor(),
                            ),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: myInputDecoratinon("Type de Logement" , Icon(EvaIcons.questionMarkCircle, color: Colors.black54)),
                            ),
                          );
                        }
                      }
                    ),
                  ),
                  addVerticalSpace(AppDimensions.width20),
                  Padding(
                    padding: sidePadding,
                    child: FutureBuilder(
                        future: categorieRepository.getQuartiers(),
                        builder: (context, AsyncSnapshot<List<Quartier>> snapshot) {
                          if(!snapshot.hasData){
                            print("Snapshot");
                            print(snapshot.data);
                            return new CircularProgressIndicator();
                          }else{
                            quartiers = snapshot.data!;
                            return DropdownSearch<Quartier>(
                              // filterFn: (categorie, filter) => categorie.categorieFilterByName(filter),
                              // compareFn: (i, s) => i.name!.contains(s.name!),
                              // items: categories,
                              items: quartiers,
                              // asyncItems: (String filter) =>  categorieRepository.getCategories() ,
                              itemAsString: (Quartier category) => category.name!,
                              onChanged: (Quartier? data) => setState(() {
                                selectedQuartier = data;
                                print(selectedQuartier!.name);
                              }),
                              validator: (Quartier? quartier) {
                                if(quartier == null){
                                  return "Type Annonce non valide";
                                }else{
                                  return null;
                                }
                              },
                              // clearButtonProps: ClearButtonProps(isVisible: true),
                              popupProps: PopupProps.modalBottomSheet(
                                fit: FlexFit.loose,
                                constraints: BoxConstraints.tightFor(),
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  controller: _userEditTextController,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        print("onpressed");
                                        _userEditTextController!.clear();
                                      },
                                    ),
                                  ),
                                )
                              ),
                              // popupProps: PopupPropsMultiSelection.modalBottomSheet(
                              //   fit: FlexFit.loose ,
                              //   constraints: BoxConstraints.tightFor(),
                              //   isFilterOnline: true,
                              //   showSelectedItems: true,
                              //   showSearchBox: true,
                              //   itemBuilder:null,
                              //   favoriteItemProps: FavoriteItemProps(
                              //     showFavoriteItems: true,
                              //     favoriteItems: (us) {
                              //       return us
                              //           .where((e) => e.name!.contains("Mrs"))
                              //           .toList();
                              //     },
                              //   ),
                              // ),

                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: myInputDecoratinon(
                                    "Quartier du Logement" ,
                                    Icon(EvaIcons.homeOutline, color: Colors.black54),
                                ),
                              ),
                            );
                          }
                        }
                    ),
                  ),
                  addVerticalSpace(AppDimensions.width20),
                  Padding(
                    padding: sidePadding,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                      controller: prix,
                      validator: (value) =>
                      value!.isEmpty
                          ? "Prix non valide"
                          : null,
                      keyboardType: TextInputType.number,
                      cursorColor: COLOR_BLACK,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.money, color: Colors.black54),
                        suffixIcon: Icon(Icons.monetization_on_outlined),
                        enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(AppDimensions.font25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black54),
                            borderRadius: BorderRadius.circular(30.0)),
                        contentPadding: EdgeInsets.only(
                            left: AppDimensions.width10, right: AppDimensions.width10),
                        labelText: "Prix",
                        hintStyle: TextStyle(
                            fontSize: 12.0,
                            color: Style.Colors.grey,
                            fontWeight: FontWeight.w500),
                        labelStyle: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      ),
                      autocorrect: false,
                    ),
                  ),
                  addVerticalSpace(AppDimensions.width20),
                  Padding(
                    padding: sidePadding,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                      controller: description,

                      validator: (value) =>
                      value!.isEmpty
                          ? "Description non valide"
                          : null,
                      maxLines: 10,
                      keyboardType: TextInputType.text,
                      cursorColor: COLOR_BLACK,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.description, color: Colors.black54),
                        enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(AppDimensions.font25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black54),
                            borderRadius: BorderRadius.circular(30.0)),
                        labelText: "Description",
                        hintStyle: TextStyle(
                            fontSize: 12.0,
                            color: Style.Colors.grey,
                            fontWeight: FontWeight.w500),
                        labelStyle: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      ),
                      autocorrect: false,
                    ),
                  ),
                  addVerticalSpace(AppDimensions.height80),
                  Padding(
                    padding: sidePadding,
                    child: Text("1/3 - Details Quantity Informations" , style: themeData.textTheme.caption),
                  ),
                  Padding(
                      padding: sidePadding,
                      child: Divider(
                        height: AppDimensions.height25,
                        color: COLOR_GREY,
                      )),
                  addVerticalSpace(AppDimensions.width20),
                  Padding(
                    padding: sidePadding,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                controller: Superficie,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.area_chart, color: Colors.black54),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(AppDimensions.font25)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black54),
                                        borderRadius: BorderRadius.circular(30.0)),
                                    contentPadding: EdgeInsets.only(
                                        left: AppDimensions.width10, right: AppDimensions.width10),
                                    labelText: "Superficie en m\u00B2"
                                ),
                              ),
                            ),
                            addHorizontalSpace(AppDimensions.width25),
                            Flexible(
                              child: TextFormField(
                                controller: nombreSalon,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.roofing_rounded, color: Colors.black54),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(AppDimensions.font25)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black54),
                                        borderRadius: BorderRadius.circular(30.0)),
                                    contentPadding: EdgeInsets.only(
                                        left: AppDimensions.width10, right: AppDimensions.width10),
                                    labelText: "Salons"
                                ),
                              ),
                            ),

                          ],
                        ),
                        addVerticalSpace(AppDimensions.width20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                controller: nombreChambre,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.bedroom_parent, color: Colors.black54),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(AppDimensions.font25)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black54),
                                        borderRadius: BorderRadius.circular(30.0)),
                                    contentPadding: EdgeInsets.only(
                                        left: AppDimensions.width10, right: AppDimensions.width10),
                                    labelText: "Chambre"
                                ),
                              ),
                            ),
                            addHorizontalSpace(AppDimensions.width25),
                            Flexible(
                              child: TextFormField(
                                controller: nombreDouche,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.shower, color: Colors.black54),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(AppDimensions.font25)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black54),
                                        borderRadius: BorderRadius.circular(30.0)),
                                    contentPadding: EdgeInsets.only(
                                        left: AppDimensions.width10, right: AppDimensions.width10),
                                    labelText: "Douches"
                                ),
                              ),
                            ),

                          ],
                        ),
                        addVerticalSpace(AppDimensions.width20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                controller: nombreCuisine,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.kitchen, color: Colors.black54),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(AppDimensions.font25)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black54),
                                        borderRadius: BorderRadius.circular(30.0)),
                                    contentPadding: EdgeInsets.only(
                                        left: AppDimensions.width10, right: AppDimensions.width10),
                                    labelText: "Cuisine"
                                ),
                              ),
                            ),
                            addHorizontalSpace(AppDimensions.width25),
                            Flexible(
                              child: TextFormField(
                                controller: garage,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.garage, color: Colors.black54),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(AppDimensions.font25)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black54),
                                        borderRadius: BorderRadius.circular(30.0)),
                                    contentPadding: EdgeInsets.only(
                                        left: AppDimensions.width10, right: AppDimensions.width10),
                                    labelText: "Garage"
                                ),
                              ),
                            ),

                          ],
                        ),
                      ]
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  imageView(BuildContext context){
    final ThemeData themeData = Theme.of(context);
    double padding = AppDimensions.width20;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SingleChildScrollView(
      key: _imageKey,
      child: Container(
        child: Form(
          key: imageFormKey,
          child: Padding(
            padding: sidePadding,
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(AppDimensions.width20),
                  Padding(
                    padding: sidePadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => {
                            _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut)
                          },
                          child: BorderIcon(
                            height: AppDimensions.height60,
                            width: AppDimensions.width80,
                            child: Icon(
                              Icons.keyboard_arrow_left_sharp,
                              color: COLOR_BLACK,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            if(generalFormKey.currentState!.validate()){
                              saveAnnouncement(),
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MainScreen(
                                      userRepository: userRepository,
                                      logementRepository: logementRepository,
                                      categorieRepository: categorieRepository)
                              ))
                            }
                          },
                          child: BorderIcon(
                            height: AppDimensions.height60,
                            width: AppDimensions.width80,
                            child: Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: COLOR_BLACK,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(AppDimensions.height60),
                  Padding(
                    padding: sidePadding,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Icon(Icons.add_to_photos_rounded , color: COLOR_BLACK)),
                          addHorizontalSpace(AppDimensions.width20),
                          Center(
                            child: Text(
                              "NOUVELLE ANNONCE",
                              style: themeData.textTheme.headline6,
                            ),
                          ),
                        ]
                    ),
                  ),
                  addVerticalSpace(AppDimensions.height80),
                  Padding(
                    padding: sidePadding,
                    child: Text("2/2 - Images Informations" , style: themeData.textTheme.caption),
                  ),
                  Padding(
                      padding: sidePadding,
                      child: Divider(
                        height: AppDimensions.height25,
                        color: COLOR_GREY,
                      )),
                  addVerticalSpace(AppDimensions.height20),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      file == null ?
                      Expanded(
                        child: Container(
                          child: Center(child: Text("No Image"),),
                        ),
                      ):
                      builFileImage()
                    ],
                  ),
                  addVerticalSpace(AppDimensions.height10),
                  Center(
                      child:FlatButton(
                        color: COLOR_DARK_BLUE,
                        splashColor: Colors.white.withAlpha(55),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        onPressed: () => uploadImage(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.drive_folder_upload,
                              color: COLOR_WHITE,
                            ),
                            addHorizontalSpace(10),
                            Text(
                              already ? "Ajouter D'autres Images" : "Ajouter Image Principale" ,
                              style: TextStyle(color: COLOR_WHITE),
                            )],
                    ),
                  )
              )
                ]
            )

          )
        )
    )
    );
  }

  Widget builFileImage() {
    return Center(
      child: Image.file(
        file!,
        fit: BoxFit.cover,
        height: AppDimensions.height600,
        width: AppDimensions.width400,
      ),
    );
  }

  void uploadImage() async{
    if(imageTimes < 5){
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if(pickedFile == null){
        SnackBar(
          content: Text("Please Select an image"),
          backgroundColor: Style.Colors.red,
        );
      }else{
        print(pickedFile.path);
        final _file = File(pickedFile.path);
        setState(() {
          file =_file;
          files.add(_file);
          imageTimes++;
          already = true;
        });
      }
    }
  }


}
