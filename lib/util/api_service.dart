class ApiUrl {
  static const String liveBaseURL =
      'https://harvest-rigorous-bambiraptor.glitch.me/app/v1/patient';

  static const String BaseURL = liveBaseURL;

  static const String register = BaseURL + "/create";
  static const String login = BaseURL + "/login";
  static const String forgotPassword = BaseURL + "/patient-forgot-password";
  static const String resetPassword = BaseURL + "/patient-reset-password";
  static const String activateAccount = "/activate-patient-account";
}
