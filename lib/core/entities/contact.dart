/// Representa un contacto en la agenda.
class Contact {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  Contact({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  /// Convierte el objeto Contact a un mapa para la base de datos.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  /// Crea un objeto Contact a partir de un mapa de la base de datos.
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
