import 'package:anert_portal/ui.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart';

void main() async {
  initializeApp(
    apiKey: "AIzaSyCDqi9gZh8LkllsKWGTXJcsGAu2r8ej1Ro",
    authDomain: "anert-1433f.firebaseapp.com",
    databaseURL: "https://anert-1433f-default-rtdb.firebaseio.com",
    projectId: "anert-1433f",
    storageBucket: "anert-1433f.appspot.com",
  );
  runApp(const AnertExporter());
}
