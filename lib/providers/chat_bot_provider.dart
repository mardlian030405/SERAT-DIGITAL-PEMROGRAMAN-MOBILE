import 'package:flutter/material.dart';

class ChatBotProvider with ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> messages = [];

  String getBotResponse(String message) {
    message = message.toLowerCase();

    if (message.contains('rekomendasi') || message.contains('buku')) {
      return 'Aku rekomendasikan:\n- "Belajar Flutter untuk Pemula" 📘\n- "Rahasia Bisnis Online" 📙\n- "Filsafat Modern untuk Semua" 📗\nMau rekomendasi lainnya? 😊';
    } else if (message.contains('genre')) {
      return 'Beberapa genre yang tersedia:\n📚 Novel\n💻 Teknologi\n💼 Bisnis\n🎓 Pendidikan\nMau cari buku genre apa nih?';
    } else if (message.contains('fitur')) {
      return 'Di aplikasi ini kamu bisa:\n✨ Baca buku\n🔍 Cari buku\n❤️ Tandai buku favorit\n📝 Lihat detail buku\nCobain fitur-fiturnya ya!';
    } else if (message.contains('referensi') || message.contains('referensi buku')) {
      return 'Butuh referensi buku? Aku sarankan "Flutter Mastery" untuk developer dan "Creative Writing 101" untuk penulis! ✨';
    } else if (message.contains('halo') || message.contains('hai') || message.contains('assalamualaikum')) {
      return 'Halo juga! 👋 Apa kabar? Semoga harimu menyenangkan ya!';
    } else if (message.contains('kabar') || message.contains('apa kabar')) {
      return 'Aku baik! 🤖 Semoga kamu juga sehat dan semangat terus ya! Ada yang bisa kubantu hari ini?';
    } else if (message.contains('terima kasih') || message.contains('makasih')) {
      return 'Sama-sama! 🤗 Senang bisa membantu!';
    } else {
      return 'Maaf, aku belum mengerti. Kamu bisa tanya tentang rekomendasi buku, genre, fitur, atau sekadar menyapa! 🤔';
    }
  }

  void sendMessage() {
    if (controller.text.isEmpty) return;

    messages.add({'sender': 'user', 'text': controller.text});
    messages.add({'sender': 'bot', 'text': getBotResponse(controller.text)});
    controller.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
