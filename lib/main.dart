import 'package:app/data/usuario.dart';
import 'package:app/pages/login_usuario.dart';
import 'package:app/pages/registro_usuario.dart';
import 'package:flutter/material.dart';

void main() {
  listaUsuarios.add(usuario1);
  listaUsuarios.add(usuario2);
  listaUsuarios.add(usuario3);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cuenta",
      home: Main(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://i.pinimg.com/236x/bb/ff/28/bbff28112f4c75cf11e37360ea0f24af.jpg",
            ),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 100),
                    child: Center(
                      child: Image.asset('images/logo.jpeg'),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Icon(Icons.supervised_user_circle_outlined,
                          size: 100),
                      const SizedBox(
                        width: 15,
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 3.0,
                            ),
                          ),
                          child: const Text(
                            'Crear una cuenta',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(8),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(16.0),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 21, 114, 21),
                      ),
                    ),
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Icon(Icons.login, size: 100),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 55.0,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width: 3.0,
                          ),
                        ),
                        child: const Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginUsuario(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(8),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(16.0),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 21, 61, 114),
                      ),
                    ),
                    child: const Text(
                      'Ingresar',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
