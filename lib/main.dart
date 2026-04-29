import 'package:flutter/material.dart';

void main() {
  runApp(const GlowUpApp());
}

class GlowUpApp extends StatelessWidget {
  const GlowUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GlowUp Daily',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.pink[100]),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5F5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.spa_rounded, size: 100, color: Colors.pink[200]),
              const SizedBox(height: 20),
              const Text(
                "GlowUp Daily",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A4A4A),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Catat rutinitas skincare harianmu untuk kulit impian.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Nanti kita buat navigasi ke Dashboard
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[100],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                child: const Text("Mulai Sekarang"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
