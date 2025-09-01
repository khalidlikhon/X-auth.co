import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/_widgets.dart';
import 'cubit/verification_cubit.dart';
import 'cubit/verification_state.dart';
import 'verifyCode_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            /// Branding
            appBranding(),
            const SizedBox(height: 30),

            const Text(
              'Forgot Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Enter your email account to reset password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 25),

            /// Illustration
            Center(
              child: Container(
                width: 400,
                height: 325,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  'assets/logo/forgetpassIcon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 40),

            /// Email field
            BlocBuilder<VerificationCubit, VerificationState>(
              builder: (context, state) {
                return Column(
                  children: [
                    CustomTextField(
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintText: "Enter your email",
                      onChanged: (value) =>
                          context.read<VerificationCubit>().updateEmail(value),
                    ),
                    if (state.email.isNotEmpty && !state.isEmailValid)
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          "Please enter a valid email",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 25),

            /// Continue button
            BlocBuilder<VerificationCubit, VerificationState>(
              builder: (context, state) {
                return SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.isEmailValid
                          ? const Color(0xFFC2E96A)
                          : Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: state.isEmailValid && !state.isSendCodeLoading
                        ? () async {
                            final cubit = context.read<VerificationCubit>();
                            final email = state.email.trim();

                            cubit.setSendCodeLoading(true);
                            // Simulate password reset delay
                            await Future.delayed(const Duration(seconds: 2));
                            cubit.setSendCodeLoading(false);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<VerificationCubit>(),
                                  child: VerifyCodeScreen(userEmail: email),
                                ),
                              ),
                            );
                          }
                        : null,
                    child: state.isSendCodeLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Color(0xFF286243),
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "Continue",
                            style: TextStyle(
                              color: state.isEmailValid
                                  ? const Color(0xFF286243)
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            /// Cancel button
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
                onPressed: () => Navigator.of(context).pop(),
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
      ),
    );
  }
}
