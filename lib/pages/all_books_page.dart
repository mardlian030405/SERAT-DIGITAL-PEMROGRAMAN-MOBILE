import 'package:flutter/material.dart';
import '../data/book_list.dart'; // Pastikan file ini ada dan berisi daftar books
import '../models/book.dart';
import '../pages/book_detail_page.dart';

class AllBooksPage extends StatelessWidget {
  const AllBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = Colors.deepPurple;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 4,
        title: const Text(
          'Semua Buku 📚',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final Book book = books[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => BookDetailPage(book: book),
              ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: Image.asset(
                      book.cover,
                      width: 100,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'By ${book.author}',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
