import 'package:flutter/material.dart';
import 'package:note_app/home_page.dart';

void main() {
  runApp(const MyNoteApp());
}

class MyNoteApp extends StatelessWidget {
  const MyNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notify',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
