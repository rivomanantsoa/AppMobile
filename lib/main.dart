import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forgod/pages/add_money.dart';
import 'package:forgod/pages/event_page.dart';
import 'package:forgod/pages/home_page.dart';
import 'package:forgod/pages/add_person.dart';
import 'package:forgod/pages/show_popup.dart'; // Import du fichier popup.dart
import 'package:forgod/variable_global/globale_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'For God',
      theme: ThemeData(primarySwatch: Colors.purple),

      // Configuration des localisations
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,  // Gère la localisation du matériel Flutter
        GlobalWidgetsLocalizations.delegate,   // Gère les widgets Flutter
      ],

      // Langues supportées
      supportedLocales: [
        const Locale('en', ''),  // Anglais
        const Locale('fr', ''),  // Français
      ],

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: [
          Center(
            child: Text(
              "Home",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: const Text(
              "Add-Money",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: const Text(
              "List",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: const Text(
              "Add-Person",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ][_currentIndex],
      ),
      body: [
        HomePage(initialCaisse: 2000),
        const Center(child: Text("Cliquez sur 'Add' pour ouvrir le popup.")),
        const EventPage(),
        const AddPerson(),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            _openAddMoneyDialog(context); // Utilisation de la fonction depuis popup.dart
          } else {
            setCurrentIndex(index);
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        selectedFontSize: 13,
        unselectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "List",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: "Add-Person",
          ),
        ],
      ),
    );
  }
}

void _openAddMoneyDialog(BuildContext context) {
  final globalState = Provider.of<GlobalState>(context, listen: false);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddMoney(
        caisse: Provider.of<GlobalState>(context, listen: false).caisse,
        onCaisseUpdated: (newCaisse) {
          globalState.updateCaisse(newCaisse);
          // Met à jour la caisse ici si nécessaire
        },
        onTransactionAdded: (transaction) {
          // Gère la transaction ajoutée ici
        },
      );
    },
  );
}






/*void main() {
  runApp(
    MaterialApp(
      home: FieldMaker(),
    ),
  );
}

class FieldMaker extends StatefulWidget {
  const FieldMaker({super.key});

  @override
  State<FieldMaker> createState() => _FieldMakerState();
}

class _FieldMakerState extends State<FieldMaker> {
  late TextEditingController _name;
  late TextEditingController _count;
  int caisse = 4500;
  String displayName = '';
  int displayCount = 0;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _count = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _count.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      displayName = _name.text;
      displayCount = int.tryParse(_count.text) ?? 0; // Convertit en entier ou 0 si invalide
      caisse -= displayCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire'),
      ),
      body: Column(
        children: [
          Test(nom: "Juan", compte: 465),
          Text("Notre caisse est actuellement de : $caisse Ar"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
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
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Submit'),
          ),
          const SizedBox(height: 20),
          if (displayName.isNotEmpty) Test(nom: displayName,
              compte: caisse ),
        ],
      ),
    );
  }
}

class Test extends StatelessWidget {
   Test({Key? key, required this.nom, required this.compte}) : super(key: key);

  final String nom;
  final int compte;


  @override
  Widget build(BuildContext context) {
    return Text(
      '$nom, La caisse principale est de : $compte Ar',
      style: const TextStyle(fontSize: 24),
    );
  }
}
*/


/*import 'package:flutter/material.dart';
import 'package:forgod/leson/my_home_page.dart';
import 'package:provider/provider.dart';
import 'package:forgod/leson/global_state.dart'; // Chemin vers ta classe GlobalState

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalState()), // Fournit l'état global
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),

    );
  }
}
*/



