import 'package:contact_flutter/modules/contacts/contacts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ContactApp());
}

/// Clase principal de la aplicación que inicializa el tema y la pantalla de contactos.
class ContactApp extends StatelessWidget {
  const ContactApp({super.key});

  /// Metodo que construye la aplicación.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slzno Contacts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ContactPage(),
    );
  }
}
