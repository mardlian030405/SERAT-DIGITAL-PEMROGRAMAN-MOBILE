import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/note_database.dart';
import 'note_form_page.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

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
      MaterialPageRoute(
        builder: (context) => NoteFormPage(note: note),
      ),
    );

    if (result == true) {
      _refreshNotes();
    }
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
      appBar: AppBar(
        title: const Text('Daftar Catatan'),
        backgroundColor: Colors.indigo,
      ),
      body: _notes.isEmpty
          ? const Center(child: Text('Belum ada catatan'))
          : ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          final date = note.createdAt;
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(note.content),
              trailing: PopupMenuButton(
                onSelected: (value) {
                  if (value == 'edit') {
                    _navigateToForm(note: note);
                  } else if (value == 'delete') {
                    _deleteNote(note.id!);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'delete', child: Text('Hapus')),
                ],
              ),
              isThreeLine: true,
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade300,
                child: Text(
                  date.day.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              subtitleTextStyle: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
