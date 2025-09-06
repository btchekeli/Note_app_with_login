// lib/edit_note.dart

import 'package:flutter/material.dart';
import 'package:note_app/database/database_helper.dart'; // Importe database_helper pour accéder à la classe Note

// La classe Note a été supprimée d'ici pour éviter la duplication.
// Elle est maintenant importée implicitement via `database_helper.dart`.

class EditNotePage extends StatefulWidget {
  final Note? note;

  const EditNotePage({super.key, this.note});

  @override
  EditNotePageState createState() => EditNotePageState();
}

class EditNotePageState extends State<EditNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text
        .trim(); // .trim() supprime tous les espaces blancs inutiles au début et à la fin d'une chaîne de caractères.

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    // Crée une nouvelle note. Si la note existait, on conserve son ID.
    final savedNote = Note(id: widget.note?.id, title: title, content: content);

    // Retourne la note (avec ou sans ID) à la page précédente
    Navigator.pop(context, savedNote);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Nouvelle Note' : 'Modifier'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Titre',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                    fillColor: Color.fromARGB(255, 196, 225, 239),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    labelText: 'Contenu',
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(255, 196, 225, 239),
                    filled: true,
                  ),
                  maxLines: 10,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    onPressed: _saveNote,
                    child: Text(
                      widget.note == null ? 'Ajouter' : 'Modifier',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
