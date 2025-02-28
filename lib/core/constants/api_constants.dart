class ApiConstants {
  static String baseUrl = 'http://109.176.197.232:3100/';
  static String loginApi = 'api/auth/login';
  static String forgetPasswordApi = 'api/auth/forget-password';
  static String resetPasswordApi = 'api/auth/reset-password';
  static String verifyAccount = 'api/auth/verify-account';
  static String checkOTP = 'api/auth/check-otp';
  static String googleLoginApi = 'api/auth/google-login';
  static String programsApi = 'api/programs';
  static String programByIdApi = 'api/programs/';

  static String signUpApi = 'api/auth/signup';
  static String getMyDataApi = 'api/users/me';
  static String updateMyDataApi = 'api/users/me';
  static String fetchAllUsersApi = 'api/users';

  static String imagesURLApi = 'http://109.176.197.232:3100/static-uploads/';

  static String bannersApi = 'api/banners';

  static String requestsApi = 'api/requests/';

  static String categoriesApi = 'api/categories';
  static String categoryByIdApi = 'api/categories/';
//Classes APIs
  static String classesApi = 'api/classes';
  static String classesbyIdApi = 'api/classes';
  static String myclassesApi = 'api/classes/me';
  // Levels
  static String getAllLevels = '/api/levels';


  static String transactionsApi = 'api/transaction';
  static String transactionsAskForMoney = 'api/transaction/me/ask-for-money';

  // Notifications
  static const String notificationsApi = 'api/notifications/my-notifications';
  static const String notificationUdateStatusApi = 'api/notifications/status/';
  static const String notificationsByIdApi = 'api/notifications/';
}
