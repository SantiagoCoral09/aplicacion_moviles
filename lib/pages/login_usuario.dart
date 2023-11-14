import 'package:app/data/cuenta.dart';
import 'package:app/data/usuario.dart';
import 'package:app/pages/inicio.dart';
import 'package:app/pages/registro_usuario.dart';
import 'package:flutter/material.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginUsuario extends StatefulWidget {
  const LoginUsuario({Key? key}) : super(key: key);

  @override
  State<LoginUsuario> createState() => _LoginUsuarioState();
}

class _LoginUsuarioState extends State<LoginUsuario> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 70),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://i.pinimg.com/236x/bb/ff/28/bbff28112f4c75cf11e37360ea0f24af.jpg"),
                  fit: BoxFit.cover)),
          child: fullBody(context)),
    );
  }

  Widget fullBody(BuildContext context) {
    return Center(
      child: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          decoration: BoxDecoration(
              // color: const Color.fromRGBO(159, 201, 218, 25),
              borderRadius: BorderRadius.circular(10)),
          child: loginUsuarioForm(context)),
    );
  }

  Widget loginUsuarioForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 150),
              child: Center(
                child: Image.asset('images/logo.jpeg'),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // Color del borde
                    width: 3.0, // Ancho del borde
                  ),
                ),
                child: const Text(
                  'MAIL',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            email(),
            const SizedBox(
              height: 20,
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
                  'PASSWORD',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            password(),
            const SizedBox(
              height: 40,
            ),
            loginButton(context),
            const SizedBox(
              height: 80,
            ),
            registerButton(context),
            const SizedBox(
              height: 40,
            )
          ],
        ));
  }

  Widget email() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          ///Validar que se ingresen datos en el cmpo de texto
          if (value!.isEmpty) {
            return 'Ingrese el email';
          }
          return null;
        },
        style:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 25),
        decoration: const InputDecoration(
            labelText: "EMAIL",
            labelStyle: TextStyle(color: Color.fromARGB(255, 4, 0, 43)),
            fillColor: Color.fromARGB(230, 255, 255, 255),
            filled: true),
      ),
    );
  }

  Widget password() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        child: PasswordField());
  }

  Widget loginButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          elevation:
              MaterialStateProperty.all(8), // Ajusta la altura de la sombra

          padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(255, 21, 61, 114)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.login),
            SizedBox(
              width: 7,
            ),
            Text(
              'TO ACCESS',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        onPressed: () {
          Usuario usuarioLogin = Usuario();
          if (_formKey.currentState!.validate()) {
            ///Se debe verificar si el usuario está registrado

            usuarioLogin = listaUsuarios.firstWhere(
                (usuario) =>
                    usuario.email ==
                    emailController
                        .text, // Devuelve vacios los atributos si no se encuentra un usuario con el email,
                orElse: () => Usuario(
                      email: "",
                      nombre: "",
                      password: "",
                    ));
            if (usuarioLogin.email == '') {
              //No se encontro el email en la lista
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Container(
                      height: 60,
                      child: const Center(
                        child: Text(
                          'El correo no está registrado',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    backgroundColor: const Color.fromRGBO(125, 25, 12, 15)),
              );
            }
            //Si esta registrado se verifica la contraseña
            else if (usuarioLogin.password != passwordController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Container(
                      height: 60,
                      child: const Center(
                        child: Text(
                          'No es la contraseña correcta',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    backgroundColor: const Color.fromRGBO(125, 25, 12, 15)),
              );
            } else {
//Primero se muestra un cuadro con la informacion registrada
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Ingresa cuenta"),
                      content: Text("${usuarioLogin.email}"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              // Limpia los campos después de guardar
                              emailController.clear();
                              passwordController.clear();

                              // Muestra un mensaje de éxito
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Has iniciado sesión')),
                              );
                              //Se guarda true para saber que inicio sesion
                              // usuarioLogin.login = true;
                              Cuenta cuentaUsuario = Cuenta(
                                  email: usuarioLogin.email,
                                  password: usuarioLogin.password);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Inicio(
                                    cuentaUsuario: cuentaUsuario,
                                  ),
                                ),
                              );
                            },
                            child: const Text("OK")),
                        TextButton(
                            onPressed: () {
                              //Si da clic en cancelar no se guarda la informacion
                              Navigator.pop(context);
                            },
                            child: const Text("Cancelar"))
                      ],
                    );
                  });
            }
          } else {
            ///Si hay campos vacios o no se validaron se muestra un mensaje de alerta
            ///y no se guarda nada
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Faltan campos'),
                  backgroundColor: Color.fromRGBO(125, 25, 12, 15)),
            );
            return;
          }
        },
      ),
    );
  }

  Widget registerButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
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
          elevation:
              MaterialStateProperty.all(8), // Ajusta la altura de la sombra

          padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(255, 21, 114, 21)),
        ),
        child: const Text(
          'Register',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: passwordController,
        obscureText: _obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese la Contraseña';
          }
          return null;
        },
        style:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 25),
        decoration: InputDecoration(
          labelText: "PASSWORD",
          labelStyle: const TextStyle(color: Color.fromARGB(255, 4, 0, 43)),
          fillColor: const Color.fromARGB(230, 255, 255, 255),
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ),
    );
  }
}
