import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_detector_provider.dart';

class LanguageDetectorPage extends StatefulWidget {
  const LanguageDetectorPage({super.key});

  @override
  LanguageDetectorPageState createState() => LanguageDetectorPageState();
}

class LanguageDetectorPageState extends State<LanguageDetectorPage> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();  // Inisialisasi controller
  }

  @override
  void dispose() {
    textController.dispose();  // Pastikan controller dibersihkan saat halaman dibuang
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageDetectorProvider>(context);
    final themeColor = Colors.indigo.shade600; // Warna aksen elegan

    // Helper function untuk opacity
    Color withOpacity(Color color, double opacity) {
      return color.withAlpha((opacity * 255).toInt());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deteksi Bahasa Serat'),
        backgroundColor: themeColor,
        elevation: 0,  // Membuat appBar lebih elegan
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade50, Colors.blueGrey.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              shadowColor: Colors.black.withOpacity(0.4),
              color: withOpacity(Colors.white, 0.9), // Menggunakan helper function
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Masukkan Teks Serat',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: textController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        hintText: 'Tulis atau tempel teks di sini...',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: themeColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: themeColor, width: 2),
                        ),
                      ),
                      onChanged: (value) {
                        languageProvider.detectLanguage(value);
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Hasil Deteksi:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: withOpacity(themeColor, 0.1), // Menggunakan helper function
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: withOpacity(themeColor, 0.4)), // Menggunakan helper function
                      ),
                      child: Text(
                        languageProvider.detectedLanguage.isEmpty
                            ? 'Belum ada teks'
                            : languageProvider.detectedLanguage,
                        style: TextStyle(
                          fontSize: 18,
                          color: themeColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.clear, color: Colors.white),
                      label: const Text(
                        'Bersihkan Teks',
                        style: TextStyle(
                          color: Colors.white, // Warna teks tombol
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        textController.clear();
                        languageProvider.detectLanguage('');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
