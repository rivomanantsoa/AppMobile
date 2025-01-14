import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  int caisse = 2000;
//  late final ValueChanged<Map<String, dynamic>> addTransaction;
  late String name = "mika";
  late String raison;
  late DateTime date;
  late String type;
  late int montant;
  // Exemple de variable mutable

  void updateCaisse(int montant) {
    caisse += montant;
    notifyListeners(); // Notifie les widgets abonnés pour une mise à jour
  }

  void addTransaction(String name, String raison, String type, DateTime date, int montant){

  }
}
