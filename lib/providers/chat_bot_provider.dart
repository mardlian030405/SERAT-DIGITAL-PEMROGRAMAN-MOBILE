import 'package:flutter/material.dart';

class ChatBotProvider with ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> messages = [];

  final Map<String, String> _intents = {
    'rekomendasi': 'Aku rekomendasikan:\n- "Belajar Flutter untuk Pemula" 📘\n- "Rahasia Bisnis Online" 📙\n- "Filsafat Modern untuk Semua" 📗\nMau rekomendasi lainnya? 😊',
    'buku': 'Beberapa buku menarik:\n📘 Flutter Basics\n📙 Bisnis Online\n📗 Filsafat Modern',
    'genre': 'Beberapa genre yang tersedia:\n📚 Novel\n💻 Teknologi\n💼 Bisnis\n🎓 Pendidikan\nMau cari buku genre apa nih?',
    'fitur': 'Di aplikasi ini kamu bisa:\n✨ Baca buku\n🔍 Cari buku\n❤️ Tandai favorit\n📝 Buat catatan pribadi\nCoba semua fiturnya ya!',
    'referensi': 'Butuh referensi buku? Coba "Flutter Mastery" untuk developer dan "Creative Writing 101" untuk penulis! ✨',
    'referensi buku': 'Cek "Flutter Mastery" atau "Digital Marketing Guide" 💡',
    'halo': 'Halo juga! 👋 Apa kabar? Semoga harimu menyenangkan ya!',
    'hai': 'Hai! 😊 Apa yang bisa aku bantu hari ini?',
    'assalamualaikum': 'Waalaikumsalam! Semoga harimu diberkahi ya 🌸',
    'apa kabar': 'Aku baik! 🤖 Semoga kamu juga sehat dan semangat terus ya!',
    'kabar': 'Aku baik, terima kasih sudah bertanya! 😊',
    'terima kasih': 'Sama-sama! 🤗 Senang bisa membantu!',
    'makasih': 'Dengan senang hati! Semoga bermanfaat ya!',
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
