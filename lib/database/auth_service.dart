//
//
import 'package:note_app/database/database_helper.dart';

class AuthService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Méthode d'inscription
  Future<bool> signUp(String username, String password) async {
    // Vérifie si l'utilisateur existe déjà
    final existingUser = await _dbHelper.getUserByUsername(username);
    if (existingUser != null) {
      // L'utilisateur existe, l'inscription échoue
      return false;
    }
    // Crée le nouvel utilisateur et l'insère dans la base de données
    final newUser = User(username: username, password: password);
    final id = await _dbHelper.insertUser(newUser);
    return id > 0; // L'inscription est réussie si un ID a été généré
  }

  // Méthode de connexion
  Future<bool> login(String username, String password) async {
    // Tente de récupérer l'utilisateuréé fgfdhbg
    final user = await _dbHelper.getUserByUsername(username);
    if (user != null && user.password == password) {
      return true; // Connexion réussie, le mot de passe correspond
    }
    return false; // Échec de la connexion
  }
}
