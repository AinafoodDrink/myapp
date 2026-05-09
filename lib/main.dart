import 'package:flutter/material.dart';
import 'night_routine.dart'; // Menghubungkan ke file malam

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RoutinePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[100],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
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

// Halaman Rutinitas Pagi yang sudah dipercantik (Sesuai Blueprint Minggu 3)
class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  // Daftar skincare pagi Iin
  final Map<String, bool> morningRoutine = {
    "Facial Wash": false,
    "Toner": false,
    "Moisturizer": false,
    "Sunscreen": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rutinitas Pagi ☀️",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink[200],
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: morningRoutine.keys.map((String key) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: const Color(0xFFFFF9FA), // Pink pastel sangat lembut
            child: CheckboxListTile(
              title: Text(
                key,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5A5A5A),
                ),
              ),
              value: morningRoutine[key],
              activeColor: Colors.pink[300],
              checkColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              onChanged: (bool? value) {
                setState(() {
                  morningRoutine[key] = value!;
                });
              },
            ),
          );
        }).toList(),
      ),
      // Tombol Navigasi ke Halaman Malam
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NightRoutinePage()),
          );
        },
        label: const Text("Ke Rutinitas Malam 🌙"),
        icon: const Icon(Icons.nightlight_round),
        backgroundColor: Colors.indigo[300],
        foregroundColor: Colors.white,
      ),
    );
  }
}
