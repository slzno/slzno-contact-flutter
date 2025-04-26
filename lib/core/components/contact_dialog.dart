import 'package:contact_flutter/core/entities/contact.dart';
import 'package:flutter/material.dart';

/// Diálogo que permite agregar un nuevo contacto mediante un formulario.
class AddContactDialog extends StatefulWidget {
  const AddContactDialog({super.key});

  /// Metodo que construye el diálogo de agregar contacto.
  @override
  State<AddContactDialog> createState() => _AddContactDialogState();
}

/// Clase que maneja el estado del diálogo de agregar contacto.
class _AddContactDialogState extends State<AddContactDialog> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  /// Metodo que se ejecuta al cerrar el diálogo y libera los controladores.
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nuevo Contacto'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Campo para el primer nombre
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              /// Campo para el apellido
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              /// Campo para el correo
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo electrónico'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              /// Campo para el número de teléfono
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        /// Botón para cancelar el diálogo
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        /// Botón para guardar el contacto
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newContact = Contact(
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                email: _emailController.text,
                phoneNumber: _phoneController.text,
              );
              Navigator.of(context).pop(newContact);
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
