import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'inventory_page.dart';
import 'journal_page.dart';
import 'login_baru.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFDF8F8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8D4B60),
          brightness: Brightness.light,
        ),
      ),
      home: const LoginBaru(),
      routes: {
        '/dashboard': (context) {
          final birthYear = ModalRoute.of(context)?.settings.arguments as int?;
          return MainDashboard(birthYear: birthYear ?? DateTime.now().year - 25);
        },
      },
    );
  }
}

class RoutineTask {
  final String title;
  final String subtitle;
  final bool isMorning;
  bool isCompleted;

  RoutineTask({
    required this.title,
    required this.subtitle,
    required this.isMorning,
    required this.isCompleted,
  });
}

class MainDashboard extends StatefulWidget {
  final int birthYear;

  const MainDashboard({super.key, required this.birthYear});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  bool _hasStarted = false;
  int _currentIndex = 0;
  late List<RoutineTask> _tasks;
  late int _age;
  late String _routineHint;

  @override
  void initState() {
    super.initState();

    _age = 17;
    _routineHint = 'Rutinitas otomatis untuk usia $_age tahun';
    _tasks = _getRoutineTasksForAge(_age);
  }

  int _calculateAge(int birthYear) {
    final currentYear = DateTime.now().year;
    final computedAge = currentYear - birthYear;
    if (computedAge < 8) return 8;
    if (computedAge > 90) return 90;
    return computedAge;
  }
  List<RoutineTask> _getRoutineTasksForAge(int age) {
    if (age < 20) {
      return [
        RoutineTask(
          title: 'Gentle Cleanser',
          subtitle: 'Pembersih lembut untuk kulit muda',
          isMorning: true,
          isCompleted: true,
        ),
        RoutineTask(
          title: 'Moisturizer',
          subtitle: 'Ringan dan non-komedogenik',
          isMorning: true,
          isCompleted: false,
        ),
        RoutineTask(
          title: 'Sunscreen (SPF 50)',
          subtitle: 'Perlindungan penting setiap hari',
          isMorning: true,
          isCompleted: false,
        ),
        RoutineTask(
          title: 'Lip Balm',
          subtitle: 'Mencegah bibir kering',
          isMorning: true,
          isCompleted: false,
        ),
        RoutineTask(
          title: 'Cleansing Water',
          subtitle: 'Bersihkan kotoran dan makeup ringan',
          isMorning: false,
          isCompleted: false,
        ),
        RoutineTask(
          title: 'Night Cream',
          subtitle: 'Nutrisi malam untuk kulit segar',
          isMorning: false,
          isCompleted: false,
        ),
      ];
    }

    if (age < 30) {
      return [
        RoutineTask(
          title: 'Gentle Cleanser',
          subtitle: 'Pembersih lembut yang menyeimbangkan kulit',
          isMorning: true,
          isCompleted: true,
        ),
        RoutineTask(
          title: 'Toner',
          subtitle: 'Menyegarkan dan melembapkan',
          isMorning: true,
          isCompleted: true,
        ),
        RoutineTask(
          title: 'Vitamin C Serum',
          subtitle: 'Mencerahkan dan melindungi kulit',
          isMorning: true,
          isCompleted: false,
        ),
        RoutineTask(
          title: 'Sunscreen (SPF 50)',
          subtitle: 'Perisai harian dari sinar UV',
          isMorning: true,
          isCompleted: false,
        ),
        RoutineTask(
          title: 'Cleansing Balm',
          subtitle: 'Double cleanse untuk sisa makeup',
          isMorning: false,
          isCompleted: true,
        ),
        RoutineTask(
          title: 'Retinol Serum',
          subtitle: 'Perawatan antioksidan ringan',
          isMorning: false,
          isCompleted: false,
        ),
        RoutineTask(
          title: 'Moisturizer',
          subtitle: 'Mengunci kelembapan malam hari',
          isMorning: false,
          isCompleted: false,
        ),
      ];
    }

    return [
      RoutineTask(
        title: 'Gentle Cleanser',
        subtitle: 'Membersihkan tanpa mengeringkan',
        isMorning: true,
        isCompleted: true,
      ),
      RoutineTask(
        title: 'Antioxidant Serum',
        subtitle: 'Perkuat kulit dari radikal bebas',
        isMorning: true,
        isCompleted: true,
      ),
      RoutineTask(
        title: 'Moisturizer',
        subtitle: 'Kaya nutrisi dan menenangkan',
        isMorning: true,
        isCompleted: false,
      ),
      RoutineTask(
        title: 'Sunscreen (SPF 50)',
        subtitle: 'Wajib setiap pagi',
        isMorning: true,
        isCompleted: false,
      ),
      RoutineTask(
        title: 'Cleansing Balm',
        subtitle: 'Hapus debu dan polusi',
        isMorning: false,
        isCompleted: true,
      ),
      RoutineTask(
        title: 'Barrier Cream',
        subtitle: 'Perbaiki lapisan pelindung kulit',
        isMorning: false,
        isCompleted: false,
      ),
      RoutineTask(
        title: 'Eye Cream',
        subtitle: 'Perawatan area mata sensitif',
        isMorning: false,
        isCompleted: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F8),
      body: SafeArea(
        child: IndexedStack(
          index: _hasStarted ? (_currentIndex + 1) : 0,
          children: [
            _buildWelcomePage(),
            _buildTrackerPage(),
            const InventoryPage(),
            const JournalPage(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildWelcomePage() {
    final themeColor = const Color(0xFF8D4B60);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 16),
        // Header Row (Title, Bell, Avatar)
        // Header Row (Title only)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "GlowUp Daily",
              style: GoogleFonts.lora(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Big Image Card with Overlay Text
        Container(
          height: 380,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1608248597279-f99d160bfcbc?w=600',
              ),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color.fromRGBO(0, 0, 0, 0.1),
                  Color.fromRGBO(0, 0, 0, 0.7),
                ],
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "GlowUp Daily",
                  style: GoogleFonts.lora(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Asisten digital untuk kulit sehatmu",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: const Color.fromRGBO(255, 255, 255, 0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Feature Card 1: Ritual Harian
        _buildFeatureCard(
          Icons.auto_awesome_rounded,
          "Ritual Harian",
          "Personalisasi rutinitas skincare pagi dan malam sesuai kebutuhan kulitmu.",
          themeColor,
        ),
        // Feature Card 2: Kelola Produk
        _buildFeatureCard(
          Icons.inventory_2_outlined,
          "Kelola Produk",
          "Lacak masa kadaluarsa dan stok produk kecantikan favoritmu dengan mudah.",
          themeColor,
        ),
        // Feature Card 3: Jurnal Kulit
        _buildFeatureCard(
          Icons.bookmark_added_outlined,
          "Jurnal Kulit",
          "Catat perkembangan kesehatan kulitmu dan lihat hasil dari rutinitasmu.",
          themeColor,
        ),
        const SizedBox(height: 20),
        // "Mulai Sekarang" Button
        ElevatedButton(
          onPressed: () {
            setState(() {
              _hasStarted = true;
              _currentIndex = 0; // Go to Tracker page
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: themeColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Mulai Sekarang",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildFeatureCard(
    IconData icon,
    String title,
    String description,
    Color themeColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.02),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFFCECEF),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: themeColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: const Color(0xFF1E1B1C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: const Color(0xFF4E4849),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackerPage() {
    final themeColor = const Color(0xFF8D4B60);
    final totalTasks = _tasks.length;
    final completedTasks = _tasks.where((t) => t.isCompleted).length;
    final progressPercentage = totalTasks > 0
        ? (completedTasks / totalTasks)
        : 0.0;

    final morningTasks = _tasks.where((t) => t.isMorning).toList();
    final visibleNightTasks = _tasks
        .where((t) => !t.isMorning)
        .take(4)
        .toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 16),
        // Header Row (Avatar, Title, Bell)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF2E1E4), width: 1.5),
              ),
              child: const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
                ),
              ),
            ),
            Text(
              "GlowUp Daily",
              style: GoogleFonts.lora(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            Icon(Icons.notifications_none_rounded, color: themeColor, size: 26),
          ],
        ),
        const SizedBox(height: 30),
        // Section Title: "Rutinitas Hari Ini"
        Text(
          "Rutinitas Hari Ini",
          style: GoogleFonts.lora(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: themeColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _routineHint,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: const Color(0xFF7C7879),
          ),
        ),
        const SizedBox(height: 16),
        // Progress Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.02),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kemajuan Hari Ini",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: const Color(0xFF7C7879),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${(progressPercentage * 100).toInt()}% Ritual Selesai",
                        style: GoogleFonts.lora(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCECEF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "$completedTasks/$totalTasks Langkah",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progressPercentage,
                  minHeight: 8,
                  backgroundColor: const Color(0xFFF2E1E4),
                  valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        // Morning Routine Section
        Row(
          children: [
            Icon(Icons.light_mode_outlined, color: themeColor, size: 24),
            const SizedBox(width: 8),
            Text(
              "Morning Routine",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1B1C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Morning items
        ...morningTasks.map((task) => _buildTaskCard(task)),
        const SizedBox(height: 20),
        // Night Routine Section
        Row(
          children: [
            Icon(Icons.nightlight_round_outlined, color: themeColor, size: 24),
            const SizedBox(width: 8),
            Text(
              "Night Routine",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1B1C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Night items
        ...visibleNightTasks.map((task) => _buildTaskCard(task)),
        const SizedBox(height: 20),
        // Daily Tip Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFCECEF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6D3DD),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.lightbulb_outline_rounded,
                  color: themeColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Tip",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E1B1C),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Don't forget to double cleanse tonight! It helps remove pollutants and sunscreen residue perfectly.",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: const Color(0xFF4E4849),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30), // spacing before nav bar
      ],
    );
  }

  Widget _buildTaskCard(RoutineTask task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.015),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildCheckbox(task),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: const Color(0xFF1E1B1C),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  task.subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: const Color(0xFF7C7879),
                  ),
                ),
              ],
            ),
          ),
          _buildDragHandle(),
        ],
      ),
    );
  }

  Widget _buildCheckbox(RoutineTask task) {
    return GestureDetector(
      onTap: () {
        setState(() {
          task.isCompleted = !task.isCompleted;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: task.isCompleted ? const Color(0xFF8D4B60) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: task.isCompleted
                ? const Color(0xFF8D4B60)
                : const Color(0xFFF5D1DB),
            width: 1.5,
          ),
        ),
        child: task.isCompleted
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : null,
      ),
    );
  }

  Widget _buildDragHandle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:
          List.generate(
                3,
                (index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 3,
                      height: 3,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC4BFC0),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Container(
                      width: 3,
                      height: 3,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC4BFC0),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              )
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.5),
                  child: e,
                ),
              )
              .toList(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.03),
            blurRadius: 15,
            offset: Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(0, Icons.edit_calendar, "Tracker"),
            _buildNavItem(1, Icons.inventory_2_outlined, "Inventory"),
            _buildNavItem(2, Icons.bookmark_outline_rounded, "Journal"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _hasStarted && _currentIndex == index;
    final themeColor = const Color(0xFF8D4B60);

    if (isSelected) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFCECEF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: themeColor, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                color: themeColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          setState(() {
            _hasStarted = true;
            _currentIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: const Color(0xFF7C7879), size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF7C7879),
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
