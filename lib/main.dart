
// @dart=2.9

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:newimovers/models/Annonce.dart';
import 'package:newimovers/repositories/staticRepositories.dart';
import 'package:newimovers/screens/chat/chatScreen.dart';
import 'package:newimovers/screens/login/login_screen.dart';
import 'package:newimovers/screens/main/main_home_screen.dart';
import 'package:newimovers/services/authentication/authentication.dart';

import 'models/ChatParams.dart';
import 'screens/main/main_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth_bloc/auth.dart';
import 'repositories/repositories.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class SimpleBlocDelegate extends BlocDelegate{

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  final auth = AuthenticationService();
  final categorieRepository = CategorieRepository();
  final logementRepository = LogementRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository, authenticationService: auth)
          ..add(AppStarted());
      },
      child: MyApp(userRepository: userRepository, logementRepository: logementRepository ,  authenticationService: auth, categorieRepository: categorieRepository,),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final LogementRepository logementRepository;
  final AuthenticationService authenticationService;
  final CategorieRepository  categorieRepository;

  const MyApp({Key key, this.userRepository, this.authenticationService, this.logementRepository,this.categorieRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    userRepository.deleteToken();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('mn', 'MN'),
      theme: ThemeData(
        fontFamily: 'Rubik',
        primarySwatch: Colors.blueGrey,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return MainScreen(userRepository: userRepository, logementRepository: logementRepository, categorieRepository: categorieRepository,);
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginScreen(userRepository: userRepository , authenticationService: authenticationService);
          }
          if (state is AuthenticationLoading) {
            return Scaffold(
              body: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(
                      height: 25.0,
                      width: 25.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 4.0,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 4.0,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
