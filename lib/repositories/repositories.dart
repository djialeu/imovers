import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:newimovers/models/Annonce.dart';
import 'package:newimovers/repositories/repo.dart';

class Repository{
  static String mainUrl = "https://com-example-imovers.herokuapp.com";
  final FlutterSecureStorage storage = const FlutterSecureStorage();

}

class CategorieRepository extends Repository{

  String mainUrl = Repository.mainUrl;

  Future<List<Quartier>> getQuartiers() async {
    var token = await storage.read(key: 'token');
    var request = http.Request('GET', Uri.parse('$mainUrl/api/v1/quartiers'));
    var headers = {
      'Authorization': 'Bearer $token',
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonResult = await response.stream.bytesToString();
      List<Quartier> quartiers =  quartierFromJson(jsonResult);
      print(quartiers.first.name);
      return quartiers;
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Categorie>> getCategories() async {
    var token = await storage.read(key: 'token');
    var request = http.Request('GET', Uri.parse('$mainUrl/api/v1/categories'));
    var headers = {
      'Authorization': 'Bearer $token',
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonResult = await response.stream.bytesToString();
      List<Categorie> categories =  categorieFromJson(jsonResult);
      print(categories.first.name);
      return categories;
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }
  Future<List<Categorie>> getTypes() async {
    var token = await storage.read(key: 'token');
    var request = http.Request('GET', Uri.parse('$mainUrl/api/v1/types'));
    var headers = {
      'Authorization': 'Bearer $token',
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonResult = await response.stream.bytesToString();
      List<Categorie> categories =  categorieFromJson(jsonResult);
      print(categories.first.name);
      return categories;
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }
  Future<List<Categorie>> getVisibilities() async {
    var token = await storage.read(key: 'token');
    var request = http.Request('GET', Uri.parse('$mainUrl/api/v1/visibilities'));
    var headers = {
      'Authorization': 'Bearer $token',
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonResult = await response.stream.bytesToString();
      List<Categorie> categories =  categorieFromJson(jsonResult);
      print(categories.first.name);
      return categories;
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Categorie>> getVilles() async {
    var token = await storage.read(key: 'token');
    var request = http.Request('GET', Uri.parse('$mainUrl/api/v1/villes'));
    var headers = {
      'Authorization': 'Bearer $token',
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonResult = await response.stream.bytesToString();
      List<Categorie> categories =  categorieFromJson(jsonResult);
      print(categories.first.name);
      return categories;
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }
}

class LogementRepository extends Repository{

  String mainUrl = Repository.mainUrl;

  Future<List<Annonce>> getViewableLogements() async {
    var token = await storage.read(key: 'token');
    var request = http.Request('GET', Uri.parse('$mainUrl/api/v1/annonces'));
    var headers = {
      'Authorization': 'Bearer $token',
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("Recuperation Logement Bizarre");
      var jsonResult = await response.stream.bytesToString();
      List<Annonce> annonces =  annonceFromJson(jsonResult);
      print("Recuperation Logement Bon");
      return annonces;
    }
    else {
      print("Recuperation Logement Pas bon");
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Map<String , dynamic>?> saveLogement(String categorieName , String typeName,
      String quartierName , String visibilityName, double price , int nbCite ,
      int nbPiece , String description , int nomCite,
      String localisation, int nbChambre , int nbSalon ,
      int nbDouche, int nbCuisine, int superficie , String nbGarage ,List<File> files  ) async {
    var request = http.MultipartRequest('POST', Uri.parse('$mainUrl/api/v1/annonces?categorieName=$categorieName&typeName=$typeName&quartierName=$quartierName&visibilityName=$visibilityName&price=$price&nbCite=$nbCite&nbPiece=$nbPiece&description=$description&nomCite=$nomCite&localisation=$localisation&nbChambre=$nbChambre&nbSalon=$nbSalon&nbDouche=$nbDouche&nbCuisine=$nbCuisine&superficie=$superficie&nbGarage=$nbGarage'));
    var token = await storage.read(key: 'token');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type':  'multipart/form-data'
    };

    files.forEach((element) async {
      request.files.add(await http.MultipartFile.fromPath("files",element.path));
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      var jsonResult = await response.stream.bytesToString();
      Map<String, dynamic> result =  jsonDecode(jsonResult);
      return result;
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }
}

class UserRepository extends Repository{

  String mainUrl = Repository.mainUrl;

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getToken() async{
    var value =  await storage.read(key: 'token');
    if(value!.isEmpty){
      return "";
    }
    return value;
  }
  Future<String> getStoreUsername() async{
    var value =  await storage.read(key: 'username');
    if(value!.isEmpty){
      return "";
    }
    return value;
  }

  Future<bool> exits(String identifier) async{
    var existUrl = "$mainUrl/api/admin/exists?identifier=$identifier";
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('GET', Uri.parse(existUrl));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResult = await response.stream.bytesToString();
      bool result =  jsonDecode(jsonResult);
      log("Check existence $identifier");
      log(result.toString());
      return result;
    }
    else {
      throw Exception();
    }
  }

  Future<dynamic> findConnectedUser() async{
    String username = await getStoreUsername();
    if(username == ""){
      throw Exception("Connected Username not found");
    }
    return getUser(username);
  }

  Future<AppUser> getUser(String? username) async{
    String cusername = username ?? await getStoreUsername();
    var getUserUrl = "$mainUrl/api/admin/user?username=$cusername";
    String token = await getToken();
    if(token == ""){
      throw Exception("Token not found");
    }
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('GET', Uri.parse(getUserUrl));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("Get User en cours...");
    if (response.statusCode == 200) {
      var jsonResult = await response.stream.bytesToString();
      Map<String, dynamic> result =  jsonDecode(jsonResult);
      AppUser user = AppUser.fromJson(result);
      print("Get User pas bon");
      return user;
    }
    else {
      print("Get User pas bon");
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> persistToken(String token) async {
    log("Token : $token");
    await storage.write(key: 'token', value: token);
  }

  Future<void> persistUsername(String username) async {
    log("Username : $username");
    await storage.write(key: 'username', value: username);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.delete(key: 'username');
    storage.deleteAll();
  }

  Future<Token?> login(String login, String password) async {
    var loginUrl =  '$mainUrl/api/login';
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(loginUrl));
    request.bodyFields = {
      'username': login,
      'password': password
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResult = await response.stream.bytesToString();
      Map<String, dynamic> result =  jsonDecode(jsonResult);
      Token login_token = Token.fromJson(result);
      return login_token ;
    }
    else {
      throw Exception(response.reasonPhrase);
    }
  }


  Future<AppUser?> register(String name , String login, String email ,  String password) async {
    var registerUrl =  '$mainUrl/api/admin/users/save';
    print("We want to register");
    // var token = await storage.read(key: "token");
    // var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkb25rZXIiLCJyb2xlcyI6WyJST0xFX0FETUlOIl0sImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODA4MC9hcGkvbG9naW4iLCJleHAiOjE2Njk1MjA0NTZ9.qXdFlcLKniTFBGE20SYqZRRQch9LRbfMqKRS7CN5BFY";
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(registerUrl));
    request.body = jsonEncode({
      'name': name,
      'username': login,
      'email': email,
      'password': password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201 ) {
      print("Checking level error1");
      var jsonResult = await response.stream.bytesToString();
      Map<String, dynamic> result =  jsonDecode(jsonResult);
      AppUser user = AppUser.fromJson(result);
      return user;
    }
    else {
      print("Checking level error2");
      throw Exception(response.reasonPhrase);
    }
  }
}

