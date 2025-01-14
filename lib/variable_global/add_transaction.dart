import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:forgod/variable_global/globale_state.dart';

class AddTransaction extends StatelessWidget {
  final nameController = TextEditingController();
  final raisonController = TextEditingController();
  final typeController = TextEditingController();
  final montantController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Ajouter une transaction")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: raisonController,
              decoration: InputDecoration(labelText: "Raison"),
            ),
            TextField(
              controller: typeController,
              decoration: InputDecoration(labelText: "Type"),
            ),
            TextField(
              controller: montantController,
              decoration: InputDecoration(labelText: "Montant"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                globalState.addTransaction(
                  nom: nameController.text,
                  raison: raisonController.text,
                  type: typeController.text,
                  date: DateTime.now(),
                  montant: int.parse(montantController.text),
                );
                Navigator.pop(context); // Retour à la page précédente
              },
              child: Text("Ajouter"),
            ),
          ],
        ),
      ),
    );
  }
}
