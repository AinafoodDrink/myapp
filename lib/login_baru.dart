import 'package:flutter/material.dart';

class LoginBaru extends StatelessWidget {
  const LoginBaru({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("GlowUp Daily", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const TextField(decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
              const SizedBox(height: 10),
              const TextField(decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Langsung pindah halaman tanpa cek apapun
                  Navigator.of(context).pushReplacementNamed('/dashboard');
                },
                child: const Text("MASUK"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}