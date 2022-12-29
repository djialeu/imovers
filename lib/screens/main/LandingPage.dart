import 'dart:developer';
// import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:newimovers/repositories/repo.dart';
import 'package:newimovers/screens/chat/ChatList.dart';
import 'package:newimovers/screens/main/FormLogementScreen.dart';
import 'package:newimovers/screens/main/LandingScreen.dart';
import 'package:newimovers/screens/main/form_logement.dart';
import 'package:newimovers/screens/main/main_screen.dart';
import 'package:newimovers/utils/app_dimensions.dart';
import '../../blocs/auth_bloc/auth.dart';
// import '../../blocs/auth_bloc/auth_event.dart';
import '../../custom/BorderIcon.dart';
import '../../custom/OptionButton.dart';
import '../../models/Annonce.dart';
import '../../sample_data.dart';
import '../../services/message/database_message.dart';
import 'DetailPage.dart';
import '../../utils/constants.dart';
import '../../utils/custom_functions.dart';
import '../../utils/widget_functions.dart';

class LandingPage extends StatefulWidget {
  final UserRepository userRepository;
  final LogementRepository logementRepository;
  final AppUser connectedUser;
  final CategorieRepository categorieRepository;
  const LandingPage({Key? key, required this.userRepository, required this.logementRepository, required this.connectedUser, required this.categorieRepository}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPage(userRepository, logementRepository , connectedUser , categorieRepository);
}

class _LandingPage extends State<LandingPage>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserRepository userRepository;
  final LogementRepository logementRepository;
  final CategorieRepository categorieRepository;
  final AppUser connectedUser;
  _LandingPage(this.userRepository, this.logementRepository, this.connectedUser, this.categorieRepository);
  List<Annonce>? annonces = [];

  Widget filterList(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: ["<\$220,000","For Sale","3-4 Beds",">1000 sqft"]
            .map((filter) => ChoiceOption(text: filter)).toList(),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = AppDimensions.width20;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          drawer: MyDrawer(connectedUser: connectedUser, categorieRepository: categorieRepository, logementRepository: logementRepository, userRepository: userRepository,),
          body: Container(
              // width: size.width,
              // height: size.height,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(padding),
                      Padding(
                        padding: sidePadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => _scaffoldKey.currentState?.openDrawer(),
                              child: BorderIcon(
                                height: AppDimensions.height80,
                                width: AppDimensions.width60,
                                child: Icon(
                                  Icons.menu,
                                  color: COLOR_BLACK,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                print("refresh");
                              }),
                              child: BorderIcon(
                                height: AppDimensions.height60,
                                width: AppDimensions.width60,
                                child: Icon(
                                  Icons.notifications_active,
                                  color: COLOR_BLACK,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      addVerticalSpace(AppDimensions.height20),
                      Padding(
                        padding: sidePadding,
                        child: Text(
                          "Vos",
                          style: themeData.textTheme.bodyText2,
                        ),
                      ),
                      addVerticalSpace(AppDimensions.height10),
                      Padding(
                        padding: sidePadding,
                        child: Text(
                          "Logements",
                          style: themeData.textTheme.headline5,
                        ),
                      ),
                      Padding(
                          padding: sidePadding,
                          child: Divider(
                            height: AppDimensions.height25,
                            color: COLOR_GREY,
                          )),
                      addVerticalSpace(AppDimensions.height10),
                      //filterList(),
                      addVerticalSpace(AppDimensions.height10),
                      Expanded(
                        child:
                          FutureBuilder(
                            future: logementRepository.getViewableLogements(),
                            builder: (context, AsyncSnapshot<List<Annonce>> snapshot) {
                              if(!snapshot.hasData){
                                print("Landing page : Logement pas bon");
                                return Container(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black54,
                                          backgroundColor: Colors.black54,
                                          ),
                                      ),
                                      height: AppDimensions.width100,
                                      width: AppDimensions.height100,
                                  ),
                                );
                              }else{
                                annonces = snapshot.data!;
                                return annonces!.isEmpty ? Center(child: Text("Aucune Donnee"),) : Padding(
                                  padding: sidePadding,
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: annonces!.length,
                                      itemBuilder: (context, index) {
                                        return RealEstateItem(
                                          itemData: annonces![index],
                                          connectedUser: connectedUser,
                                        );
                                      }),
                                );
                              }
                            }
                          )
                        ),
                    ],
                  ),
                  // Positioned(
                  //   bottom: 20,
                  //   width: size.width,
                  //   child: Center(
                  //     child: OptionButton(
                  //       text: "Map View",
                  //       icon: Icons.map_rounded,
                  //       width: size.width * 0.35,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
    );
  }
}




class RealEstateItem extends StatelessWidget {
  final mainUrl = "${Repository.mainUrl}/image/";
  final Annonce itemData;
  final AppUser connectedUser;

  RealEstateItem({Key? key, required this.itemData, required this.connectedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double padding = AppDimensions.width20;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailPage(
                  itemData: itemData,
                  connectedUser: connectedUser,
                )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: AppDimensions.height20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(AppDimensions.font25), child: itemData.filenames!.isNotEmpty  ? CachedNetworkImage( imageUrl: mainUrl + itemData.filenames!.split(";").first , placeholder: (context, url) => Center(child: CircularProgressIndicator()),) : Image.asset("assets/images/image_2.jpg")),
                Positioned(
                    top: AppDimensions.height10,
                    right: AppDimensions.width10,
                    child: BorderIcon(
                        child: Icon(
                      Icons.favorite_border,
                      color: COLOR_BLACK,
                    )))
              ],
            ),
            addVerticalSpace(AppDimensions.height10),
            Row(
              children: [
                addVerticalSpace(AppDimensions.height50),
                Text(
                  itemData.nomCite!,
                  style: themeData.textTheme.headline6,
                ),
                addHorizontalSpace(AppDimensions.height10),

                Text(
                  " ${itemData.quartier!.name} -- ${itemData.localisation} ",
                  style: themeData.textTheme.bodyText2,
                )
              ],
            ),
            addHorizontalSpace(AppDimensions.width10),
            Text(
              formatCurrency(itemData.price!),
              style: themeData.textTheme.headline5,
            ),
            addVerticalSpace(AppDimensions.height10),
            Text(
              "${itemData.nbChambres} Chambres " + "- ${itemData.nbDouches} Douches" + "- ${itemData.superficie} m\u00B2",
              style: themeData.textTheme.bodyText1,
            ),
            Divider(
              height: AppDimensions.height10,
              color: COLOR_GREY,
            ),
          ],

        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final AppUser connectedUser;
  final CategorieRepository categorieRepository;
  final UserRepository userRepository;
  final LogementRepository logementRepository;

  MyDrawer({Key? key, required this.connectedUser, required this.categorieRepository, required this.userRepository, required this.logementRepository}) : super(key: key);

  Widget? privateAnnonces(BuildContext context){
    if(connectedUser.roles!.first.name == "ROLE_ADMIN" || connectedUser.roles!.first.name == "ROLE_SUPER_ADMIN" || connectedUser.roles!.first.name == "ROLE_PARTNER"){
      return ListTile(
        leading: Icon(Icons.library_books),
        title: Text('Mes Annonces'),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FormLogementScreen(userRepository: UserRepository(), logementRepository: LogementRepository(), connectedUser: connectedUser,categorieRepository: categorieRepository,)));
        },
      );
    }else{
        return Visibility(
          visible: false,
          child: Text("Non Autorise"));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(connectedUser.username!),
            accountEmail: Text(connectedUser.email!),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/user_default.png',
                  fit: BoxFit.cover,
                  width: AppDimensions.width100,
                  height: AppDimensions.height100,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: AssetImage(
              //         '')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingScreen(
                    userRepository: userRepository,
                    logementRepository: logementRepository,
                    categorieRepository: categorieRepository,
                    connectedUser:connectedUser,
                  )));
            },
          ),
          privateAnnonces(context)!,
          ListTile(
            leading: Icon(Icons.message_sharp),
            title: Text('Chats'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatList(
                    connectedUser:connectedUser,
                  )));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.share),
          //   title: Text('Share'),
          //   onTap: () => null,
          // ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificatons'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Parametres'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Aide'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
              title: Text('Deconnexion'),
              leading: Icon(Icons.exit_to_app),
              onTap: () => BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut())
          ),
        ],
      ),
    );
  }
}


class ChoiceOption extends StatelessWidget {
  final String text;

  const ChoiceOption({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: COLOR_GREY.withAlpha(AppDimensions.height25.round() ),
        borderRadius: BorderRadius.circular( AppDimensions.font25 ),
      ),
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.width20, vertical: AppDimensions.height13),
      margin:  EdgeInsets.only(left: AppDimensions.font25),
      child: InkWell(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => LandingPage()));
        },
        child: Text(
          text,
          style: themeData.textTheme.headline5,
        ),
      ),
    );
  }
}