class Usuario {
  final int? id;
  final String nombre;
  final String celular;
  final String email;
  final String password;
  double saldo;
  final String moneda;

  Usuario(
      {this.id,
      required this.nombre,
      required this.celular,
      required this.email,
      required this.password,
      this.saldo = 0.0,
      this.moneda = 'cop'});

  @override
  String toString() {
    return """
      Informacion del Usuario
      Nombre: $nombre, 
      Email: $email, 
      Password: $password,
      Celular: $celular
    """;
  }

  // Este constructor convierte un mapa JSON en una instancia de Usuario
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        id: json['id'] as int,
        nombre: json['nombre'] as String,
        celular: json['celular'] as String,
        email: json['email'] as String,
        password: json['password'] != null ? json['password'] as String : '',
        saldo: (json['saldo'] as double?) ?? 0.0,
        moneda: json['moneda'] as String);
  }

  // Este método convierte la instancia de Usuario a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'celular': celular,
      'email': email,
      'password': password,
      'saldo': saldo,
      'moneda': moneda,
    };
  }
}
