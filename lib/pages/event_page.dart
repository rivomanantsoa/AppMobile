import 'package:flutter/material.dart';
import 'package:forgod/variable_global/globale_state.dart';
import 'package:provider/provider.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  final events = [
    {
      "nom": "Rivomanantsoa ny setra juan",
      "avatar": "avatar6"
    },
    {
      "nom": "Riantsoa ny hary sarobidy",
      "avatar": "avatar5"
    },
    {
      "nom": "Marana ny Tiana mendrika",
      "avatar": "avatar3"
    },
    {
      "nom": "Lanja ny hary mendrika",
      "avatar": "avatar2"
    },
    {
      "nom": "Rivomanantsoa ny setra juan",
      "avatar": "avatar6"
    },
    {
      "nom": "Riantsoa ny hary sarobidy",
      "avatar": "avatar5"
    },
    {
      "nom": "Marana ny Tiana mendrika",
      "avatar": "avatar3"
    },
    {
      "nom": "Lanja ny hary mendrika",
      "avatar": "avatar2"
    },
    {
      "nom": "Rivomanantsoa ny setra juan",
      "avatar": "avatar6"
    },
    {
      "nom": "Riantsoa ny hary sarobidy",
      "avatar": "avatar5"
    },
    {
      "nom": "Marana ny Tiana mendrika",
      "avatar": "avatar3"
    },
    {
      "nom": "Lanja ny hary mendrika",
      "avatar": "avatar2"
    }
  ];

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);
    return  Center(
      child: ListView.builder(
        itemCount: globalState.personnes.length,
        itemBuilder: (context, index){
          final event = events[index];
          final avatar = event['avatar'];
         // final nom = event['nom'];*/
          final tab = globalState.personnes[index];
          final name = tab["nom"];


          return  Card(
            child: ListTile(
              leading: ClipOval(
                child: Image.asset(
                  "assets/images/$avatar.png",
                  width: 50, // Largeur de l'image
                  height: 50, // Hauteur de l'image
                  fit: BoxFit.cover, // Pour s'assurer que l'image remplit le cercle
                ),
              ),
              title: Text("$name"),
              trailing: Icon(Icons.more_vert),
            ),
          );
        },
      ),
    );
  }
}
