import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../component/_widgets.dart';
import '../reset/VerificationPanel.dart';
import '../reset/cubit/verification_cubit.dart';
import 'cubit/auth_Cubit.dart';
import 'cubit/auth_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // Create controllers for login form
        final TextEditingController _emailController =
        TextEditingController(text: state.loginEmail);
        final TextEditingController _passwordController =
        TextEditingController(text: state.loginPassword);

        // Update selection
        _emailController.selection = TextSelection.fromPosition(
          TextPosition(offset: _emailController.text.length),
        );
        _passwordController.selection = TextSelection.fromPosition(
          TextPosition(offset: _passwordController.text.length),
        );

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSocialButton('Apple', 'assets/logo/appleIcon.png'),
              const SizedBox(height: 10),
              _buildSocialButton('Google', 'assets/logo/googleIcon.png'),
              const SizedBox(height: 30),
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.black12)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "or continue with email",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.black12)),
                ],
              ),
              const SizedBox(height: 30),
              CustomTextField(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: "Enter your email",
                onChanged: context.read<AuthCubit>().updateLoginEmail,
                controller: _emailController,
              ),
              const SizedBox(height: 14),
              CustomTextField(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: 'Enter your password',
                obscureText: !state.isLoginPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    state.isLoginPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: state.isLoginPasswordVisible ? null : Colors.grey,
                  ),
                  onPressed: context
                      .read<AuthCubit>()
                      .toggleLoginPasswordVisibility,
                ),
                onChanged: context.read<AuthCubit>().updateLoginPassword,
                controller: _passwordController,
              ),
              const SizedBox(height: 7),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => VerificationCubit(),
                          child: VerificationPanel(),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC2E96A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: state.isLoginLoading
                      ? null // disable button while loading
                      : () async {
                    final cubit = context.read<AuthCubit>();
                    // Start loading
                    cubit.setLoginLoading(false);

                    // TODO: Replace with actual login logic

                    await Future.delayed(const Duration(seconds: 2));
                    // Show success SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Login successfully!",
                          style: TextStyle(color: Color(0xFF286243)),
                        ),
                        backgroundColor: Color(0xFFC2E96A),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        duration: Duration(seconds: 1),
                      ),
                    );

                    // Stop loading
                    cubit.resetForm();
                    cubit.setLoginLoading(true);
                  },
                  child: state.isLoginLoading
                      ? const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Color(0xFF286243),
                        strokeWidth: 2,
                      ),
                    ),
                  )
                      : const Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xFF286243),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle(color: Colors.grey, fontSize: 11),
                        children: [
                          const TextSpan(
                            text: 'By signing up, you agree to our ',
                          ),
                          TextSpan(
                            text: 'Terms of Service ',
                            style: const TextStyle(
                              color: Color(0xFF286243),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: 'and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: Color(0xFF286243),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialButton(String label, String imagePath) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Image.asset(imagePath, width: 24, height: 24),
        label: Text(
          "Login with $label",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
