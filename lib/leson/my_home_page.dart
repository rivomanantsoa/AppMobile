import 'package:flutter/material.dart';
import 'package:forgod/leson/another_page.dart';
import 'package:provider/provider.dart';
import 'global_state.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final caisse = context.watch<GlobalState>().caisse;
    final nom = context.watch<GlobalState>().name;

    return Scaffold(
      appBar: AppBar(title: const Text('Exemple GlobalState')),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Text(
                'Caisse: $caisse Ar avec un nom de $nom',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            AnotherPage(),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<GlobalState>().updateCaisse(1000); // Ajoute 1000 à la caisse
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
