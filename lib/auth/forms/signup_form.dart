import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../component/_widgets.dart';
import '../auth_screen.dart';
import 'cubit/auth_Cubit.dart';
import 'cubit/auth_state.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // Controllers
        final TextEditingController _nameController = TextEditingController(
          text: state.signupName,
        );
        final TextEditingController _emailController = TextEditingController(
          text: state.signupEmail,
        );
        final TextEditingController _passwordController = TextEditingController(
          text: state.signupPassword,
        );
        final TextEditingController _confirmController = TextEditingController(
          text: state.signupConfirmPassword,
        );

        // Update controllers selection
        _nameController.selection = TextSelection.fromPosition(
          TextPosition(offset: _nameController.text.length),
        );
        _emailController.selection = TextSelection.fromPosition(
          TextPosition(offset: _emailController.text.length),
        );
        _passwordController.selection = TextSelection.fromPosition(
          TextPosition(offset: _passwordController.text.length),
        );
        _confirmController.selection = TextSelection.fromPosition(
          TextPosition(offset: _confirmController.text.length),
        );

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // Name field
              CustomTextField(
                prefixIcon: const Icon(Icons.person_outlined),
                hintText: 'Your name',
                controller: _nameController,
                onChanged: context.read<AuthCubit>().updateSignupName,
              ),
              const SizedBox(height: 15),
              // Email field
              CustomTextField(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: 'Enter your email',
                controller: _emailController,
                onChanged: context.read<AuthCubit>().updateSignupEmail,
              ),
              if (!state.isSignupEmailValid && state.signupEmail.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    "Please enter a valid email",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 15),
              // Password field
              CustomTextField(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: 'Enter your password',
                controller: _passwordController,
                obscureText: !state.isSignupPasswordVisible,
                onChanged: context.read<AuthCubit>().updateSignupPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    state.isSignupPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: state.isSignupPasswordVisible ? null : Colors.grey,
                  ),
                  onPressed: context
                      .read<AuthCubit>()
                      .toggleSignupPasswordVisibility,
                ),
              ),
              const SizedBox(height: 15),
              // Confirm password field
              CustomTextField(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: 'Confirm your password',
                controller: _confirmController,
                obscureText: !state.isSignupConfirmPasswordVisible,
                onChanged: context
                    .read<AuthCubit>()
                    .updateSignupConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    state.isSignupConfirmPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: state.isSignupConfirmPasswordVisible
                        ? null
                        : Colors.grey,
                  ),
                  onPressed: context
                      .read<AuthCubit>()
                      .toggleSignupConfirmPasswordVisibility,
                ),
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
              const SizedBox(height: 10),
              // Password criteria
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCriteria(
                            "At least 8 characters",
                            state.hasMinLength,
                          ),
                          _buildCriteria("At least 1 number", state.hasNumber),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCriteria(
                            "Both upper and lower case",
                            state.hasUpperLower,
                          ),
                          _buildCriteria(
                            "1 special character",
                            state.hasSpecialChar,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Terms checkbox
              Row(
                children: [
                  Checkbox(
                    value: state.agreeTerms,
                    onChanged: (_) =>
                        context.read<AuthCubit>().toggleAgreeTerms(),
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      return states.contains(MaterialState.selected)
                          ? Colors.grey
                          : Colors.transparent;
                    }),
                    side: MaterialStateBorderSide.resolveWith(
                      (states) =>
                          const BorderSide(width: 2.0, color: Colors.grey),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "By agreeing to the terms and conditions, you are entering into a contract.",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Sign Up button
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      return states.contains(MaterialState.disabled)
                          ? Colors.white
                          : const Color(0xFFC2E96A);
                    }),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      return states.contains(MaterialState.disabled)
                          ? Colors.grey
                          : const Color(0xFF286243);
                    }),
                    shape:
                        MaterialStateProperty.resolveWith<
                          RoundedRectangleBorder
                        >((states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: states.contains(MaterialState.disabled)
                                  ? Colors.grey
                                  : const Color(0xFFC2E96A),
                              width: 1,
                            ),
                          );
                        }),
                  ),
                  onPressed:
                      (state.isSignupEmailValid &&
                          state.hasMinLength &&
                          state.hasNumber &&
                          state.hasUpperLower &&
                          state.hasSpecialChar &&
                          state.doPasswordsMatch &&
                          state.agreeTerms)
                      ? () async {
                          final cubit = context.read<AuthCubit>();

                          // Start loading
                          cubit.setSingupLoading(false);

                          // Simulate signup delay
                          await Future.delayed(const Duration(seconds: 2));

                          // Show SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Registration successfully!",
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
                          // Stop loading & Reset form
                          cubit.resetForm();
                          cubit.setSingupLoading(true);
                          // Navigate to AuthScreen after short delay
                          Future.delayed(Duration(milliseconds: 200)); {
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
                        }
                      : null,
                  child: state.isSingupLoading
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
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  // Password criteria widget
  Widget _buildCriteria(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isValid ? const Color(0xFF286243) : Colors.grey,
                width: 3,
              ),
              color: Colors.transparent,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
