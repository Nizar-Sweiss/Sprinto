part of login;

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController controller = Get.put(LoginController());

  final animationX = Get.put(AnimationControllerX());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor,
              mutedPurple,
              secondaryColor,
            ],
            begin: Alignment.centerRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: animationX.animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, animationX.animation.value),
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(24),
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: white,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    title: 'Username',
                    hint: 'yourUserName',
                    controller: controller.usernameController,
                    prefixIcon: Icons.person,
                  ),
                  CustomTextField(
                    title: 'Password',
                    hint: 'yourPassword',
                    controller: controller.passwordController,
                    prefixIcon: Icons.lock,
                    isPassword: true,
                  ),
                  CustomButton(
                    text: 'Login',
                    icon: Icons.arrow_forward_ios_rounded,
                    onPressed: () => controller.signInRequest(),
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
