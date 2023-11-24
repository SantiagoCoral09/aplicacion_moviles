import 'package:app/data/auth.dart';
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
      body: SingleChildScrollView(
        child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 70),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "https://images.pexels.com/photos/9704348/pexels-photo-9704348.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                    ),
                    fit: BoxFit.cover)),
            child: fullBody(context)),
      ),
    );
  }

  Widget fullBody(BuildContext context) {
    return Center(
      child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
          // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          decoration: BoxDecoration(
              color: const Color.fromARGB(120, 255, 255, 255),
              borderRadius: BorderRadius.circular(10)),
          child: loginUsuarioForm(context)),
    );
  }

  Widget loginUsuarioForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          // shrinkWrap: true,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Image.asset(
                  'images/logo.jpeg',
                  width: 200,
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: const Text(
                  'Iniciar sesión',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 50,
            ),
            Container(
              // constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue, // Color del borde
                  width: 3.0, // Ancho del borde
                ),
              ),
              child: const Text(
                'Correo electrónico',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            email(),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue, // Color del borde
                  width: 3.0, // Ancho del borde
                ),
              ),
              child: const Text(
                'Contraseña',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            password(),
            const SizedBox(
              height: 40,
            ),
            loginButton(context),
            const SizedBox(
              height: 40,
            ),
            const Divider(),
            registerButton(context),
            const SizedBox(
              height: 40,
            )
          ],
        ));
  }

  Widget email() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          ///Validar que se ingresen datos en el cmpo de texto
          if (value!.isEmpty) {
            return 'Ingrese el correo electrónico';
          }
          // Expresión regular para validar una dirección de correo electrónico
          RegExp regExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
          if (!regExp.hasMatch(value)) {
            return 'Dirección de correo electrónico no válida';
          }
          return null;
        },
        style:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 17),
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
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: PasswordField());
  }

  Widget loginButton(BuildContext context) {
    return ElevatedButton(
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
            'Ingresar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          ///Se debe verificar si el usuario está registrado
          ///
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Ingresar a la cuenta"),
                  content: Text(emailController.text),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          await autenticacion.iniciarSesion(
                              emailController.text, passwordController.text);
                          print('Iniciando sesion...${autenticacion.token}');
                          if (autenticacion.token != null) {
                            //Inicia sesion
// Limpia los campos después de guardar
                            emailController.clear();
                            passwordController.clear();

                            // Muestra un mensaje de éxito
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Has iniciado sesión'),
                                  backgroundColor:
                                      Color.fromARGB(240, 25, 125, 12)),
                            );

                            Navigator.pushNamed(context, '/inicio');
                          } else {
                            // Ocurre un error al iniciar sesion
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Container(
                                    height: 60,
                                    child: const Center(
                                      child: Text(
                                        'El correo no está registrado o contraseña incorrecta',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  backgroundColor:
                                      const Color.fromRGBO(125, 25, 12, 15)),
                            );
                            Navigator.pop(context);
                          }
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
        } else {
          ///Si hay campos vacios o no se validaron se muestra un mensaje de alerta
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                duration: Duration(milliseconds: 500),
                content: Text(
                  'Faltan campos',
                  style: TextStyle(fontSize: 15),
                ),
                backgroundColor: Color.fromRGBO(125, 25, 12, 15)),
          );
          return;
        }
      },
    );
  }

  Widget registerButton(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: const Text(
              'Si no tiene una cuenta debe registrarse',
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            )),
        ElevatedButton(
          onPressed: () {
            // Cuando se presiona el botón, navega a la página de registro
            Navigator.pushNamed(context, '/registrar');
          },
          style: ButtonStyle(
            elevation:
                MaterialStateProperty.all(8), // Ajusta la altura de la sombra

            padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 21, 114, 21)),
          ),
          child: const Text(
            'Registrarse',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

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
          } else if (value.length < 6) {
            return 'La contraseña debe tener al menos 6 caracteres';
          }
          return null;
        },
        style:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 17),
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
