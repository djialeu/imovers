import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:newimovers/repositories/repo.dart';
import 'package:newimovers/repositories/staticRepositories.dart';
import 'package:newimovers/screens/login/login_screen.dart';
import 'package:newimovers/screens/main/FormLogementScreen.dart';
import 'package:newimovers/screens/main/LandingScreen.dart';
import 'package:newimovers/screens/main/catalog_description.dart';
import 'package:newimovers/screens/main/main_home_screen.dart';
import 'package:newimovers/screens/main/page_aide.dart';
import 'package:newimovers/services/message/database_message.dart';

import '../../animations/fade_animation.dart';
import '../../blocs/auth_bloc/auth.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/Annonce.dart';
import '../../screens/main/LandingPage.dart';
import '../../utils/constants.dart';
import 'dart:ui';


class MainScreen extends StatefulWidget {
  final UserRepository userRepository;
  final CategorieRepository categorieRepository;
  final LogementRepository logementRepository;
  const MainScreen({Key? key, required this.userRepository, required this.logementRepository, required this.categorieRepository}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<MainScreen> createState() => _MainScreenState(userRepository , logementRepository , categorieRepository);
}

class _MainScreenState extends State<MainScreen> {
  final UserRepository userRepository;
  final LogementRepository logementRepository;
  final CategorieRepository categorieRepository;
  _MainScreenState(this.userRepository , this.logementRepository, this.categorieRepository);

  @override
  Widget build(BuildContext context) {
    // double screenWidth = window.physicalSize.width;
    AppUser? connectedUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Imovers +',
      theme: ThemeData(primaryColor: COLOR_WHITE, accentColor: COLOR_DARK_BLUE),//, textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT, fontFamily: "Montserrat"
      home:  FutureBuilder(
          future: userRepository.getUser(null),
          builder: (context, AsyncSnapshot<AppUser> snapshot ) {
            if(!snapshot.hasData){
              print("Main Screen Pas Bon");
              // return LoginScreen(userRepository: userRepository, authenticationService: StaticRepositories.auth);
              return Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Center(
                    child:
                      CircularProgressIndicator(
                        color: Colors.black54,
                      ),
                  )
              );
            }
            else{
              print("Main Screen Bon");
              MessageDatabaseService().getMyChaters("username");
              connectedUser = snapshot.data;
              print("Dans Main Screen User est " + connectedUser!.name!);
              return LandingScreen(userRepository: userRepository, logementRepository: logementRepository, connectedUser: connectedUser!, categorieRepository: categorieRepository,);
            }
          }
      ),
    );
  }
}
