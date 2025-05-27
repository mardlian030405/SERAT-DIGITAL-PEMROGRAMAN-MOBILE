import 'package:flutter/material.dart';

class ChatBotProvider with ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> messages = [];

  final Map<String, String> _intents = {
    'rekomendasi': 'Aku rekomendasikan:\n- "Belajar Flutter" 📘\n- "Pemrograman Dasar" 📙\n- "Pemrograman Website Seri PHP" 📗\nMau rekomendasi lainnya? 😊',
    'buku': 'Berikut beberapa buku yang tersedia:\n📘 Belajar Flutter\n📙 Pemrograman Dasar\n📗 Python Programming\n📕 PHP\n📓 MATLAB\nTanyakan judul untuk info lengkap!',
    'genre': 'Beberapa genre yang tersedia:\n💻 Teknologi\n🎓 Pendidikan\n💼 Bisnis\n📚 Pemrograman\nMau cari buku genre apa nih?',
    'fitur': '''
Aplikasi ini punya fitur keren:
📚 Baca Buku – Jelajahi berbagai buku pemrograman.
📝 Catatan – Tulis ide atau rangkumanmu.
🎨 Gambar – Ekspresikan dirimu lewat drawing tool.
🌐 Deteksi Bahasa – Kenali bahasa secara otomatis.
💬 Chatbot – Tanyakan apapun tentang buku dan fitur.
🕘 Riwayat – Lihat buku yang pernah kamu baca.
''',
    'referensi': 'Berikut referensi buku berdasarkan isi:\n- "Belajar Flutter" oleh Andi Wijaya: Cocok untuk belajar UI & API di Flutter.\n- "Pemrograman Dasar" oleh Budi Santoso: Untuk pemula belajar coding.\n- "MATLAB" oleh Prof. Dr. Sahyar: Ideal untuk mahasiswa teknik.',
    'referensi buku': 'Coba baca:\n📘 "Belajar Flutter"\n📙 "Pemrograman Dasar"\n📕 "PHP untuk Website"\n📓 "MATLAB untuk Teknik dan Sains"',
    'flutter': '📘 Buku "Belajar Flutter" oleh Andi Wijaya:\nBahas widget, layout, state, API, dan proyek Flutter. Cocok untuk pemula maupun pengembang.',
    'pemrograman dasar': '📙 Buku "Pemrograman Dasar" oleh Budi Santoso:\nAjarkan konsep coding: variabel, fungsi, OOP, hingga logika algoritma.',
    'python': '📗 Buku "Python Programming For Beginners":\nPanduan belajar Python: perulangan, fungsi, dan file handling disertai proyek mini.',
    'php': '📕 Buku "Pemrograman Website Seri PHP" oleh Rizki Hidayatullah:\nBahas PHP, form, database, login system, dan proyek CRUD.',
    'matlab': '📓 Buku "MATLAB" oleh Prof. Dr. Sahyar:\nKomputasi numerik dan grafik untuk teknik & sains dengan contoh praktis.',
    'halo': 'Halo juga! 👋 Ada yang bisa aku bantu hari ini?',
    'hai': 'Hai! 😊 Apa kabar? Cari buku atau tanya fitur aplikasi yuk!',
    'assalamualaikum': 'Waalaikumsalam! Semoga harimu berkah dan penuh semangat 🌸',
    'apa kabar': 'Aku baik! 🤖 Semoga kamu juga sehat dan semangat terus ya!',
    'kabar': 'Aku baik, terima kasih sudah tanya! 😊',
    'terima kasih': 'Sama-sama! Senang bisa membantu 🤗',
    'makasih': 'Dengan senang hati! 😊 Semoga bermanfaat ya!',
  };

  String getBotResponse(String message) {
    final msg = message.toLowerCase();

    for (final intent in _intents.keys) {
      if (msg.contains(intent)) {
        return _intents[intent]!;
      }
    }

    return 'Maaf, aku belum mengerti. Kamu bisa tanya tentang rekomendasi buku, genre, fitur, atau sekadar menyapa! 🤔';
  }

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    final userMessage = controller.text.trim();
    messages.add({'sender': 'user', 'text': userMessage});

    final botReply = getBotResponse(userMessage);
    messages.add({'sender': 'bot', 'text': botReply});

    controller.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
