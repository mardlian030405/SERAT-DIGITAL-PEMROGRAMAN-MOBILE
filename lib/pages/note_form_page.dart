import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/note_database.dart';

class NoteFormPage extends StatefulWidget {
  final Note? note;
  const NoteFormPage({Key? key, this.note}) : super(key: key);

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.note != null;
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final content = _contentController.text.trim();

      if (_isEditing) {
        final updatedNote = widget.note!.copyWith(
          title: title,
          content: content,
          createdAt: DateTime.now(),
        );
        await NoteDatabase.instance.update(updatedNote);
      } else {
        final newNote = Note(
          title: title,
          content: content,
          createdAt: DateTime.now(),
        );
        await NoteDatabase.instance.create(newNote);
      }
      Navigator.of(context).pop(true); // memberi sinyal bahwa ada perubahan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Catatan' : 'Tambah Catatan'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Isi Catatan',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) => value == null || value.isEmpty ? 'Isi catatan tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Text(_isEditing ? 'Update' : 'Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
