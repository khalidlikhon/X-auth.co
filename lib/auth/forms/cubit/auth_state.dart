enum AuthTab { login, signup }

class AuthState {
  final AuthTab currentTab;

  // Login state
  final String loginEmail;
  final String loginPassword;
  final bool isLoginPasswordVisible;
  final bool isLoginEmailValid;
  final bool isLoginLoading;

  // Signup state
  final String signupName;
  final String signupEmail;
  final String signupPassword;
  final String signupConfirmPassword;
  final bool isSignupPasswordVisible;
  final bool isSignupConfirmPasswordVisible;
  final bool isSignupEmailValid;
  final bool hasMinLength;
  final bool hasNumber;
  final bool hasUpperLower;
  final bool hasSpecialChar;
  final bool doPasswordsMatch;
  final bool agreeTerms;
  final bool isSingupLoading;

  const AuthState({
    this.currentTab = AuthTab.login,

    // Login defaults
    this.loginEmail = '',
    this.loginPassword = '',
    this.isLoginPasswordVisible = false,
    this.isLoginEmailValid = true,
    this.isLoginLoading = false,

    // Signup defaults
    this.signupName = '',
    this.signupEmail = '',
    this.signupPassword = '',
    this.signupConfirmPassword = '',
    this.isSignupPasswordVisible = false,
    this.isSignupConfirmPasswordVisible = false,
    this.isSignupEmailValid = true,
    this.hasMinLength = false,
    this.hasNumber = false,
    this.hasUpperLower = false,
    this.hasSpecialChar = false,
    this.doPasswordsMatch = false,
    this.agreeTerms = false,
    this.isSingupLoading = false,
  });

  AuthState copyWith({
    AuthTab? currentTab,

    // Login
    String? loginEmail,
    String? loginPassword,
    bool? isLoginPasswordVisible,
    bool? isLoginEmailValid,
    bool? isLoginLoading,

    // Signup
    String? signupName,
    String? signupEmail,
    String? signupPassword,
    String? signupConfirmPassword,
    bool? isSignupPasswordVisible,
    bool? isSignupConfirmPasswordVisible,
    bool? isSignupEmailValid,
    bool? hasMinLength,
    bool? hasNumber,
    bool? hasUpperLower,
    bool? hasSpecialChar,
    bool? doPasswordsMatch,
    bool? agreeTerms,
    bool? isSingupLoading
  }) {
    return AuthState(
      currentTab: currentTab ?? this.currentTab,

      // Login
      loginEmail: loginEmail ?? this.loginEmail,
      loginPassword: loginPassword ?? this.loginPassword,
      isLoginPasswordVisible:
          isLoginPasswordVisible ?? this.isLoginPasswordVisible,
      isLoginEmailValid: isLoginEmailValid ?? this.isLoginEmailValid,
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,

      // Signup
      signupName: signupName ?? this.signupName,
      signupEmail: signupEmail ?? this.signupEmail,
      signupPassword: signupPassword ?? this.signupPassword,
      signupConfirmPassword:
          signupConfirmPassword ?? this.signupConfirmPassword,
      isSignupPasswordVisible:
          isSignupPasswordVisible ?? this.isSignupPasswordVisible,
      isSignupConfirmPasswordVisible:
          isSignupConfirmPasswordVisible ?? this.isSignupConfirmPasswordVisible,
      isSignupEmailValid: isSignupEmailValid ?? this.isSignupEmailValid,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasNumber: hasNumber ?? this.hasNumber,
      hasUpperLower: hasUpperLower ?? this.hasUpperLower,
      hasSpecialChar: hasSpecialChar ?? this.hasSpecialChar,
      doPasswordsMatch: doPasswordsMatch ?? this.doPasswordsMatch,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      isSingupLoading: isSingupLoading ?? this.isSingupLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.currentTab == currentTab &&
        // Login
        other.loginEmail == loginEmail &&
        other.loginPassword == loginPassword &&
        other.isLoginPasswordVisible == isLoginPasswordVisible &&
        other.isLoginEmailValid == isLoginEmailValid &&
        other.isLoginLoading == isLoginLoading &&
        // Signup
        other.signupName == signupName &&
        other.signupEmail == signupEmail &&
        other.signupPassword == signupPassword &&
        other.signupConfirmPassword == signupConfirmPassword &&
        other.isSignupPasswordVisible == isSignupPasswordVisible &&
        other.isSignupConfirmPasswordVisible ==
            isSignupConfirmPasswordVisible &&
        other.isSignupEmailValid == isSignupEmailValid &&
        other.hasMinLength == hasMinLength &&
        other.hasNumber == hasNumber &&
        other.hasUpperLower == hasUpperLower &&
        other.hasSpecialChar == hasSpecialChar &&
        other.doPasswordsMatch == doPasswordsMatch &&
        other.agreeTerms == agreeTerms &&
        other.isSingupLoading == isSingupLoading;
  }

  @override
  int get hashCode {
    return Object.hash(
      currentTab,

      // Login
      loginEmail,
      loginPassword,
      isLoginPasswordVisible,
      isLoginEmailValid,
      isLoginLoading,

      // Signup
      signupName,
      signupEmail,
      signupPassword,
      signupConfirmPassword,
      isSignupPasswordVisible,
      isSignupConfirmPasswordVisible,
      isSignupEmailValid,
      hasMinLength,
      hasNumber,
      hasUpperLower,
      hasSpecialChar,
      doPasswordsMatch,
      agreeTerms,
      isSingupLoading
    );
  }
}
