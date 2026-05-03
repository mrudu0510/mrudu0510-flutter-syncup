import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await _authController.signup(
      _emailController.text.trim(),
      _passwordController.text,
      _nameController.text.trim(),
    );

    if (success) {
      Get.offAllNamed('/onboarding');
    } else {
      Get.snackbar(
        'Signup Failed',
        'Could not create account. Please try again.',
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
            colors: [Color(0xFF9C88FF), Color(0xFF6C63FF), Color(0xFF4B44C4)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildForm(),
                  const SizedBox(height: 24),
                  _buildSignupButton(),
                  const SizedBox(height: 20),
                  _buildLoginLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'BLEND',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w900,
            letterSpacing: 8,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Join the community',
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 15,
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
              'Create Account 🚀',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppConstants.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Start your accountability journey',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              validator: Validators.name,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),
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

  Widget _buildSignupButton() {
    return Obx(() => SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _authController.isLoading.value ? null : _signup,
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
                    'Create Account',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ));
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(color: Colors.white.withOpacity(0.85)),
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: const Text(
            'Sign In',
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
