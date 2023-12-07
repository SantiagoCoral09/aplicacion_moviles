import 'dart:convert';
import 'package:app/data/usuario.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String? token;
  int? idUsuario;

  // String url_api = 'http://localhost:1337';
  String url_api = 'https://cuenta-ahorros.onrender.com';
  Future<bool> iniciarSesion(String email, String password) async {
    final response = await http.post(
      Uri.parse('$url_api/api/auth/local'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'identifier': email,
        'password': password,
      }),
    );

    print("Tratando de iniciar sesion");
    print(response.body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      token = responseData['jwt'];
      idUsuario = (responseData['user']['id']);
      print(idUsuario.runtimeType);
      print('Inicio $idUsuario sesion correcto $token');
      return true;
    } else {
      // Error al iniciar sesión (puede ser por la contraseña u otro motivo)
      return false;
    }
  }

  Future<bool> registrar(Usuario nuevoUser) async {
    final response = await http.post(
      Uri.parse('$url_api/api/auth/local/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "username": nuevoUser.email.split(
            '@')[0], // Utiliza la parte antes del símbolo @ como username,
        "email": nuevoUser.email,
        "nombre": nuevoUser.nombre,
        "saldo": 0,
        "celular": nuevoUser.celular,
        "password": nuevoUser.password
      }),
    );

    print("Registrando");
    print(response.body);
    if (response.statusCode == 200) {
      print('Registradooo');
      return true;
    } else {
      print('Registro fallidooo');
      return false;
    }
  }
}

AuthService autenticacion = AuthService();
