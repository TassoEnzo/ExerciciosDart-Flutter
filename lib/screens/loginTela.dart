import 'package:flutter/material.dart';
import '../widgets/loginForm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Pagina")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FlutterLogo(size: 120),
            SizedBox(height: 20),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
