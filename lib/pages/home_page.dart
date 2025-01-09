import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forgod/pages/take_money.dart';

/*class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.initialCaisse});
  final int initialCaisse;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int caisse;

  @override
  void initState() {
    super.initState();
    caisse = widget.initialCaisse; // Initialisez la caisse à sa valeur initiale
  }

  void _updateCaisse(int newCaisse) {
    setState(() {
      caisse = newCaisse; // Met à jour la caisse
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/money.svg",
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Transaction",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.real_estate_agent_outlined,
                            color: Colors.red,
                            size: 45,
                          ),
                          tooltip: 'Doing Transaction!',
                          onPressed: () {
                            // Ouvre la boîte de dialogue TakeMoney avec la fonction de mise à jour
                            showDialog(
                              context: context,
                              builder: (context) => TakeMoney(
                                caisse: caisse,
                                onCaisseUpdated: _updateCaisse,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Notre caisse actuelle est de : $caisse Ar",
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}*/

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.initialCaisse});
  final int initialCaisse;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int caisse;
  final List<Map<String, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    caisse = widget.initialCaisse;
  }

  void _updateCaisse(int newCaisse) {
    setState(() {
      caisse = newCaisse;
    });
  }

  void _addTransaction(Map<String, dynamic> transaction) {
    setState(() {
      transactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Transactions",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                Text("Caisse actuelle : $caisse Ar"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => TakeMoney(
                        caisse: caisse,
                        onCaisseUpdated: _updateCaisse,
                        onTransactionAdded: _addTransaction,
                      ),
                    );
                  },
                  child: const Text("Ajouter une transaction"),
                ),
                const SizedBox(height: 20),
                if (transactions.isNotEmpty) ...[
                  const Text(
                    "Historique des transactions",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true, // Permet à la liste de s'adapter à son contenu
                    physics: const NeverScrollableScrollPhysics(), // Désactive le défilement interne
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return ListTile(
                        title: Text(" Date : ${transaction['date']}"),
                        subtitle: Text(
                          "Raison : ${transaction['reason']}\nMontant : ${transaction['amount']} Ar\nNom : ${transaction['name']}",
                        ),
                      );
                    },
                  ),
                ] else
                  const Text("Aucune transaction disponible."),
              ],
            ),
          ),
        ),
      );
  }

}


