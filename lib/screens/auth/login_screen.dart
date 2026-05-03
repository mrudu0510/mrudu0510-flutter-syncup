import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await _authController.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (success) {
      final userController = Get.find();
      if ((userController as dynamic).isOnboardingComplete.value == true) {
        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/onboarding');
      }
    } else {
      Get.snackbar(
        'Login Failed',
        'Invalid credentials. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstants.secondaryColor,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF9C88FF), Color(0xFFB8A9FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  const SizedBox(height: 40),
                  _buildForm(),
                  const SizedBox(height: 24),
                  _buildLoginButton(),
                  const SizedBox(height: 20),
                  _buildSignupLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
          ),
          child: const Center(
            child: Text(
              '🔀',
              style: TextStyle(fontSize: 42),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'BLEND',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w900,
            letterSpacing: 8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Find your accountability partner',
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 14,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back 👋',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppConstants.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Sign in to continue',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              validator: Validators.password,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Obx(() => SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _authController.isLoading.value ? null : _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppConstants.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: _authController.isLoading.value
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppConstants.primaryColor,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ));
  }

  Widget _buildSignupLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white.withOpacity(0.85)),
        ),
        GestureDetector(
          onTap: () => Get.toNamed('/signup'),
          child: const Text(
            'Create one',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
