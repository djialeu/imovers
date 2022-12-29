import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newimovers/utils/app_dimensions.dart';

import '../../animations/fade_animation.dart';
import '../../blocs/login_bloc/login_bloc.dart';
import '../../repositories/repositories.dart';
import '../../style/theme.dart' as Style;

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;
  const LoginForm({Key? key, required this.userRepository})
      : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(userRepository);
}

class _LoginFormState extends State<LoginForm> {
  bool islogin = true;
  final _formKey = GlobalKey<FormState>();
  final UserRepository userRepository;
  _LoginFormState(this.userRepository);
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();


  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _onLoginButtonPressed() {
      if(islogin){
        BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(login: _usernameController.text, password: _passwordController.text,),);
      }else{
        BlocProvider.of<LoginBloc>(context).add(RegisterButtonPressed(email: _emailController.text, login: _usernameController.text, name: _nameController.text, password: _passwordController.text,),);
      }

    }

    Widget emailElement(){
      if(!islogin) {
        return TextFormField(
          style: const TextStyle(
              fontSize: 14.0,
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.bold),
          controller: _emailController ,
          validator: (value) =>
          value!.isEmpty || !EmailValidator.validate(value)
              ? "Veuillez verifier votre adresse email"
              :   null,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(EvaIcons.emailOutline, color: Colors.black26),
            enabledBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(30.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Style.Colors.mainColor),
                borderRadius: BorderRadius.circular(30.0)),
            contentPadding: EdgeInsets.only(
                left: AppDimensions.width10, right: AppDimensions.width10),
            labelText: "Email",
            hintStyle: TextStyle(
                fontSize: 12.0,
                color: Style.Colors.grey,
                fontWeight: FontWeight.w500),
            labelStyle: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
                fontWeight: FontWeight.w500),
          ),
          autocorrect: false,
        );
      }else{
        return Visibility(
          visible: false,
          child: TextFormField(
          ),
        );
      }

    }
    Widget nameElement(){
      if(!islogin) {
        return TextFormField(
          style: const TextStyle(
              fontSize: 14.0,
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.bold),
          controller: _nameController,
          validator: (value) =>
          value!.isEmpty
              ? "Veuillez entrer un nom"
              : null,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(EvaIcons.emailOutline, color: Colors.black26),
            enabledBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(30.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Style.Colors.mainColor),
                borderRadius: BorderRadius.circular(30.0)),
            contentPadding: EdgeInsets.only(
                left: AppDimensions.width10, right: AppDimensions.width10),
            labelText: "Nom",
            hintStyle: TextStyle(
                fontSize: 12.0,
                color: Style.Colors.grey,
                fontWeight: FontWeight.w500),
            labelStyle: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
                fontWeight: FontWeight.w500),
          ),
          autocorrect: false,
        );
      }else{
        return Visibility(
          visible: false,
          child: TextFormField(
          ),
        );
      }

    }
    Widget loginElement(){
      if(!islogin) {
        return TextFormField(
          style: const TextStyle(
              fontSize: 14.0,
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.bold),
          controller:  _usernameController,
          validator: (value)  => value!.isEmpty  ? "Veuillez entrer un login"  :  null,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(EvaIcons.emailOutline, color: Colors.black26),
            enabledBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(30.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Style.Colors.mainColor),
                borderRadius: BorderRadius.circular(30.0)),
            contentPadding: EdgeInsets.only(
                left: AppDimensions.width10, right: AppDimensions.width10),
            labelText: "Login",
            hintStyle: TextStyle(
                fontSize: 12.0,
                color: Style.Colors.grey,
                fontWeight: FontWeight.w500),
            labelStyle: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
                fontWeight: FontWeight.w500),
          ),
          autocorrect: false,
        );
      }else{
        return TextFormField(
          style: const TextStyle(
              fontSize: 14.0,
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.bold),
          controller:  _usernameController,
          validator: (value) => value!.isEmpty  ? "Veuillez entrer un login" :   null,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(EvaIcons.emailOutline, color: Colors.black26),
            enabledBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(30.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Style.Colors.mainColor),
                borderRadius: BorderRadius.circular(30.0)),
            contentPadding: EdgeInsets.only(
                left: AppDimensions.width10, right: AppDimensions.width10),
            labelText: "Login",
            hintStyle: TextStyle(
                fontSize: 12.0,
                color: Style.Colors.grey,
                fontWeight: FontWeight.w500),
            labelStyle: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
                fontWeight: FontWeight.w500),
          ),
          autocorrect: false,
        );
      }

    }
    Widget cpElement(){
      if(!islogin) {
        return TextFormField(
          style: TextStyle(
              fontSize: 14.0,
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.bold),
          controller: _confirmPasswordController,
          validator: (value) => value != _passwordController.text ? "Veuillez juste resaisir le mot de passe precedent" : null,
          decoration: InputDecoration(
            fillColor: Colors.white,
            prefixIcon: Icon(EvaIcons.lockOutline, color: Colors.black26,),
            enabledBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(30.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Style.Colors.mainColor),
                borderRadius: BorderRadius.circular(30.0)),
            contentPadding: EdgeInsets.only(
                left: AppDimensions.width10, right: AppDimensions.width10),
            labelText: "Confirm Password",
            hintStyle: TextStyle(
                fontSize: 12.0,
                color: Style.Colors.grey,
                fontWeight: FontWeight.w500),
            labelStyle: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
                fontWeight: FontWeight.w500),
          ),
          autocorrect: false,
          obscureText: true,
        );
      }else{
        return Visibility(
          visible: false,
          child: TextFormField(
          ),
        );
      }

    }
    Widget orConnectElement(){
      if(islogin) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Ou se connecter via", style: TextStyle(
                color: Colors.black26,
                fontSize: 12.0
            ),),
          ],
        );
      }else{
        return Visibility(
          visible: false,
          child: TextFormField(
          ),
        );
      }

    }
    Widget fpElement(){
      if(islogin) {
        return Align(
          alignment: Alignment.centerRight,
          child: new InkWell(
              child: new Text("Mot de passe oublie?", style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12.0
              ),),
              onTap: () {

              }
          ),
        );
      }else{
        return Visibility(
          visible: false,
          child: TextFormField(
          ),
        );
      }

    }
    Widget oauthElement(){
      if(islogin) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: AppDimensions.height50,
              width: AppDimensions.width200,
              child: RaisedButton(
                  color: Color(0xFF385c8e),
                  disabledColor: Style.Colors.mainColor,
                  disabledTextColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: _onLoginButtonPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(EvaIcons.facebook, color: Colors.white,),
                      SizedBox(
                        width: AppDimensions.width5,
                      ),
                      Text("Facebook", style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  )
              ),
            ),
            Container(
              width: AppDimensions.width200,
              height: AppDimensions.height50,
              child: RaisedButton(
                  color: Color(0xfff14436),
                  disabledColor: Style.Colors.mainColor,
                  disabledTextColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(EvaIcons.google, color: Colors.white,),
                      SizedBox(
                        width: AppDimensions.width5,
                      ),
                      Text("Google", style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  )
              ),
            ),
          ],
        );
      }else{
        return Visibility(
          visible: false,
          child: TextFormField(
          ),
        );
      }

    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(islogin ? "Login Failed" : "Register Failed"),
              backgroundColor: Style.Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: AppDimensions.width20, left: AppDimensions.width20, top: AppDimensions.height80),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: AppDimensions.height300,
                          // padding: EdgeInsets.only(bottom: 0.0, top: 0.0),
                          child: Stack(
                              children: <Widget> [ Positioned(
                                top: 0,
                                height: AppDimensions.height300,
                                width: 0.85 * MediaQuery.of(context).size.width ,
                                child: FadeAnimation(1, Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/logo_v2.png'),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                )),
                              ),]
                          ),
                        ),
                        SizedBox(
                          height: AppDimensions.height30,
                        ),
                        loginElement(),
                            SizedBox(
                              height: AppDimensions.height20,
                            ),
                          emailElement(),
                        SizedBox(
                          height: islogin ? 0 :  AppDimensions.height20,
                        ),
                            nameElement(),
                        SizedBox(
                          height: islogin ? 0 : AppDimensions.height20,
                        ),
                            TextFormField(
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Style.Colors.titleColor,
                                  fontWeight: FontWeight.bold),
                              controller: _passwordController,
                              validator: (value) => value!.isEmpty || value.length < 4 ? "Au moins 6 caracteres pour votre mot de passe" : null,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                prefixIcon: Icon(EvaIcons.lockOutline, color: Colors.black26,),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(30.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(color: Style.Colors.mainColor),
                                    borderRadius: BorderRadius.circular(30.0)),
                                contentPadding: EdgeInsets.only(
                                    left: AppDimensions.width10, right: AppDimensions.width10),
                                labelText: "Password",
                                hintStyle: TextStyle(
                                    fontSize: 12.0,
                                    color: Style.Colors.grey,
                                    fontWeight: FontWeight.w500),
                                labelStyle: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                              autocorrect: false,
                              obscureText: true,
                            ),
                        SizedBox(
                          height: AppDimensions.height20,
                        ),
                          cpElement(),
                            SizedBox(
                            height: islogin ? 0 : AppDimensions.height20,
                          ),
                          fpElement(),
                          Padding(
                            padding: EdgeInsets.only(top: AppDimensions.height30, bottom: AppDimensions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(
                                  height: AppDimensions.height50,
                                  child: state is LoginLoading ?
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: AppDimensions.height25,
                                                width: AppDimensions.width25,
                                                child: CupertinoActivityIndicator(),
                                              )
                                            ],
                                          )
                                        )
                                      ],
                                    ) :
                                    RaisedButton(
                                      color: Style.Colors.mainColor,
                                      disabledColor: Style.Colors.mainColor,
                                      disabledTextColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      onPressed: () async {
                                        if(_formKey.currentState!.validate()){
                                          if(!islogin && (await userRepository.exits(_usernameController.text) || await userRepository.exits(_emailController.text))  ){
                                            Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text("Register Failed:  Nom utilisateur ou Email deja pris"),
                                                backgroundColor: Style.Colors.red,
                                              ),
                                            );
                                            return;
                                          }
                                          _onLoginButtonPressed();
                                        }
                                      },
                                      child: Text(islogin ? "Connexion" : "Inscription", style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white))
                                    )
                                ),
                              ],
                            ),
                          ),
                          orConnectElement(),
                          SizedBox(
                            height: !islogin ? 0 : AppDimensions.height20,
                          ),
                          oauthElement(),
                          SizedBox(
                            height: !islogin ? 0 : AppDimensions.height40,
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  padding: EdgeInsets.only(bottom: AppDimensions.height30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        islogin ? "Je ne possede aucun compte?" : "Deja titulaire de compte",
                                        style: TextStyle(color: Style.Colors.secondBlack),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: AppDimensions.width5),
                                      ),
                                      GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                islogin = !islogin;
                                                _usernameController.text = "";
                                                _nameController.text = "";
                                                _passwordController.text = "";
                                                _confirmPasswordController.text = "";
                                                _emailController.text = "";
                                                _formKey.currentState!.reset();
                                              });
                                            },
                                            child: Text(
                                              islogin ? "Inscription" : "Connexion",
                                              style: TextStyle(
                                                  color: Style.Colors.mainColor,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                    ],
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: AppDimensions.height20,
                          )
                      ],
                    ),
                  ),
                ),
              ),
          );
        },
      ),
    );
  }
}