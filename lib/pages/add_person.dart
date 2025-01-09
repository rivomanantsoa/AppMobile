import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

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
    super.dispose();
    nameNameController.dispose();
    numberNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  decoration: InputDecoration(
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
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  decoration: InputDecoration(
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
                margin: EdgeInsets.only(bottom: 20),
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(value: 'male', child: Text("Male")),
                    DropdownMenuItem(value: 'female', child: Text("Female")),
                  ],
                  decoration: InputDecoration(
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
                    if (_formkey.currentState!.validate()) {
                      final nameName = nameNameController.text;
                      final numberName = numberNameController.text;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Saving in process...")),
                      );
                      FocusScope.of(context).requestFocus(FocusNode());
                      print(
                          "Bonjour:  $nameName votre numéro de téléphone est : $numberName vous êtes du genre: $selectedGenre");
                      print("Vous êtes né(e) le $selectedDate");
                    }
                  },
                  child: Text("Save"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
