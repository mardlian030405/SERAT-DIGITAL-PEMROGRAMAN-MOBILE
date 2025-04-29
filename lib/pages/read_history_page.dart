import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/read_history_provider.dart';

class ReadHistoryPage extends StatelessWidget {
  const ReadHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final readHistory = Provider.of<ReadHistoryProvider>(context).readToday;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku yang Dibaca Hari Ini'),
        backgroundColor: Colors.deepPurple,
      ),
      body: readHistory.isEmpty
          ? const Center(child: Text('Belum ada buku yang dibaca hari ini.'))
          : ListView.builder(
        itemCount: readHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.book_outlined),
            title: Text(readHistory[index]),
          );
        },
      ),
    );
  }
}
