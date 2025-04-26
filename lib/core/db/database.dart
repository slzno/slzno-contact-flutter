import 'package:contact_flutter/core/entities/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Clase encargada de manejar todas las operaciones con la base de datos.
class ContactDatabase {
  static final ContactDatabase instance = ContactDatabase._init();
  static Database? _database;

  ContactDatabase._init();

  /// Retorna la instancia actual de la base de datos.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('contacts.db');
    return _database!;
  }

  /// Inicializa la base de datos en el dispositivo.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// Crea la tabla de contactos si no existe.
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        email TEXT NOT NULL,
        phoneNumber TEXT NOT NULL
      )
    ''');
  }

  /// Guarda un nuevo contacto en la base de datos.
  Future<Contact> create(Contact contact) async {
    final db = await instance.database;
    final id = await db.insert('contacts', contact.toMap());
    return contact.copyWith(id: id);
  }

  /// Obtiene todos los contactos almacenados.
  Future<List<Contact>> readAllContacts() async {
    final db = await instance.database;
    final result = await db.query('contacts');
    return result.map((json) => Contact.fromMap(json)).toList();
  }

  /// Cierra la conexión con la base de datos.
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

/// Extensión para crear una copia modificada del contacto.
extension on Contact {
  Contact copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
  }) {
    return Contact(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
