// lib/liste_notes.dart

import 'package:flutter/material.dart';
import 'package:note_app/edit_note.dart';
import 'package:note_app/home_page.dart';
import 'package:note_app/a_propos.dart';
import 'package:note_app/database/database_helper.dart';

class ListeNotesPage extends StatefulWidget {
  const ListeNotesPage({super.key});

  @override
  State<ListeNotesPage> createState() => _ListeNotesPageState();
}

class _ListeNotesPageState extends State<ListeNotesPage> {
  late Future<List<Note>> notes;

  @override
  void initState() {
    super.initState();
    notes = DatabaseHelper().getNotes();
  }

  void _reloadNotes() {
    setState(() {
      notes = DatabaseHelper().getNotes();
    });
  }

  void _navigateToEditPage({Note? note}) async {
    final returnedNote = await Navigator.push<Note>(
      context,
      MaterialPageRoute(builder: (context) => EditNotePage(note: note)),
    );
    if (returnedNote != null) {
      if (returnedNote.id != null) {
        await DatabaseHelper().updateNote(returnedNote);
      } else {
        await DatabaseHelper().insertNote(returnedNote);
      }
      _reloadNotes();
    }
  }

  Future<void> _deleteNote(Note note) async {
    // Affiche la boîte de dialogue de confirmation
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Supprimer la note ?'),
          content: const Text(
            'Êtes-vous sûr de vouloir supprimer cette note ?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Annuler
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirmer
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      if (note.id == null) return;
      await DatabaseHelper().deleteNote(note.id!);
      _reloadNotes(); // Recharge les notes après la suppression
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text('Liste des notes'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Note>>(
        future: notes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Aucune note enregistrée.',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            final loadedNotes = snapshot.data!;
            return ListView.builder(
              itemCount: loadedNotes.length,
              itemBuilder: (context, index) {
                final note = loadedNotes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 8.0,
                  ),
                  child: Card(
                    elevation: 4,
                    color: Colors.lightBlue[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () => _navigateToEditPage(note: note),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    note.content,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () =>
                                      _navigateToEditPage(note: note),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _deleteNote(note),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToEditPage(),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 4.0,
        color: Colors.lightBlue[100],
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app, size: 40),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            const SizedBox(width: 50),
            IconButton(
              icon: const Icon(Icons.person, size: 40),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AProposPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
