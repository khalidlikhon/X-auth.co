import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void switchTab(AuthTab tab) => emit(state.copyWith(currentTab: tab));

  // Login methods
  void toggleLoginPasswordVisibility() =>
      emit(state.copyWith(isLoginPasswordVisible: !state.isLoginPasswordVisible));

  void updateLoginEmail(String email) {
    final isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    emit(state.copyWith(loginEmail: email, isLoginEmailValid: isValid));
  }

  void updateLoginPassword(String password) {
    emit(state.copyWith(loginPassword: password));
  }

  void setLoginLoading(bool isLoginLoading) {
    emit(state.copyWith(isLoginLoading : !isLoginLoading));
  }

  // Signup methods
  void toggleSignupPasswordVisibility() =>
      emit(state.copyWith(isSignupPasswordVisible: !state.isSignupPasswordVisible));

  void toggleSignupConfirmPasswordVisibility() => emit(
      state.copyWith(isSignupConfirmPasswordVisible: !state.isSignupConfirmPasswordVisible));

  void updateSignupName(String name) => emit(state.copyWith(signupName: name));

  void updateSignupEmail(String email) {
    final isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    emit(state.copyWith(signupEmail: email, isSignupEmailValid: isValid));
  }

  void updateSignupPassword(String password) {
    emit(state.copyWith(
      signupPassword: password,
      hasMinLength: password.length >= 8,
      hasNumber: RegExp(r'[0-9]').hasMatch(password),
      hasUpperLower: password.contains(RegExp(r'[A-Z]')) &&
          password.contains(RegExp(r'[a-z]')),
      hasSpecialChar: RegExp(r'[@#\$*&]').hasMatch(password),
      doPasswordsMatch: password == state.signupConfirmPassword,
    ));
  }

  void updateSignupConfirmPassword(String confirmPassword) {
    emit(state.copyWith(
      signupConfirmPassword: confirmPassword,
      doPasswordsMatch: confirmPassword == state.signupPassword,
    ));
  }

  void toggleAgreeTerms() => emit(state.copyWith(agreeTerms: !state.agreeTerms));

  void setSingupLoading(bool isSingupLoading) {
    emit(state.copyWith(isSingupLoading : !isSingupLoading));
  }

  // Reset all fields when switching tabs
  void resetForm() {
    emit(const AuthState());
  }


}