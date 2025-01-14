import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {

  int caisse = 0;

  // Getter pour la caisse
  int get caisses => caisse;

  // Liste globale pour stocker les transactions
  List<Map<String, dynamic>> transactions = [];
  List<Map<String, dynamic>> personnes = [];



  // Ajouter une transaction dans la liste globale
  void addTransaction({
    required String nom,
    required String raison,
    required String type,
    required DateTime date,
    required int montant,
  }) {
    // Ajouter une transaction
    transactions.add({
      "nom": nom,
      "raison": raison,
      "type": type,
      "date": date,
      "montant": montant,
    });

    // Mettre à jour la caisse en fonction du montant
    if (type == 'entrée') {
      caisse += montant;
    } else if (type == 'sortie') {
      caisse -= montant;
    }

    // Notifie les widgets abonnés
    notifyListeners();
  }



  void addPerson({
    required String nom,
    required String genre,
    required DateTime date,
    required String number,
  }) {
    personnes.add({
      "nom": nom,
      "genre": genre,
      "date": date,
      "number": number,
    });

    notifyListeners();
  }


  // Pour obtenir toutes les transactions
  List<Map<String, dynamic>> getTransactions() {
    return transactions;
  }

  List<Map<String, dynamic>> getPerson() {
    return personnes;
  }
  void updateCaisse(int newCaisse) {
    caisse = newCaisse;
    notifyListeners();
  }
}
