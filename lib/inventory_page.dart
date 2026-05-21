import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFF8D4B60);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: 8,
          ),
          child: Text(
            "Koleksi Skincare",
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
            "Kelola inventaris produk skincare harianmu agar tidak terlewat tanggal kedaluwarsa.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF7C7879),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Product List
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildProductCard(
                "Gentle Cleanser",
                "SeraVe Hydrating Facial",
                "Exp: 20 Des 2026",
                "Sisa 80%",
                themeColor,
              ),
              _buildProductCard(
                "Toner",
                "Anua Heartleaf 77%",
                "Exp: 15 Jan 2027",
                "Sisa 65%",
                themeColor,
              ),
              _buildProductCard(
                "Vitamin C Serum",
                "SkinCeuticals CE Ferulic",
                "Exp: 08 Okt 2026",
                "Sisa 90%",
                themeColor,
              ),
              _buildProductCard(
                "Sunscreen (SPF 50)",
                "Beauty of Joseon Relief Sun",
                "Exp: 12 Mar 2027",
                "Sisa 40%",
                themeColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(
    String category,
    String name,
    String expDate,
    String status,
    Color themeColor,
  ) {
    return Container(
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
              child: Icon(Icons.spa_outlined, color: themeColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: const Color(0xFF1E1B1C),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    name,
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
                        expDate,
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
                          status,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: themeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
