part of login;

class LoginController extends GetxController with GetSingleTickerProviderStateMixin  {
  var http = HttpService.instance;
  var storage = StorageService.instance;

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
      storage.write('jwt_token', user?.token ?? '') ;
      storage.write('userId', user!.id) ;
      Get.offAllNamed(AppRoutes.home);
    }else{
      RequestHandler.errorRequest(Get.context!, message: res.body);
    }

  }

  void setLoading() {
    loading = !loading;
    update();
  }

}
