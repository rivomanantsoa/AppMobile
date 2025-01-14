import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:forgod/variable_global/globale_state.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);

    return ListView.builder(
      itemCount: globalState.transactions.length,
      itemBuilder: (context, index) {
        final transaction = globalState.transactions[index];
        return ListTile(
          title: Text(transaction["name"]),
          subtitle: Text("${transaction["raison"]} - ${transaction["type"]}"),
          trailing: Text("${transaction["montant"]} Ar"),
        );
      },
    );
  }
}
