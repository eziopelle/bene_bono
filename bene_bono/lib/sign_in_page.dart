import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'parcours_first.dart';
import 'parcours_second.dart';
import 'success.dart';

class SignInPage extends StatelessWidget {
  // Initialisation des contrôleurs pour champs mail + MP
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Fonction d'A/B test en fonction de la 1er lettre si elle est minuscule ou non
  void navigateBasedOnUserId(BuildContext context, String userId) {
    bool isFirstLetterLowercase = userId[0].toLowerCase() == userId[0];

    // Determine la callback à la fin du parcours
    VoidCallback onCompleted = isFirstLetterLowercase
        ? () => navigateToParcoursSecond(context)
        : () => navigateToParcoursFirst(context);

    // Lancement du parcours en fonction de la 1er lettre
    if (isFirstLetterLowercase) {
      navigateToParcoursFirst(context, onCompleted);
    } else {
      navigateToParcoursSecond(context, onCompleted);
    }
  }

  // Go parcoursFirst + callback
  void navigateToParcoursFirst(BuildContext context, [VoidCallback? onCompleted]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParcoursFirst(onCompleted: onCompleted ?? () => navigateToSuccess(context)),
      ),
    );
  }

  // Go ParcoursSecond + callback
  void navigateToParcoursSecond(BuildContext context, [VoidCallback? onCompleted]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParcoursSecond(onCompleted: onCompleted ?? () => navigateToSuccess(context)),
      ),
    );
  }

  // Navigation vers Success
  void navigateToSuccess(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Success()));
  }

  @override
  Widget build(BuildContext context) {
    // Page de co
    return Scaffold(
      appBar: AppBar(
        title: Text('Créez votre compte'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Champ mail
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Adresse mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 8.0),
            // Champ MP
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true, //cacher les caractères :)
            ),
            SizedBox(height: 24.0),
            // Bouton  de création du compte
            ElevatedButton(
              child: Text('Créer mon compte'),
              onPressed: () async {
                try {
                  // essais pour créer le compte dans le base
                  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  // Si c'est réussi on lance le début du parcours
                  navigateBasedOnUserId(context, userCredential.user!.uid);
                } on FirebaseAuthException catch (e) {
                  // Sinon pas de logique pour cet exercice, juste display une erreur.
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                onPrimary: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
