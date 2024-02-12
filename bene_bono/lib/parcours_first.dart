import 'package:flutter/material.dart';

class ParcoursFirst extends StatelessWidget {
  final VoidCallback onCompleted;

  ParcoursFirst({required this.onCompleted, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taille du panier'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: Text('Pour 1-2 personnes - Environ 4kg'),
              subtitle: Text('15,80€ / semaine'),
              onTap: onCompleted,
            ),
          ],
        ),
      ),
    );
  }
}
