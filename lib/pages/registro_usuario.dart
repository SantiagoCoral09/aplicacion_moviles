import 'package:app/data/auth.dart';
import 'package:app/data/usuario.dart';
import 'package:app/pages/login_usuario.dart';
import 'package:flutter/material.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 70),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    "https://images.pexels.com/photos/9704348/pexels-photo-9704348.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                  ),
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
          child: registerForm(context)),
    );
  }

  Widget registerForm(BuildContext context) {
    return Form(
        key: _formKey2,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 100),
              child: Center(
                child: Image.asset('images/logo.jpeg'),
              ),
            ),
            const SizedBox(
              height: 50,
            ),

            name(),
            const SizedBox(
              height: 20,
            ),

            phone(),
            const SizedBox(
              height: 20,
            ),

            email(),
            const SizedBox(
              height: 20,
            ),
            password(),
            const SizedBox(
              height: 40,
            ),

            ///Boton registrar usuario
            ///
            registrarUsuario(
              context,
            ),

            const SizedBox(
              height: 80,
            ),
            irALogin(context),
            const SizedBox(
              height: 40,
            )
          ],
        ));
  }

  Widget name() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        controller: nameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          ///Validar que se ingresen datos en el cmpo de texto
          if (value!.isEmpty) {
            return 'Ingrese un nombre';
          }

          /// Validar que el nombre contenga solo letras, espacios (tildes)
          if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$').hasMatch(value)) {
            return 'Ingrese un nombre válido';
          }
          return null;
        },
        style:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
        decoration: const InputDecoration(
            labelText: "Registre su nombre",
            labelStyle: TextStyle(color: Color.fromARGB(255, 4, 0, 43)),
            fillColor: Color.fromARGB(230, 255, 255, 255),
            filled: true),
      ),
    );
  }

  Widget phone() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          ///Validar que se ingresen datos en el cmpo de texto
          if (value!.isEmpty) {
            return 'Ingrese su número de celular';
          }
          // Expresión regular para validar números de celular con o sin código de país
          RegExp regExp = RegExp(r'^(\+\d{1,3})?\d{9,}$');
          if (!regExp.hasMatch(value)) {
            return 'Número de celular no válido';
          }
          return null;
        },
        style:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
        decoration: const InputDecoration(
            labelText: "Registre su número de celular",
            labelStyle: TextStyle(color: Color.fromARGB(255, 4, 0, 43)),
            fillColor: Color.fromARGB(230, 255, 255, 255),
            filled: true),
      ),
    );
  }

  Widget email() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          ///Validar que se ingresen datos en el cmpo de texto
          if (value!.isEmpty) {
            return 'Ingrese un correo';
          }
          // Expresión regular para validar una dirección de correo electrónico
          RegExp regExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
          if (!regExp.hasMatch(value)) {
            return 'Dirección de correo electrónico no válida';
          }
          return null;
        },
        style:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
        decoration: const InputDecoration(
            labelText: "Registre su correo electrónico",
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

  Widget registrarUsuario(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          elevation:
              MaterialStateProperty.all(8), // Ajusta la altura de la sombra

          padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(255, 21, 114, 21)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.app_registration),
            SizedBox(
              width: 7,
            ),
            Text(
              'Registrar cuenta',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        onPressed: () {
          if (_formKey2.currentState!.validate()) {
            ///Se debe verificar si el usuario está registrado, verificando su email

            Usuario nuevoUsuario = Usuario(
                nombre: nameController.text,
                celular: phoneController.text,
                email: emailController.text,
                password: passwordController.text);

            //Primero se muestra un cuadro con la informacion registrada
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Registrar cuenta de usuario"),
                    content: Text("$nuevoUsuario"),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            if (await autenticacion.registrar(nuevoUsuario)) {
                              // Se registra exitosamente
                              // Limpia los campos después de guardar
                              nameController.clear();
                              phoneController.clear();
                              emailController.clear();
                              passwordController.clear();

                              // Muestra un mensaje de éxito
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Te has registrado con exito')),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginUsuario(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'El correo ingresado ya está registrado'),
                                  backgroundColor:
                                      Color.fromRGBO(125, 25, 12, 15),
                                ),
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
            ///y no se guarda nada
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Hay campos inválidos, debe completar el formulario de registro'),
                  backgroundColor: Color.fromRGBO(125, 25, 12, 15)),
            );
            return;
          }
        },
      ),
    );
  }

  Widget irALogin(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Cuando se presiona el botón, navega a la página de login
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginUsuario(),
            ),
          );
        },
        style: ButtonStyle(
          elevation:
              MaterialStateProperty.all(8), // Ajusta la altura de la sombra

          padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(255, 21, 61, 114)),
        ),
        child: const Text(
          'Ir a inicio de sesión',
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
    return TextFormField(
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
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
      decoration: InputDecoration(
        labelText: "Registre una contraseña",
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
    );
  }
}
