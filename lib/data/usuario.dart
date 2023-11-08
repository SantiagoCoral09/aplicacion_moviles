class Usuario {
  String? nombre;
  String? email;
  String? password;
  String? telefono;

  bool login;

  Usuario(
      {this.nombre,
      this.email,
      this.password,
      this.telefono,
      this.login = false});

  @override
  String toString() {
    return """
      Informacion del Usuario: 
      Nombre: $nombre, 
      Email: $email, 
      Password: $password,
      Telefono: $telefono,
    """;
  }
}

List<Usuario> listaUsuarios = [];

Usuario usuario1 = Usuario(
    nombre: 'Primer usuario',
    email: 'usuario1@gmail.com',
    password: '1234',
    telefono: '3123456789');

Usuario usuario2 = Usuario(
    nombre: 'Segundo usuario',
    email: 'usuario2@gmail.com',
    password: '123456789',
    telefono: '3219876540');

Usuario usuario3 = Usuario(
    nombre: 'Tercer usuario',
    email: 'usuario3@gmail.com',
    password: '0123456',
    telefono: '3151234567');
