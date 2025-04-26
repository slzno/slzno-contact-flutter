import 'package:contact_flutter/core/components/contact_dialog.dart';
import 'package:contact_flutter/core/db/database.dart';
import 'package:contact_flutter/core/entities/contact.dart';
import 'package:flutter/material.dart';

/// Pantalla que muestra la lista de contactos guardados.
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactListPageState();
}

/// Clase que maneja el estado de la pantalla de contactos.
/// Carga los contactos desde la base de datos y permite añadir nuevos.
class _ContactListPageState extends State<ContactPage> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  /// Carga los contactos desde la base de datos.
  Future<void> _loadContacts() async {
    final loadedContacts = await ContactDatabase.instance.readAllContacts();
    setState(() {
      contacts = loadedContacts;
    });
  }

  /// Abre el diálogo para añadir un nuevo contacto.
  Future<void> _addContact() async {
    final newContact = await showDialog<Contact>(
      context: context,
      builder: (_) => const AddContactDialog(),
    );

    if (newContact != null) {
      await ContactDatabase.instance.create(newContact);
      _loadContacts();
    }
  }

  /// Muestra un diálogo de confirmación para eliminar todos los contactos.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slzno Contacts', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final c = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(c.firstName[0]),
            ),
            title: Text('${c.firstName} ${c.lastName}'),
            subtitle: Text('${c.email}\n${c.phoneNumber}'),
            isThreeLine: true,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addContact,
        child: const Icon(Icons.add),
      ),
    );
  }
}
