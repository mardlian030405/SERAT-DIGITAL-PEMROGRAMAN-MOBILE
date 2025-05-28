import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/note_database.dart';
import 'note_form_page.dart';
import 'note_detail_page.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  Future<void> _refreshNotes() async {
    final notes = await NoteDatabase.instance.readAllNotes();
    setState(() => _notes = notes);
  }

  void _navigateToForm({Note? note}) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NoteFormPage(note: note)),
    );
    if (result == true) _refreshNotes();
  }

  Future<void> _deleteNote(int id) async {
    await NoteDatabase.instance.delete(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Catatan berhasil dihapus')),
    );
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F5), // Light background
      appBar: AppBar(
        title: const Text(
          'Daftar Catatan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: _notes.isEmpty
          ? const Center(
        child: Text(
          'Belum ada catatan',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              title: Text(
                note.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  note.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NoteDetailPage(note: note)),
                );
              },
              trailing: PopupMenuButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                onSelected: (value) {
                  if (value == 'edit') _navigateToForm(note: note);
                  if (value == 'delete') _deleteNote(note.id!);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 18, color: Colors.indigo),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 18, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Hapus'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
