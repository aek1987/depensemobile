import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        children: [

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Compte'),
            subtitle: const Text('Informations utilisateur'),
            onTap: () {
              // plus tard
            },
          ),

          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Catégories'),
            subtitle: const Text('Gérer les catégories'),
            onTap: () {
              // étape suivante
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Préférences'),
            subtitle: const Text('Paramètres généraux'),
            onTap: () {},
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Déconnexion',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // plus tard
            },
          ),
        ],
      ),
    );
  }
}
