import 'package:app/data/cuenta.dart';
import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  final Cuenta? cuentaUsuario;
  const Inicio({Key? key, this.cuentaUsuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),

          // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 70),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "http://www.coresigns.com/images/services/info/sign_consulting_3.png"),
                  fit: BoxFit.fitHeight)),
          child: fullBody(context)),
    );
  }

  Widget fullBody(BuildContext context) {
    return Center(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(159, 201, 218, 25),
              borderRadius: BorderRadius.circular(10)),
          child: InicioWidget(context)),
    );
  }

  Widget InicioWidget(BuildContext context) {
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      children: <Widget>[
        //logo(),
        Center(
          child: Text(
            'MAIL: ${cuentaUsuario?.email}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            'PASSWORD: ${cuentaUsuario?.password}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const SizedBox(
          height: 40,
        ),
        logoutButton(context),
      ],
    ));
  }

  Widget logoutButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.app_registration),
              SizedBox(
                width: 7,
              ),
              Text("Register"),
            ],
          ),
          onPressed: () {}),
    );
  }
}
