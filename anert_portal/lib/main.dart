import 'package:anert_portal/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart';

void main() async {
  initializeApp(
    apiKey: "AIzaSyAfSaGED7Pt4WZIj07UezcssdSmdzJqSCA",
    authDomain: "anert-f0be6.firebaseapp.com",
    databaseURL: "https://anert-f0be6-default-rtdb.firebaseio.com",
    projectId: "anert-f0be6",
    storageBucket: "anert-f0be6.appspot.com",
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AuthLayer(),
  ));
}
