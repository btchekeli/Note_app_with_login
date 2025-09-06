import 'package:flutter/material.dart';
import 'package:note_app/login_page.dart';
import 'package:note_app/database/auth_service.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({super.key});

  @override
  State<SubscribePage> createState() => _SuscribePageState();
}

class _SuscribePageState extends State<SubscribePage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _signUp() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // je Vérifie d'abord si les deux mots de passe correspondent
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Les mots de passe ne correspondent pas.'),
        ),
      );
      return; // Arrête l'exécution si la vérification échoue
    }

    final success = await _authService.signUp(username, password);

    if (success) {
      // Afficher un message de succès et naviguer vers la page de connexion
      ScaffoldMessenger.of(
        context, // context du widget actuel (produit une erreur. A vérifier après)
      ).showSnackBar(const SnackBar(content: Text('Inscription réussie !')));
      Navigator.pop(context); // Revient à la page précédente (login)
    } else {
      // Afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Erreur : l\'utilisateur existe déjà ou une erreur est survenue',
          ),
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
        title: const Text('S\'inscrire', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),
            Image.asset(
              'assets/images/notify.png',
              height: 100, //
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
            const SizedBox(height: 16.0),
            // Confirmation pour le mot de passe
            TextField(
              controller: _confirmPasswordController,
              obscureText: true, // Cache le texte pour le mot de passe
              decoration: const InputDecoration(
                labelText: 'Confirmez le mot de passe',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 24.0),

            // Bouton de connexion
            ElevatedButton(
              onPressed: () {
                _signUp();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50), // Taille minimale du bouton
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bords arrondis
                ),
              ),
              child: const Text('S\'inscrire'),
            ),
            Divider(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Retour à la page de connexion ? "),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text("Se connecter"),
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
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
