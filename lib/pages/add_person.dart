import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:forgod/variable_global/globale_state.dart';
import 'package:provider/provider.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({super.key});

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final _formkey = GlobalKey<FormState>();
  final nameNameController = TextEditingController();
  final numberNameController = TextEditingController();
  String selectedGenre = "male";
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    nameNameController.dispose();
    numberNameController.dispose();
    super.dispose();
  }

  void _submit(GlobalState globalState) {
    if (_formkey.currentState!.validate()) {
      globalState.addPerson(
        nom: nameNameController.text,
        genre: selectedGenre,
        date: selectedDate,
        number: numberNameController.text,
      );

      // Réinitialiser les champs
      nameNameController.clear();
      numberNameController.clear();
      setState(() {
        selectedGenre = "male";
        selectedDate = DateTime.now();
      });

      // Afficher un dialogue de confirmation
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("Person added successfully!"),
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

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Name of the person",
                    hintText: "Please enter the name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "You should fill out the field";
                    }
                    return null;
                  },
                  controller: nameNameController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Phone number",
                    hintText: "Please enter the phone number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "You should fill out the field";
                    }
                    return null;
                  },
                  controller: numberNameController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(value: 'male', child: Text("Male")),
                    DropdownMenuItem(value: 'female', child: Text("Female")),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  value: selectedGenre,
                  onChanged: (value) {
                    setState(() {
                      selectedGenre = value!;
                    });
                  },
                ),
              ),
              DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Date',
                  border: OutlineInputBorder(),
                ),
                firstDate: DateTime.now().add(const Duration(days: 10)),
                lastDate: DateTime.now().add(const Duration(days: 40)),
                initialPickerDateTime:
                DateTime.now().add(const Duration(days: 20)),
                onChanged: (DateTime? value) {
                  setState(() {
                    selectedDate = value!;
                  });
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _submit(globalState);
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
