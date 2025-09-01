import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(const VerificationState());

  static const String _expectedCode = '1234';

  // Email
  void updateEmail(String email) {
    if (email == state.email) return;
    emit(state.copyWith(email: email, error: null));
  }

  // OTP
  void updateOtpAt(int index, String value) {
    final digits = List<String>.from(state.otp);
    if (index < 0 || index >= digits.length) return;
    digits[index] = value.trim();
    emit(state.copyWith(otp: digits, error: null));
  }

  void verifyCode() {
    if (state.isVerifying) return;
    emit(state.copyWith(isVerifying: true, error: null));
    final code = state.otp.join();
    if (code == _expectedCode) {
      emit(
        state.copyWith(isVerifying: false, isCodeVerified: true, error: null),
      );
    } else {
      emit(
        state.copyWith(
          isVerifying: false,
          isCodeVerified: false,
          error: 'Invalid OTP',
        ),
      );
    }
  }

  Future<void> resendCode() async {
    emit(state.copyWith(error: null));
  }

  // Reset password
  void updatePassword(String password) {
    emit(state.copyWith(password: password, error: null));
  }

  void updateConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword, error: null));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }

  void resetPassword(String newPassword) {
    emit(
      state.copyWith(
        password: newPassword,
        confirmPassword: '',
        isPasswordVisible: false,
        isConfirmPasswordVisible: false,
        error: null,
      ),
    );
  }

  // Signup detailed password validation
  void updateSignupPassword(String password) {
    emit(
      state.copyWith(
        signupPassword: password,
        hasMinLength: password.length >= 8,
        hasNumber: RegExp(r'[0-9]').hasMatch(password),
        hasUpperLower:
            password.contains(RegExp(r'[A-Z]')) &&
            password.contains(RegExp(r'[a-z]')),
        hasSpecialChar: RegExp(r'[@#\$*&]').hasMatch(password),
        doPasswordsMatch: password == state.signupConfirmPassword,
      ),
    );
  }

  void updateSignupConfirmPassword(String confirmPassword) {
    emit(
      state.copyWith(
        signupConfirmPassword: confirmPassword,
        doPasswordsMatch: confirmPassword == state.signupPassword,
      ),
    );
  }

  void setSendCodeLoading(bool loading) {
    emit(state.copyWith(isSendCodeLoading: loading));
  }

  void setVerificationLoading(bool loading) {
    emit(state.copyWith(isVerificationLoading: loading));
  }

  void setResetPassLoading(bool loading) {
    emit(state.copyWith(isResetPassLoading: loading));
  }
}
