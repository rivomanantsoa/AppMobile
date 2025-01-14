import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global_state.dart';

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<GlobalState>().updateCaisse(-300); // Retirer 300 à la caisse
          },
          child: const Text('Retirer 300 Ar'),
        )
    );

  }
}
