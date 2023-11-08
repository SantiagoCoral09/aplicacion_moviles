class Cuenta {
  String? email;
  String? password;

  ///guardará el valor de true si inicio sesion
  // bool login;

  Cuenta({
    this.email,
    this.password,
    // this.login = false,
  });

  @override
  String toString() {
    return """
      Informacion de la cuenta: 
      Email: $email, 
      Password: $password,
    """;
  }
}
