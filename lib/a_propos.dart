import 'package:flutter/material.dart';

class AProposPage extends StatelessWidget {
  const AProposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('À propos'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 44,
                backgroundColor: Colors.blue[100],
                child: Icon(Icons.person, size: 60, color: Colors.blue[700]),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Notify (Note App)',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(height: 32, thickness: 1.2),
            const Text(
              'Cette application a été codée par Brunel TCHEKELI dans le cadre de la formation D-Clic, spécialité "Développement mobile - niveau intermédiaire".',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 12),

            const SizedBox(height: 24),
            Text(
              'Fonctionnalités principales :',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blue[700],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors
                      .black, // Ajoutez une couleur si nécessaire pour la lisibilité
                ),
                children: <TextSpan>[
                  const TextSpan(text: '• Prise de notes rapide et '),
                  const TextSpan(
                    text: 'sécurisée',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Text(
              '• Interface moderne et épurée\n'
              '• Sauvegarde locale des notes\n'
              '• Facile à utiliser',
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
            const Spacer(),
            Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '© 2025 Brunel',
                style: TextStyle(color: Colors.grey[800], fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
