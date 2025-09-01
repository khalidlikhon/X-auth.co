import 'package:equatable/equatable.dart';

class VerificationState extends Equatable {
  // Email
  final String email;

  // OTP
  final List<String> otp; // length = 4
  final bool isVerifying;
  final bool isCodeVerified;
  final String? error;

  // Password Reset
  final String password;
  final String confirmPassword;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  // Detailed validations
  final bool hasMinLength;
  final bool hasNumber;
  final bool hasUpperLower;
  final bool hasSpecialChar;
  final bool doPasswordsMatch;
  final String signupPassword;
  final String signupConfirmPassword;

  //loading
  final bool isSendCodeLoading;
  final bool isVerificationLoading;
  final bool isResetPassLoading;



  const VerificationState({
    this.email = '',
    this.otp = const ['', '', '', ''],
    this.isVerifying = false,
    this.isCodeVerified = false,
    this.error,
    this.password = '',
    this.confirmPassword = '',
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.hasMinLength = false,
    this.hasNumber = false,
    this.hasUpperLower = false,
    this.hasSpecialChar = false,
    this.doPasswordsMatch = false,
    this.signupPassword = '',
    this.signupConfirmPassword = '',
    this.isSendCodeLoading = false,
    this.isVerificationLoading = false,
    this.isResetPassLoading = false
  });

  // Email validation
  bool get isEmailValid =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

  // Password validation for ResetPasswordScreen
  bool get isPasswordValid =>
      password.length >= 4 && RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(password);

  bool get passwordsMatch =>
      password.isNotEmpty && confirmPassword.isNotEmpty && password == confirmPassword;

  // CopyWith
  VerificationState copyWith({
    String? email,
    List<String>? otp,
    bool? isVerifying,
    bool? isCodeVerified,
    String? error,
    String? password,
    String? confirmPassword,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? hasMinLength,
    bool? hasNumber,
    bool? hasUpperLower,
    bool? hasSpecialChar,
    bool? doPasswordsMatch,
    String? signupPassword,
    String? signupConfirmPassword,
    bool? isSendCodeLoading,
    bool? isVerificationLoading,
    bool? isResetPassLoading,
  }) {
    return VerificationState(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      isVerifying: isVerifying ?? this.isVerifying,
      isCodeVerified: isCodeVerified ?? this.isCodeVerified,
      error: error ?? this.error,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasNumber: hasNumber ?? this.hasNumber,
      hasUpperLower: hasUpperLower ?? this.hasUpperLower,
      hasSpecialChar: hasSpecialChar ?? this.hasSpecialChar,
      doPasswordsMatch: doPasswordsMatch ?? this.doPasswordsMatch,
      signupPassword: signupPassword ?? this.signupPassword,
      signupConfirmPassword: signupConfirmPassword ?? this.signupConfirmPassword,
      isSendCodeLoading: isSendCodeLoading ?? this.isSendCodeLoading,
      isVerificationLoading: isVerificationLoading ?? this.isVerificationLoading,
      isResetPassLoading: isResetPassLoading ?? this.isResetPassLoading

    );
  }

  @override
  List<Object?> get props => [
    email,
    otp,
    isVerifying,
    isCodeVerified,
    error,
    password,
    confirmPassword,
    isPasswordVisible,
    isConfirmPasswordVisible,
    hasMinLength,
    hasNumber,
    hasUpperLower,
    hasSpecialChar,
    doPasswordsMatch,
    signupPassword,
    signupConfirmPassword,
    isSendCodeLoading,
    isVerificationLoading,
    isResetPassLoading
  ];
}
