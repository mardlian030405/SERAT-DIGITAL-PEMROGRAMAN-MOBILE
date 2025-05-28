import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteDetailPage extends StatelessWidget {
  final Note note;

  const NoteDetailPage({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        backgroundColor: Colors.indigo,  // Warna AppBar menjadi indigo
      ),
      body: SingleChildScrollView( // Tambahkan scroll di sini
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Dibuat pada: ${note.createdAt.toLocal()}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              note.content,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
