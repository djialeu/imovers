import 'package:newimovers/repositories/repositories.dart';

import '../services/authentication/authentication.dart';

class StaticRepositories{
  static final userRepository = UserRepository();
  static final auth = AuthenticationService();
  static final categorieRepository = CategorieRepository();
  static final logementRepository = LogementRepository();
}