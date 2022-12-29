import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newimovers/repositories/repo.dart';
import 'package:newimovers/screens/main/LandingPage.dart';

import '../../models/Annonce.dart';

class LandingScreen extends StatelessWidget{
  final UserRepository userRepository;
  final LogementRepository logementRepository;
  final AppUser connectedUser;
  final CategorieRepository categorieRepository;

  LandingScreen({
    Key? key,
    required this.userRepository,
    required this.logementRepository,
    required this.connectedUser, required this.categorieRepository
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LandingPage(userRepository: userRepository, logementRepository: logementRepository, connectedUser: connectedUser, categorieRepository: categorieRepository,),
    );
  }

}