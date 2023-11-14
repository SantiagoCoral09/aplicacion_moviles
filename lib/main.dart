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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Para que no salga la etiqueta de debug en la esquina del celular
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
            // imagen de fondo
            image: DecorationImage(
                image: NetworkImage(
                    "https://i.pinimg.com/236x/bb/ff/28/bbff28112f4c75cf11e37360ea0f24af.jpg"),
                fit: BoxFit.fitHeight)),
        child: Center(
          child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            // padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
            decoration: BoxDecoration(
                // color: const Color.fromRGBO(159, 201, 218, 25),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),

                //logo

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
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
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
                            color: Colors.blue, // Color del borde
                            width: 3.0, // Ancho del borde
                          ),
                        ),
                        child: const Text(
                          'CREATE YOUR \n ACCOUNT',
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
                    // Cuando se presiona el botón, navega a la página de registro
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Register(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(
                        8), // Ajusta la altura de la sombra

                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 21, 114, 21)),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 80),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
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
                          horizontal: 55.0, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue, // Color del borde
                          width: 3.0, // Ancho del borde
                        ),
                      ),
                      child: const Text(
                        'LOGIN',
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
                    // Lógica para el boton de login
                    // Cuando se presiona el botón, navega a la página de login
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginUsuario(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(
                        8), // Ajusta la altura de la sombra

                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 21, 61, 114)),
                  ),
                  child: const Text(
                    'TO ACCESS',
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
    );
  }
}
