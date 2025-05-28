import 'package:flutter/material.dart';
import 'note_list_page.dart';
import '../data/book_list.dart';
import '../widgets/book_card.dart';
import 'chatbot_page.dart';
import 'language_detector_page.dart';
import 'all_books_page.dart';
import 'drawing_page.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = Colors.deepPurple;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 4,
        title: const Text(
          'Serat Digital 📚',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LanguageDetectorPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/bannerapp.png'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withAlpha(77),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Navigation
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withAlpha(77),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavIcon(
                      context,
                      icon: Icons.chat_bubble_outline,
                      label: 'ChatBot',
                      color: Colors.white,
                      page: const ChatBotPage(),
                    ),
                    _buildNavIcon(
                      context,
                      icon: Icons.note_add_outlined,
                      label: 'Catatan',
                      color: Colors.white,
                      page: const NoteListPage(),
                    ),
                    _buildNavIcon(
                      context,
                      icon: Icons.search,
                      label: 'Detector',
                      color: Colors.white,
                      page: const LanguageDetectorPage(),
                    ),
                    _buildNavIcon(
                      context,
                      icon: Icons.book,
                      label: 'All Books',
                      color: Colors.white,
                      page: const AllBooksPage(),
                    ),
                    _buildNavIcon(
                      context,
                      icon: Icons.edit,
                      label: 'Drawing',
                      color: Colors.white,
                      page: DrawingPage(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // List of Books
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: books.length,
                itemBuilder: (context, index) => BookCard(book: books[index]),
                separatorBuilder: (context, index) => const SizedBox(height: 16),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: mainColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatBotPage()),
              );
            },
            child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            backgroundColor: Colors.purpleAccent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NoteListPage()),
              );
            },
            child: const Icon(Icons.note_add, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Widget untuk shortcut navicon
  Widget _buildNavIcon(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color color,
        required Widget page,
      }) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha(38),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 28, color: color),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
