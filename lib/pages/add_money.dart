import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:forgod/variable_global/globale_state.dart';
import 'package:provider/provider.dart';


class AddMoney extends StatefulWidget {
  const AddMoney({
    super.key,
    required this.caisse,
    required this.onCaisseUpdated,
    required this.onTransactionAdded,
  });

  final int caisse;
  final ValueChanged<int> onCaisseUpdated;
  final ValueChanged<Map<String, dynamic>> onTransactionAdded;

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _count;
  String? selectedName;
  String? selectedReason;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _count = TextEditingController();
  }

  @override
  void dispose() {
    _count.dispose();
    super.dispose();
  }

  void _submit(GlobalState globalState) {
    if (_formKey.currentState!.validate()) {
      final int amount = int.tryParse(_count.text) ?? 0;

      // Créez une transaction directement
      globalState.addTransaction(
        nom: selectedName ?? "Inconnu",
        raison: selectedReason ?? "Non spécifiée",
        type: "entrée",
        date: selectedDate ?? DateTime.now(),
        montant: amount,
      );
      // Fermez le dialogue
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("Money added successfully!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Fermer le dialogue
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );

    }
  }




  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Récupération du GlobalState
    final globalState = Provider.of<GlobalState>(context, listen: false);

    return SingleChildScrollView(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Center(child: Text("Adding Money")),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Caisse actuelle : ${globalState.caisse} Ar"),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<GlobalState>(
                  builder: (context, globalState, child) {
                    // Récupération des noms des personnes
                    final names = globalState.personnes.map((person) => person['nom'] as String).toList();

                    return DropdownButtonFormField<String>(
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      value: selectedName,
                      hint: const Text("Sélectionnez un nom"),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedName = newValue;
                        });
                      },
                      validator: (value) =>
                      value == null || value.isEmpty ? "Veuillez sélectionner un nom" : null,
                      items: names.isEmpty
                          ? []
                          : names.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),



              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _count,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Montant',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer un montant";
                    }
                    final amount = int.tryParse(value);
                    if (amount == null || amount <= 0) {
                      return "Entrez un montant valide";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  value: selectedReason,
                  hint: const Text("Raison"),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedReason = newValue;
                    });
                  },
                  validator: (value) =>
                  value == null || value.isEmpty ? "Veuillez sélectionner une raison" : null,
                  items: <String>['Donation', 'Devoir', 'Cadeau', 'Autre...']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                  ),
                  onChanged: (DateTime? value) {
                    setState(() {
                      selectedDate = value;
                    });
                  },
                  validator: (value) =>
                  value == null ? "Veuillez sélectionner une date" : null,
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => _submit(globalState),
            child: const Text('Submit'),
          ),
          ElevatedButton(
            onPressed: _cancel,
            child: const Text(
              'Annuler',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}