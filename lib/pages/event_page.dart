import 'package:flutter/material.dart';
 
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
    return  Center(
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index){
          final event = events[index];
          final avatar = event['avatar'];
          final nom = event['nom'];

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
              title: Text("$nom"),
              trailing: Icon(Icons.more_vert),
            ),
          );
        },
      ),
    );
  }
}
