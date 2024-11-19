import 'package:flutter/material.dart';
import '../Services/authentication.dart';
import '../Widget/snackbar.dart';
import 'login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void signOut(BuildContext context) async {
    await AuthMethod().signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
    showSnackBar(context, "Signed out successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => signOut(context),
          )
        ],
      ),
      body: const Center(
        child: Text(
          "Welcome to Home Screen!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
