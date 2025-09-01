import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/verification_cubit.dart';
import 'forgetpassword_screen.dart';

class VerificationPanel extends StatelessWidget {
  const VerificationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationCubit(),
      child: ForgetPasswordScreen(),
    );
  }
}