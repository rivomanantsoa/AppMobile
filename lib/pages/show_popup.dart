import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

void showPopup(BuildContext context) {

  final TextEditingController amountController = TextEditingController();

  String? selectedName;
  String? selectedExample;
  String? selectedPaymentType;
  DateTime? selectedDate;  // Variable pour stocker la date sélectionnée

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text("Ajouter de l'argent"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Nom
                DropdownButtonFormField<String>(
                  value: selectedName,
                  hint: const Text("Sélectionnez un nom"),
                  onChanged: (String? newValue) {
                    selectedName = newValue;
                  },
                  items: <String>['Jean', 'Marie', 'Paul', 'Sophie', 'Luc']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),

                // Champ Date
                DateTimeFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Date',
                  ),
                  firstDate: DateTime.now().add(const Duration(days: 10)),
                  lastDate: DateTime.now().add(const Duration(days: 40)),
                  initialPickerDateTime:
                  DateTime.now().add(const Duration(days: 20)),
                  onChanged: (DateTime? value) {
                    if (value != null) {
                      selectedDate = value;  // Mettre à jour la variable selectedDate
                    }
                  },
                ),
                const SizedBox(height: 10),

                // Type de paiement dropdown
                DropdownButtonFormField<String>(
                  value: selectedPaymentType,
                  hint: const Text("Type de paiement"),
                  onChanged: (String? newValue) {
                    selectedPaymentType = newValue;
                  },
                  items: <String>['Devoir', 'Don', 'Cadeau']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),

                // Montant (argent donné)
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: "Montant",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Annuler"),
              ),
              TextButton(
                onPressed: () {

                  String amount = amountController.text;

                  // Récupérer la date depuis selectedDate
                  String date = selectedDate?.toString() ?? 'Aucune date sélectionnée';

                  // Action avec les données saisies
                  print("Nom: $selectedName, Montant: $amount, Date: $date");
                  print("Exemple sélectionné: $selectedExample");
                  print("Type de paiement: $selectedPaymentType");

                  Navigator.of(context).pop(); // Fermer la popup
                },
                child: const Text("Ajouter"),
              ),
            ],
          ),
        ),
      );
    },
  );
}