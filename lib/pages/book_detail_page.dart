import 'package:flutter/material.dart';
import '../models/book.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final coverHeight = screenWidth * 3 / 2; // Rasio 2:3 (lebar:tinggi)

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cover Buku (Simetris dengan rasio 2:3)
            Container(
              width: screenWidth,
              height: coverHeight,
              margin: const EdgeInsets.only(bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  book.cover,
                  fit: BoxFit.cover, // Crop gambar agar memenuhi container
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.book, size: 50),
                  ),
                ),
              ),
            ),
            // Konten Buku
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By ${book.author}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    book.content,
                    style: const TextStyle(fontSize: 16),
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