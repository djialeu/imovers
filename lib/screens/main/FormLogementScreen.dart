import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newimovers/models/Annonce.dart';
import 'package:newimovers/repositories/repo.dart';
import 'package:newimovers/screens/main/form_logement.dart';

class FormLogementScreen extends StatelessWidget{
  final UserRepository userRepository;
  final LogementRepository logementRepository;
  final CategorieRepository categorieRepository;
  final AppUser connectedUser;

  const FormLogementScreen({Key? key, required this.userRepository, required this.logementRepository, required this.connectedUser, required this.categorieRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormLogement(logementRepository: logementRepository, userRepository: userRepository, categorieRepository: categorieRepository, connectedUser: connectedUser,),
    );
  }

}