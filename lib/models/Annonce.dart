// To parse this JSON data, do
//
//     final annonce = annonceFromJson(jsonString);

import 'dart:convert';

List<Annonce> annonceFromJson(String str) => List<Annonce>.from(json.decode(str).map((x) => Annonce.fromJson(x)));

String annonceToJson(List<Annonce> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Annonce {
  Annonce({
    this.id,
    this.author,
    this.categorie,
    this.type,
    this.quartier,
    this.visibility,
    this.price,
    this.nbCite,
    this.nbPiece,
    this.description,
    this.nomCite,
    this.localisation,
    this.nbChambres,
    this.nbSalons,
    this.nbDouches,
    this.nbCuisines,
    this.superficie,
    this.nbGarages,
    this.filenames,
    this.datepublication,
  });

  int? id;
  AppUser? author;
  Categorie? categorie;
  Categorie? type;
  Quartier? quartier;
  Categorie? visibility;
  double? price;
  int? nbCite;
  int? nbPiece;
  String? description;
  String? nomCite;
  String? localisation;
  int? nbChambres;
  int? nbSalons;
  int? nbDouches;
  int? nbCuisines;
  int? superficie;
  int? nbGarages;
  String? filenames;
  int? datepublication;

  factory Annonce.fromJson(Map<String, dynamic> json) => Annonce(
    id: json["id"],
    author: AppUser.fromJson(json["author"]),
    categorie: Categorie.fromJson(json["categorie"]),
    type: Categorie.fromJson(json["type"]),
    quartier: json["quartier"] == null ? null : Quartier.fromJson(json["quartier"]),
    visibility: Categorie.fromJson(json["visibility"]),
    price: json["price"].toDouble(),
    nbCite: json["nbCite"],
    nbPiece: json["nbPiece"],
    description: json["description"],
    nomCite: json["nomCite"],
    localisation: json["localisation"],
    nbChambres: json["nbChambres"],
    nbSalons: json["nbSalons"],
    nbDouches: json["nbDouches"],
    nbCuisines: json["nbCuisines"],
    superficie: json["superficie"],
    nbGarages: json["nbGarages"],
    filenames: json["filenames"],
    datepublication: json["datepublication"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author!.toJson(),
    "categorie": categorie!.toJson(),
    "type": type!.toJson(),
    "quartier": quartier == null ? null : quartier!.toJson(),
    "visibility": visibility!.toJson(),
    "price": price,
    "nbCite": nbCite,
    "nbPiece": nbPiece,
    "description": description,
    "nomCite": nomCite,
    "localisation": localisation,
    "nbChambres": nbChambres,
    "nbSalons": nbSalons,
    "nbDouches": nbDouches,
    "nbCuisines": nbCuisines,
    "superficie": superficie,
    "nbGarages": nbGarages,
    "filenames": filenames,
    "datepublication": datepublication,
  };
}

class AppUser {
  AppUser({
    this.id,
    this.name,
    this.email,
    this.username,
    this.password,
    this.roles,
  });

  int? id;
  String? name;
  String? email;
  String? username;
  String? password;
  List<Categorie>? roles;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
    roles: List<Categorie>.from(json["roles"].map((x) => Categorie.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "username": username,
    "password": password,
    "roles": List<dynamic>.from(roles!.map((x) => x.toJson())),
  };
}

List<Categorie> categorieFromJson(String str) => List<Categorie>.from(json.decode(str).map((x) => Categorie.fromJson(x)));

String categorieToJson(List<Categorie> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categorie {
  Categorie({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Categorie.fromJson(Map<String, dynamic> json) => Categorie(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}


List<Quartier> quartierFromJson(String str) => List<Quartier>.from(json.decode(str).map((x) => Quartier.fromJson(x)));

String quartierToJson(List<Quartier> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quartier {
  Quartier({
    this.name,
    this.arrondissement,
    this.id,
  });

  String? name;
  Arrondissement? arrondissement;
  int? id;

  factory Quartier.fromJson(Map<String, dynamic> json) => Quartier(
    name: json["name"],
    arrondissement: json["arrondissement"] == null ? null : Arrondissement.fromJson(json["arrondissement"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "arrondissement": arrondissement == null ? null : arrondissement!.toJson(),
    "id": id,
  };
}

class Arrondissement {
  Arrondissement({
    this.name,
    this.ville,
    this.id,
  });

  String? name;
  Ville? ville;
  int? id;

  factory Arrondissement.fromJson(Map<String, dynamic> json) => Arrondissement(
    name: json["name"],
    ville: Ville.fromJson(json["ville"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "ville": ville!.toJson(),
    "id": id,
  };
}

class Ville {
  Ville({
    this.name,
    this.id,
  });

  String? name;
  int? id;

  factory Ville.fromJson(Map<String, dynamic> json) => Ville(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}


class Token{
  String? access_token, refresh_token;
  Token({
    this.access_token,
    this.refresh_token
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    access_token: json["access_token"],
    refresh_token: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": access_token,
    "refresh_token": refresh_token
  };
}
