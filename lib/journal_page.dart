import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

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
            "Jurnal Kulit",
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
            "Catat kondisi kulit harian untuk memantau perkembangan rutinitas skincare-mu.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF7C7879),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Journal entries list
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildJournalCard(
                "Hari 3 - Kulit Membaik",
                "21 Mei 2026",
                "Kulit terhidrasi dengan baik setelah double cleansing rutin. Kemerahan di area pipi mulai mereda secara signifikan.",
                "😊 Sangat Baik",
                themeColor,
              ),
              _buildJournalCard(
                "Hari 2 - Review Retinol",
                "20 Mei 2026",
                "Mencoba retinol serum semalam. Tidak ada reaksi iritasi atau breakout pagi ini. Kulit terasa cukup kenyal.",
                "🙂 Baik",
                themeColor,
              ),
              _buildJournalCard(
                "Hari 1 - Kulit Kering",
                "19 Mei 2026",
                "Kulit terasa kering setelah seharian berada di ruangan ber-AC. Perlu hidrasi lebih tinggi dari toner malam ini.",
                "😐 Kering",
                themeColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJournalCard(
    String title,
    String date,
    String notes,
    String mood,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: const Color(0xFF1E1B1C),
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
                    mood,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: const Color(0xFF7C7879),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              notes,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: const Color(0xFF4E4849),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
