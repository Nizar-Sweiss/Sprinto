part of login;

class LoginController extends GetxController {
  var http = HttpService();

  User? user;

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  bool loading = false;

  Future<void> signInRequest() async {
    if (Get.context != null) {
      FocusScope.of(Get.context!).unfocus();
    }
    Map body = {
      "userName": usernameController.text,
      "password": passwordController.text,
    };
    var res = await http.post(Get.context, Api.auth, body);

    if (res.statusCode == 200) {
      user = User.fromJson(jsonDecode(res.body));
      Get.offAllNamed(AppRoutes.home);
    } else if (res.statusCode == 401) {
      RequestHandler.errorRequest(Get.context!, message: res.body);
    }
  }

  void setLoading() {
    loading = !loading;
    update();
  }
}
