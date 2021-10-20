import 'package:anert_portal/ui.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart';

final authInputDecoration = InputDecoration(
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  focusColor: fg,
);

class AuthLayer extends StatefulWidget {
  const AuthLayer({Key? key}) : super(key: key);

  @override
  State<AuthLayer> createState() => _AuthLayerState();
}

class _AuthLayerState extends State<AuthLayer> {
  final a = auth();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: a.onAuthStateChanged,
        builder: (context, snap) {
          if (snap.data == null) {
            return const LoginView();
          }
          return const AnertExporter();
        });
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String error = '';
  _login() {
    auth()
        .signInWithEmailAndPassword(
            _emailController.value.text, _passwordController.value.text)
        .onError<FirebaseError>((e, _) {
      setState(() {
        error = e.message;
      });
      return auth().signInWithEmailAndPassword(
          _emailController.value.text, _passwordController.value.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1,
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bg2,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: fg),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  controller: _emailController,
                  decoration: authInputDecoration.copyWith(
                      label: const Text("E-mail"),
                      prefixIcon: const Icon(Icons.email)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: authInputDecoration.copyWith(
                      label: const Text("Password"),
                      prefixIcon: const Icon(Icons.lock),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(error, style: const TextStyle(color: Colors.red)),
              ),
              InkWell(
                onTap: _login,
                child: Container(
                  width: 400,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: fg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Go",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
