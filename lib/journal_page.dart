import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class JournalEntry {
  final String date;
  final String notes;
  final String imagePath;
  final String conditionName;
  final IconData conditionIcon;
  final Color conditionColor;

  JournalEntry({
    required this.date,
    required this.notes,
    required this.imagePath,
    required this.conditionName,
    required this.conditionIcon,
    required this.conditionColor,
  });
}

class _JournalPageState extends State<JournalPage> {
  // State variables
  DateTime _selectedDate = DateTime.now();
  String _selectedCondition = 'Happy';
  final TextEditingController _notesController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error memilih gambar: $e')),
      );
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Ambil Foto'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              if (_selectedImage != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Hapus Gambar'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedImage = null;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEntryImage(String imagePath) {
    final isLocalFile = imagePath.contains('/') && !imagePath.contains('http');
    
    if (isLocalFile) {
      return Image.file(
        File(imagePath),
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 50,
            height: 50,
            color: const Color(0xFFF5D1DB),
            child: const Icon(Icons.broken_image, size: 20),
          );
        },
      );
    } else {
      return Image.network(
        imagePath,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 50,
            height: 50,
            color: const Color(0xFFF5D1DB),
            child: const Icon(Icons.broken_image, size: 20),
          );
        },
      );
    }
  }

  final List<String> _monthNames = [
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

  String get _monthYearLabel => '${_monthNames[_selectedDate.month - 1]} ${_selectedDate.year}';

  List<Map<String, dynamic>> get _calendarDays {
    final weekStart = _selectedDate.subtract(Duration(days: _selectedDate.weekday % 7));
    final dayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return List.generate(7, (index) {
      final date = weekStart.add(Duration(days: index));
      return {
        'day': dayLabels[index],
        'date': '${date.day}',
        'isCurrent': date.month == _selectedDate.month,
        'fullDate': date,
      };
    });
  }

  // Initial history entries to match the screenshot
  final List<JournalEntry> _history = [
    JournalEntry(
      date: "30 April ${DateTime.now().year}",
      notes: "Kulit terasa sangat lembab...",
      imagePath: "https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=150",
      conditionIcon: Icons.sentiment_satisfied_alt_rounded,
      conditionColor: const Color(0xFF8D4B60),
      conditionName: "Lembab", // <--- Tambahkan ini
    ),
    JournalEntry(
      date: "29 April ${DateTime.now().year}",
      notes: "Sedikit kering di area T-zone",
      imagePath: "https://images.unsplash.com/photo-1616683693504-3ea7e9ad6fec?w=150",
      conditionIcon: Icons.water_drop_outlined,
      conditionColor: Colors.blue,
      conditionName: "Kering", // <--- Tambahkan ini
    ),
    JournalEntry(
      date: "28 April ${DateTime.now().year}",
      notes: "Ada kemerahan di pipi kiri",
      imagePath: "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=150",
      conditionIcon: Icons.warning_amber_rounded,
      conditionColor: Colors.orange,
      conditionName: "Iritasi", // <--- Tambahkan ini
    ),
  ];

  // Skin condition options
  final List<Map<String, dynamic>> _conditions = [
    {'name': 'Happy', 'icon': Icons.sentiment_satisfied_alt_rounded},
    {'name': 'Acne', 'icon': Icons.volcano_outlined},
    {'name': 'Dry', 'icon': Icons.water_drop_outlined},
    {'name': 'Sensitive', 'icon': Icons.warning_amber_rounded},
  ];

  void _saveJournal() {
    if (_notesController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Tolong isi catatan jurnal terlebih dahulu!",
            style: GoogleFonts.plusJakartaSans(),
          ),
          backgroundColor: const Color(0xFF8D4B60),
        ),
      );
      return;
    }

    // Determine the icon and color based on selected condition
    IconData conditionIcon = Icons.sentiment_satisfied_alt_rounded;
    Color conditionColor = const Color(0xFF8D4B60);
    if (_selectedCondition == 'Dry') {
      conditionIcon = Icons.water_drop_outlined;
      conditionColor = Colors.blue;
    } else if (_selectedCondition == 'Sensitive') {
      conditionIcon = Icons.warning_amber_rounded;
      conditionColor = Colors.orange;
    } else if (_selectedCondition == 'Acne') {
      conditionIcon = Icons.volcano_outlined;
      conditionColor = Colors.red;
    }

    final dateString = '${_selectedDate.day} ${_monthNames[_selectedDate.month - 1]} ${_selectedDate.year}';

    setState(() {
      _history.insert(
        0,
        JournalEntry(
          date: dateString,
          notes: _notesController.text,
          imagePath:
              _selectedImage?.path ??
              "https://images.unsplash.com/photo-1608248597279-f99d160bfcbc?w=150",
          conditionName: _selectedCondition,
          conditionIcon: conditionIcon,
          conditionColor: conditionColor,
        ),
      );
      _notesController.clear();
      _selectedImage = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Jurnal Hari Ini berhasil disimpan!",
          style: GoogleFonts.plusJakartaSans(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF8D4B60),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFF8D4B60);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 16),
        // Page Title & Subtitle
        Center(
          child: Column(
            children: [
              Text(
                "Jurnal Kulit",
                style: GoogleFonts.lora(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Lacak ritual perawatan dirimu hari ini.",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: const Color(0xFF7C7879),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // 1. Calendar Card
        Container(
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
          child: Column(
            children: [
              // Month Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _monthYearLabel,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: const Color(0xFF1E1B1C),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.chevron_left, color: themeColor, size: 20),
                      const SizedBox(width: 12),
                      Icon(Icons.chevron_right, color: themeColor, size: 20),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Days Grid Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _calendarDays.map((dayMap) {
                  final dayDate = dayMap['fullDate'] as DateTime;
                  final isSelected =
                      dayDate.day == _selectedDate.day &&
                      dayDate.month == _selectedDate.month;
                  final isCurrentMonth = dayMap['isCurrent'] as bool;

                  Color textColor = const Color(0xFF1E1B1C);
                  if (!isCurrentMonth) {
                    textColor = const Color(0xFFC4BFC0);
                  }

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = dayDate;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          dayMap['day'],
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7C7879),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFFCECEF)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            dayMap['date'],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected ? themeColor : textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 2. Kondisi Kulit Card
        Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kondisi Kulit",
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: const Color(0xFF1E1B1C),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _conditions.map((cond) {
                  final isSelected = cond['name'] == _selectedCondition;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCondition = cond['name'];
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFFCECEF)
                                : const Color(0xFFF5F5F5),
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: themeColor, width: 1.5)
                                : null,
                          ),
                          child: Icon(
                            cond['icon'],
                            color: isSelected
                                ? themeColor
                                : const Color(0xFF7C7879),
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cond['name'],
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: isSelected
                                ? themeColor
                                : const Color(0xFF7C7879),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 3. Catatan Hari Ini Card
        Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Catatan hari ini...",
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: const Color(0xFF1E1B1C),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _notesController,
                maxLines: 3,
                style: GoogleFonts.plusJakartaSans(fontSize: 13),
                decoration: InputDecoration(
                  hintText: "Bagaimana perasaan kulitmu hari ini?",
                  hintStyle: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFFC4BFC0),
                    fontSize: 13,
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFF5D1DB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFF5D1DB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: themeColor, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 4. Skin Progress Photo Card
        Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Skin Progress",
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: const Color(0xFF1E1B1C),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _showImagePickerOptions,
                child: _selectedImage != null
                    ? Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : CustomPaint(
                        painter: DashedBorderPainter(
                          color: const Color(0xFFF5D1DB),
                          borderRadius: 12,
                        ),
                        child: Container(
                          height: 80,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                color: themeColor,
                                size: 24,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Unggah Foto",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: const Color(0xFF7C7879),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // 5. Riwayat Jurnal Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Riwayat Jurnal",
              style: GoogleFonts.lora(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            Text(
              "Lihat Semua",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: themeColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // History items
        ..._history.asMap().entries.map((historyEntry) {
          final index = historyEntry.key;
          final entry = historyEntry.value;
          return _buildHistoryCard(entry, themeColor, index);
        }).toList(),
        const SizedBox(height: 24),

        // 6. Simpan Jurnal Button
        Center(
          child: ElevatedButton(
            onPressed: _saveJournal,
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: Text(
              "Simpan Jurnal Hari Ini",
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildHistoryCard(JournalEntry entry, Color themeColor, int index) {
    return GestureDetector(
      onTap: () => _openJournalDetail(entry, index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.015),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildEntryImage(entry.imagePath),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.date,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: const Color(0xFF7C7879),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.notes,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: const Color(0xFF1E1B1C),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(entry.conditionIcon, color: entry.conditionColor, size: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _openJournalDetail(JournalEntry entry, int index) async {
    final updatedEntry = await Navigator.push<JournalEntry>(
      context,
      MaterialPageRoute(
        builder: (_) => JournalDetailPage(entry: entry),
      ),
    );

    if (updatedEntry != null) {
      setState(() {
        _history[index] = updatedEntry;
      });
    }
  }
}

class JournalDetailPage extends StatefulWidget {
  final JournalEntry entry;

  const JournalDetailPage({super.key, required this.entry});

  @override
  State<JournalDetailPage> createState() => _JournalDetailPageState();
}

class _JournalDetailPageState extends State<JournalDetailPage> {
  late TextEditingController _detailNotesController;
  late String _selectedCondition;

  final List<Map<String, dynamic>> _conditions = [
    {'name': 'Happy', 'icon': Icons.sentiment_satisfied_alt_rounded},
    {'name': 'Acne', 'icon': Icons.volcano_outlined},
    {'name': 'Dry', 'icon': Icons.water_drop_outlined},
    {'name': 'Sensitive', 'icon': Icons.warning_amber_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _detailNotesController = TextEditingController(text: widget.entry.notes);
    _selectedCondition = widget.entry.conditionName;
  }

  @override
  void dispose() {
    _detailNotesController.dispose();
    super.dispose();
  }

  IconData get _selectedConditionIcon {
    return _conditions.firstWhere(
      (cond) => cond['name'] == _selectedCondition,
      orElse: () => _conditions.first,
    )['icon'] as IconData;
  }

  Color get _selectedConditionColor {
    switch (_selectedCondition) {
      case 'Dry':
        return Colors.blue;
      case 'Sensitive':
        return Colors.orange;
      case 'Acne':
        return Colors.red;
      default:
        return const Color(0xFF8D4B60);
    }
  }

  void _saveDetail() {
    if (_detailNotesController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan tidak boleh kosong')), 
      );
      return;
    }

    final updatedEntry = JournalEntry(
      date: widget.entry.date,
      notes: _detailNotesController.text,
      imagePath: widget.entry.imagePath,
      conditionName: _selectedCondition,
      conditionIcon: _selectedConditionIcon,
      conditionColor: _selectedConditionColor,
    );

    Navigator.pop(context, updatedEntry);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFF8D4B60);
    final imageWidget = widget.entry.imagePath.contains('/') && !widget.entry.imagePath.contains('http')
        ? Image.file(
            File(widget.entry.imagePath),
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
          )
        : Image.network(
            widget.entry.imagePath,
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
          );

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Jurnal', style: GoogleFonts.lora()),
        backgroundColor: themeColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: imageWidget,
          ),
          const SizedBox(height: 20),
          Text(
            widget.entry.date,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: const Color(0xFF7C7879),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(_selectedConditionIcon, color: _selectedConditionColor, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      _selectedCondition,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w600,
                        color: _selectedConditionColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Ubah Kondisi Kulit',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _conditions.map((cond) {
              final isSelected = cond['name'] == _selectedCondition;
              return ChoiceChip(
                label: Text(cond['name'], style: GoogleFonts.plusJakartaSans()),
                selected: isSelected,
                selectedColor: themeColor.withOpacity(0.2),
                onSelected: (_) {
                  setState(() {
                    _selectedCondition = cond['name'] as String;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Text(
            'Catatan Jurnal',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _detailNotesController,
            maxLines: 6,
            style: GoogleFonts.plusJakartaSans(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Tuliskan perubahan dan kondisi kulit kamu...',
              contentPadding: const EdgeInsets.all(14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFF5D1DB)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _saveDetail,
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Simpan Perubahan',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 220,
      color: const Color(0xFFF5D1DB),
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image, size: 60, color: Colors.white54),
    );
  }
}

// Custom Painter for dashed border on photo upload
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.gap = 4.0,
    this.dashLength = 6.0,
    this.borderRadius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ),
    );

    final dashPath = _buildDashedPath(path, dashLength, gap);
    canvas.drawPath(dashPath, paint);
  }

  Path _buildDashedPath(Path source, double dashLength, double gap) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final double len = draw ? dashLength : gap;
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
