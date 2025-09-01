import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onborading_screen/auth/reset/resetpassword_screen.dart';
import 'package:onborading_screen/component/_widgets.dart';
import 'cubit/verification_cubit.dart';
import 'cubit/verification_state.dart';

class VerifyCodeScreen extends StatelessWidget {
  final String userEmail;

  const VerifyCodeScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    // Set email in cubit
    context.read<VerificationCubit>().updateEmail(userEmail);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              appBranding(),
              const SizedBox(height: 30),
              const Text(
                'Enter Verification Code',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              // Display email
              BlocBuilder<VerificationCubit, VerificationState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'We have sent a code to ',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      Text(
                        state.email,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 45),

              // OTP Fields
              BlocBuilder<VerificationCubit, VerificationState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: 55,
                        height: 60,
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          enabled: !state.isCodeVerified,
                          onChanged: (value) {
                            context.read<VerificationCubit>().updateOtpAt(
                              index,
                              value,
                            );

                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(context).nextFocus();
                            }
                            if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: !state.isCodeVerified
                                    ? const Color(0xFFC2E96A)
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: !state.isCodeVerified
                                    ? const Color(0xFFC2E96A)
                                    : Colors.grey,
                                width: 1.5,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          cursorColor: const Color(0xFF286243),
                        ),
                      );
                    }),
                  );
                },
              ),

              const Spacer(),

              // Verify Button + Listener
              BlocConsumer<VerificationCubit, VerificationState>(
                listener: (context, state) {
                  if (state.isCodeVerified) {
                    // Navigate to ResetPasswordScreen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<VerificationCubit>(),
                          child: const ResetPasswordScreen(),
                        ),
                      ),
                    );
                  } else if (state.error != null) {
                    // Show error SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error!),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isOtpComplete = state.otp.every(
                    (digit) => digit.isNotEmpty,
                  );

                  return Column(
                    children: [
                      // Verify Now button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                  (states) => isOtpComplete
                                      ? const Color(0xFFC2E96A)
                                      : Colors.grey.shade300,
                                ),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                  (states) => isOtpComplete
                                      ? const Color(0xFF286243)
                                      : Colors.grey,
                                ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          onPressed:
                              isOtpComplete && !state.isVerificationLoading
                              ? () async {
                                  final cubit = context
                                      .read<VerificationCubit>();
                                  cubit.setVerificationLoading(true);
                                  await Future.delayed(
                                    const Duration(seconds: 2),
                                  );
                                  cubit.verifyCode();
                                  cubit.setVerificationLoading(false);

                                }
                              : null,
                          child: state.isVerificationLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF286243),
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Verify Now",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Resend code row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Didn't receive any code? ",
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                          InkWell(
                            onTap: () {
                              final email = context
                                  .read<VerificationCubit>()
                                  .state
                                  .email;

                              Future.delayed(const Duration(seconds: 1), () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Another code has been sent to $email",
                                      style: const TextStyle(
                                        color: Color(0xFF286243),
                                      ),
                                    ),
                                    backgroundColor: const Color(0xFFC2E96A),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              });

                              // Trigger resend logic
                              context.read<VerificationCubit>().resendCode();
                            },
                            child: const Text(
                                    'Resend Code',
                                    style: TextStyle(
                                      color: Color(0xFF286243),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
