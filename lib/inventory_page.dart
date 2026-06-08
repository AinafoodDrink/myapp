import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkincareProduct {
  String category;
  String name;
  DateTime expirationDate;
  String status;
  IconData icon;
  Color iconColor;

  SkincareProduct({
    required this.category,
    required this.name,
    required this.expirationDate,
    required this.status,
    required this.icon,
    required this.iconColor,
  });
}

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final themeColor = const Color(0xFF8D4B60);

  late final List<SkincareProduct> _products;

  @override
  void initState() {
    super.initState();
    _products = [
      SkincareProduct(
        category: 'Gentle Cleanser',
        name: 'SeraVe Hydrating Facial',
        expirationDate: DateTime(2026, 12, 20),
        status: 'Sisa 80%',
        icon: Icons.spa_outlined,
        iconColor: const Color(0xFF8D4B60),
      ),
      SkincareProduct(
        category: 'Toner',
        name: 'Anua Heartleaf 77%',
        expirationDate: DateTime(2027, 1, 15),
        status: 'Sisa 65%',
        icon: Icons.water_drop,
        iconColor: const Color(0xFF5E8C7B),
      ),
      SkincareProduct(
        category: 'Vitamin C Serum',
        name: 'SkinCeuticals CE Ferulic',
        expirationDate: DateTime(2026, 10, 8),
        status: 'Sisa 90%',
        icon: Icons.sunny,
        iconColor: const Color(0xFFE09F3E),
      ),
      SkincareProduct(
        category: 'Sunscreen (SPF 50)',
        name: 'Beauty of Joseon Relief Sun',
        expirationDate: DateTime(2027, 3, 12),
        status: 'Sisa 40%',
        icon: Icons.wb_sunny,
        iconColor: const Color(0xFFEF8354),
      ),
    ];
  }

  String _formatDate(DateTime date) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agt',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    final day = date.day.toString().padLeft(2, '0');
    final month = monthNames[date.month - 1];
    return '$day $month ${date.year}';
  }

  Future<void> _selectExpirationDate(BuildContext context, int index) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _products[index].expirationDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2035),
      helpText: 'Pilih tanggal kedaluwarsa',
      cancelText: 'Batal',
      confirmText: 'Simpan',
    );

    if (picked != null) {
      setState(() {
        _products[index].expirationDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: 8,
          ),
          child: Text(
            'Koleksi Skincare',
            style: GoogleFonts.lora(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: themeColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Kelola inventaris produk skincare harianmu agar tidak terlewat tanggal kedaluwarsa.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF7C7879),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final product = _products[index];
              return _buildProductCard(product, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(SkincareProduct product, int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _selectExpirationDate(context, index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCECEF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(product.icon, color: product.iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: const Color(0xFF1E1B1C),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: const Color(0xFF7C7879),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.event_outlined, size: 14, color: themeColor),
                        const SizedBox(width: 4),
                        Text(
                          'Exp: ${_formatDate(product.expirationDate)}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: themeColor,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCECEF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            product.status,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: themeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ketuk kartu untuk mengubah tanggal kadaluarsa',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: const Color(0xFFB5A3A8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
