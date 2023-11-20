import 'dart:convert';
import 'package:app/data/usuario.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String? token;
  int? idUsuario;

  Future<bool> verificarCorreoRegistrado(String email) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:1337/api/users?email=$email'),
      );
      print(response);

      if (response.statusCode == 200) {
        // final List<dynamic> data = jsonDecode(response.body);
        return true; // Retorna true si hay usuarios con ese correo
      } else {
        return false; // Retorna false en caso de error
      }
    } catch (e) {
      print('Exxcepcion');
      print(e);
      return false; // Retorna false en caso de excepción
    }
  }

  Future<bool> iniciarSesion(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:1337/api/auth/local'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'identifier': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      token = responseData['jwt'];
      idUsuario = responseData['user']['id'];
      print('Inicio $idUsuario sesion correcto $token');
      return true;
    } else {
      // Error al iniciar sesión (puede ser por la contraseña u otro motivo)
      return false;
    }
  }

  Future<bool> registrar(Usuario nuevoUser) async {
    final response = await http.post(
      Uri.parse('http://localhost:1337/api/auth/local/register'),
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
