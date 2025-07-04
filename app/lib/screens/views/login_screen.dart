part of login;

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Login Screen"),);
  }
}

