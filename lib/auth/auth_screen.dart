import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onborading_screen/component/_widgets.dart';
import 'forms/cubit/auth_Cubit.dart';
import 'forms/cubit/auth_state.dart';
import 'forms/login_form.dart';
import 'forms/signup_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Logo
            appBranding(),
            const SizedBox(height: 30),

            const Text(
              'Welcome to Tasktugas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 38),
              child: Text(
                'Sign up or login below to manage your project, task and productivity',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 25),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTab(
                      context,
                      text: 'Login',
                      isSelected: state.currentTab == AuthTab.login,
                      onTap: () =>
                          context.read<AuthCubit>().switchTab(AuthTab.login),
                    ),
                    _buildTab(
                      context,
                      text: 'Sign Up',
                      isSelected: state.currentTab == AuthTab.signup,
                      onTap: () =>
                          context.read<AuthCubit>().switchTab(AuthTab.signup),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return state.currentTab == AuthTab.login
                      ?  LoginForm()
                      :  SignUpForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context,
      {required String text, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected ? const Color(0xFF286243) : Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 2,
            width: 180,
            color: isSelected ? const Color(0xFF286243) : Colors.transparent,
          ),
        ],
      ),
    );
  }
}