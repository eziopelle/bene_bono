import 'package:flutter/material.dart';

class ParcoursSecond extends StatelessWidget {
  final VoidCallback onCompleted;

  ParcoursSecond({required this.onCompleted, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bene Bono'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: ElevatedButton(
            child: Text('Voir les paniers'),
            onPressed: onCompleted,
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
