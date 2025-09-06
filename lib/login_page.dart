import 'package:flutter/material.dart';
import 'package:note_app/subscribe_page.dart';
import 'package:note_app/database/auth_service.dart';
import 'package:note_app/liste_notes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Contrôleurs pour récupérer les valeurs des champs de texte
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Instance du service d'authentification
  final AuthService _authService = AuthService();

  // Cette méthode sera appelée lors du clic sur le bouton de connexion
  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Utilisation de la méthode de connexion de l'AuthService
    final success = await _authService.login(username, password);

    if (success) {
      // Affiche un message d'erreur
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Connexion réussie !')));
      // Navigue vers la page principale des notes, en remplaçant l'écran de connexion
      // `pushReplacement` empêche de revenir à la page de connexion en arrière
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ListeNotesPage()),
      );
    } else {
      // Affiche un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nom d\'utilisateur ou mot de passe incorrect'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
        title: const Text(
          'Se connecter',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50),
            Image.asset(
              'assets/images/notify.png',
              height: 100, // Ajustez la taille
            ),
            const SizedBox(height: 50),
            // Champ pour le nom d'utilisateur
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Nom d\'utilisateur',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 16.0),
            // Champ pour le mot de passe
            TextField(
              controller: _passwordController,
              obscureText: true, // Cache le texte pour le mot de passe
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 24.0),
            // Bouton de connexion
            ElevatedButton(
              onPressed: () {
                _login();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Me connecter'),
            ),
            Divider(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Pas encore de compte ? "),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubscribePage(),
                      ),
                    );
                  },
                  child: const Text("S'inscrire"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Ou connectez-vous avec"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/images/google_logo.jpg',
                    height: 50,
                  ),
                ),
                const SizedBox(width: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/images/apple_logo.png',
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
