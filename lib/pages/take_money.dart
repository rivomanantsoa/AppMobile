import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:forgod/main.dart';
import 'package:forgod/pages/home_page.dart';

/*class TakeMoney extends StatefulWidget {
  const TakeMoney({
    super.key,
    required this.caisse,
    required this.onCaisseUpdated,
  });

  final int caisse;
  final ValueChanged<int> onCaisseUpdated;

  @override
  State<TakeMoney> createState() => _TakeMoneyState();
}

class _TakeMoneyState extends State<TakeMoney> {
  late TextEditingController _name;
  late TextEditingController _count;
  late int caisse;
  String? selectedName;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _count = TextEditingController();
    caisse = widget.caisse; // Initialisez la caisse locale
  }

  @override
  void dispose() {
    _name.dispose();
    _count.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      int displayCount = int.tryParse(_count.text) ?? 0; // Convertit en entier ou 0 si invalide
      caisse -= displayCount;

      // Appelle le callback pour mettre à jour la caisse dans HomePage
      widget.onCaisseUpdated(caisse);
    });

    Navigator.pop(context); // Ferme la boîte de dialogue
  }

  void _cancel() {
    Navigator.pop(context); // Ferme simplement la boîte de dialogue
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Center(child: const Text("Taking Money")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Caisse  actuel : $caisse Ar"),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
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
                )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _count,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Count',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: selectedName,
              hint: const Text("Reason"),
              onChanged: (String? newValue) {
                selectedName = newValue;
              },
              items: <String>['Wedding', 'Death', 'Gift', 'Other...']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
        ),
            Padding(
                padding: const EdgeInsets.all(8.0),
            child:   DateTimeFormField(
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
            )
          ],
        ),

        actions: [
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Submit'),
          ),
          ElevatedButton(
            onPressed: _cancel,
            child: const Text('Annuler',
            style: TextStyle(
              color: Colors.redAccent
            ),
            ),
          ),
        ],
      ),
    );
  }
}*/

class TakeMoney extends StatefulWidget {
  const TakeMoney({
    super.key,
    required this.caisse,
    required this.onCaisseUpdated,
    required this.onTransactionAdded,
  });

  final int caisse;
  final ValueChanged<int> onCaisseUpdated;
  final ValueChanged<Map<String, dynamic>> onTransactionAdded;

  @override
  State<TakeMoney> createState() => _TakeMoneyState();
}

class _TakeMoneyState extends State<TakeMoney> {
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final int amount = int.tryParse(_count.text) ?? 0;

      // Mise à jour de la caisse
      setState(() {
        widget.onCaisseUpdated(widget.caisse - amount);
      });

      // Ajouter la transaction dans la liste
      widget.onTransactionAdded({
        'name': selectedName,
        'reason': selectedReason,
        'amount': amount,
        'date': selectedDate,
      });

      Navigator.pop(context);
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Center(child: Text("Taking Money")),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Caisse actuelle : ${widget.caisse} Ar"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
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
                  items: <String>['Jean', 'Marie', 'Paul', 'Sophie', 'Luc']
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
                  items: <String>['Mariage', 'Décès', 'Cadeau', 'Autre...']
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
            onPressed: _formKey.currentState?.validate() == true ? _submit : null,
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


