import 'package:flutter/material.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Koleksi Skincare 🧴", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink[200],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProductCard("Moisturizer Gel", "Exp: 20 Desember 2025"),
          _buildProductCard("Sunscreen SPF 50", "Exp: 15 Januari 2026"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Nanti di sini buat fungsi tambah produk
        },
        backgroundColor: Colors.pink[200],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildProductCard(String name, String expDate) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: const Icon(Icons.inventory_2_rounded, color: Colors.pink),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(expDate),
        trailing: const Icon(Icons.edit_calendar, size: 20),
      ),
    );
  }
}

