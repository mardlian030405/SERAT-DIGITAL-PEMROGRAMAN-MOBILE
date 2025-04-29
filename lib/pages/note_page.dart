import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../models/note.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          return ListView.builder(
            itemCount: noteProvider.notes.length,
            itemBuilder: (context, index) {
              Note note = noteProvider.notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.content),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    noteProvider.deleteNote(index);
                  },
                ),
                onTap: () {
                  _showEditDialog(context, noteProvider, note, index);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context, context.read<NoteProvider>());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, NoteProvider noteProvider) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Catatan'),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Isi Catatan'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final note = Note(
                  title: titleController.text,
                  content: contentController.text,
                );
                noteProvider.addNote(note);
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, NoteProvider noteProvider, Note note, int index) {
    final titleController = TextEditingController(text: note.title);
    final contentController = TextEditingController(text: note.content);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Catatan'),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Isi Catatan'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedNote = Note(
                  title: titleController.text,
                  content: contentController.text,
                );
                noteProvider.updateNote(index, updatedNote);
                Navigator.of(context).pop();
              },
              child: const Text('Perbarui'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }
}
