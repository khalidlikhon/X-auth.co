import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../component/_widgets.dart';
import '../auth_screen.dart';
import '../forms/cubit/auth_Cubit.dart';
import 'cubit/verification_cubit.dart';
import 'cubit/verification_state.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<VerificationCubit, VerificationState>(
          builder: (context, state) {
            final isFormValid =
                state.hasMinLength &&
                    state.hasNumber &&
                    state.hasUpperLower &&
                    state.hasSpecialChar &&
                    state.doPasswordsMatch;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  appBranding(),
                  const SizedBox(height: 30),
                  const Text(
                    'Reset your password',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'The password must be different than before',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 45),

                  // Password field
                  CustomTextField(
                    hintText: 'Enter your password',
                    obscureText: !state.isPasswordVisible,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: state.isPasswordVisible ? null : Colors.grey,
                      ),
                      onPressed: () => context
                          .read<VerificationCubit>()
                          .togglePasswordVisibility(),
                    ),
                    onChanged: (v) => context
                        .read<VerificationCubit>()
                        .updateSignupPassword(v),
                  ),

                  const SizedBox(height: 10),

                  // Password validation errors
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!state.hasMinLength &&
                          state.signupPassword.isNotEmpty)
                        const Text(
                          "• Password must be at least 8 characters",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      if (!state.hasNumber && state.signupPassword.isNotEmpty)
                        const Text(
                          "• Password must include a number",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      if (!state.hasUpperLower &&
                          state.signupPassword.isNotEmpty)
                        const Text(
                          "• Password must have both uppercase & lowercase letters",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      if (!state.hasSpecialChar &&
                          state.signupPassword.isNotEmpty)
                        const Text(
                          "• Password must include a special character (@ # \$ * &)",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Confirm password field
                  CustomTextField(
                    hintText: 'Confirm your password',
                    obscureText: !state.isConfirmPasswordVisible,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isConfirmPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: state.isConfirmPasswordVisible
                            ? null
                            : Colors.grey,
                      ),
                      onPressed: () => context
                          .read<VerificationCubit>()
                          .toggleConfirmPasswordVisibility(),
                    ),
                    onChanged: (v) => context
                        .read<VerificationCubit>()
                        .updateSignupConfirmPassword(v),
                  ),

                  if (!state.doPasswordsMatch &&
                      state.signupConfirmPassword.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        "Passwords must match",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),

                  const SizedBox(height: 30),

                  // Confirm button with loading
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFormValid
                            ? const Color(0xFFC2E96A)
                            : Colors.grey.shade300,
                        foregroundColor: isFormValid
                            ? const Color(0xFF286243)
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isFormValid && !state.isResetPassLoading
                          ? () async {
                        final cubit = context.read<VerificationCubit>();
                        cubit.setResetPassLoading(true);

                        // Simulate password reset delay
                        await Future.delayed(const Duration(seconds: 2));

                        cubit.resetPassword(state.signupPassword);
                        cubit.setResetPassLoading(false);

                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                            content: Text(
                              "Password reset successfully!",
                              style: TextStyle(color: Color(0xFF286243)),
                            ),
                            backgroundColor: Color(0xFFC2E96A),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => AuthCubit(),
                              child: const AuthScreen(),
                            ),
                          ),
                              (route) => false,
                        );
                      }
                          : null,
                      child: state.isResetPassLoading
                          ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Color(0xFF286243),
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        "Confirm",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Cancel button
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.grey, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
