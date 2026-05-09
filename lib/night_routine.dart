import 'package:flutter/material.dart';

class NightRoutinePage extends StatefulWidget {
  const NightRoutinePage({super.key});

  @override
  State<NightRoutinePage> createState() => _NightRoutinePageState();
}

class _NightRoutinePageState extends State<NightRoutinePage> {
  // Daftar produk skincare malam hari
  final List<Map<String, dynamic>> _nightTasks = [
    {'name': 'Micellar Water', 'isChecked': false},
    {'name': 'Facial Wash', 'isChecked': false},
    {'name': 'Toner', 'isChecked': false},
    {'name': 'Serum / Ampoule', 'isChecked': false},
    {'name': 'Night Cream', 'isChecked': false},
    {'name': 'Eye Cream', 'isChecked': false},
    {'name': 'Sleeping Mask', 'isChecked': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Warna sedikit lebih gelap dari yang pagi untuk kesan malam
        backgroundColor: const Color(0xFFF48FB1),
        title: const Row(
          children: [
            Text(
              "Rutinitas Malam",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.nightlight_round, color: Colors.white),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _nightTasks.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: CheckboxListTile(
                title: Text(
                  _nightTasks[index]['name'],
                  style: TextStyle(
                    fontSize: 16,
                    // Efek coret jika sudah dicentang
                    decoration: _nightTasks[index]['isChecked']
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                value: _nightTasks[index]['isChecked'],
                activeColor: const Color(0xFFF48FB1),
                onChanged: (bool? value) {
                  setState(() {
                    _nightTasks[index]['isChecked'] = value!;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
