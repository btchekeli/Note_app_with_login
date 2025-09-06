import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:note_app/subscribe_page.dart';
import 'package:note_app/login_page.dart';
import 'package:note_app/a_propos.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(37, 174, 220, 1),
              Color.fromRGBO(78, 88, 188, 1),
            ],
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/note_image_accueil.jpg',
                    width: 400,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Image.asset('assets/images/notify.png', height: 100),

              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100]?.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Bienvenue sur Notify",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),
                    const Text(
                      "Créez, organisez et partagez vos notes facilement",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(
                          200,
                          50,
                        ), // Taille minimale du bouton
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // Bords arrondis
                        ),
                      ),
                      child: const Text('Me connecter'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const SizedBox(height: 10),

              // Pour le lien "Ce n'est pas votre compte ? Inscrivez-vous"
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white),
                  children: <TextSpan>[
                    const TextSpan(text: 'Ce n\'est pas votre compte ? '),
                    TextSpan(
                      text: 'Inscrivez-vous',
                      style: const TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SubscribePage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AProposPage(),
                    ),
                  );
                },
                child: const Text(
                  'A propos',
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
