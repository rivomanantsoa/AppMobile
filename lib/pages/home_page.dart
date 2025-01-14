import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:forgod/pages/take_money.dart';
import 'package:forgod/variable_global/globale_state.dart';

class HomePage extends StatefulWidget {
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
    caisse = widget.initialCaisse;
  }

  void _updateCaisse(int newCaisse) {
    setState(() {
      caisse = newCaisse;
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);

    return  Center(
      child: Column(
          children: [
            // Partie défilable (scrollable)
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Caisse actuelle : ${globalState.caisse} Ar",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      TransactionDisplay(), // Historique des transactions
                    ],
                  ),
                ),
              ),
            ),

            // Bouton fixe
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => TakeMoney(
                      caisse: caisse,
                      onCaisseUpdated: (newCaisse) {
                        globalState.updateCaisse(newCaisse);
                      },
                      onTransactionAdded: (transaction) {
                        globalState.addTransaction(
                          nom: transaction['nom'] as String,
                          raison: transaction['raison'] as String,
                          type: transaction['type'] as String,
                          date: transaction['date'] as DateTime,
                          montant: transaction['montant'] as int,
                        );
                      },
                    ),
                  );
                },
                child: Center(child: const Text("Ajouter une transaction")),

              )
            ),
      ]
      ),
    );


  }
}

class TransactionDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);

    if (globalState.transactions.isEmpty) {
      return const Text("Aucune transaction disponible.");
    }

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Historique des transactions",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: globalState.transactions.where((transaction) => transaction['type'] == "sortie").length,
            itemBuilder: (context, index) {
              // Filtrer les transactions de type "sortie"
              final filteredTransactions = globalState.transactions
                  .where((transaction) => transaction['type'] == "sortie")
                  .toList();
              final transaction = filteredTransactions[index];

                return ListTile(
                  title: Text(
                    "- Date : ${transaction['date']} ${transaction['type']}",
                  ),
                  subtitle: Text(
                    "Raison : ${transaction['raison']}\nMontant : ${transaction['montant']} Ar\nNom : ${transaction['nom']}",
                  ),
                );

            },
          ),
        ],
      ),
    );
  }
}


class TransactionManager extends StatelessWidget {
  final int caisse;
  final Function(int) onCaisseUpdated;

  const TransactionManager({
    super.key,
    required this.caisse,
    required this.onCaisseUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);

    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => TakeMoney(
            caisse: caisse,
            onCaisseUpdated: (newCaisse) {
              globalState.updateCaisse(newCaisse); // Utilise GlobalState
            },
            onTransactionAdded: (transaction) {
              globalState.addTransaction(
                nom: transaction['nom'] as String,
                raison: transaction['raison'] as String,
                type: transaction['type'] as String,
                date: transaction['date'] as DateTime,
                montant: transaction['montant'] as int,
              );
            },
          ),
        );
      },
      child: const Text("Ajouter une transaction"),
    );
  }
}

