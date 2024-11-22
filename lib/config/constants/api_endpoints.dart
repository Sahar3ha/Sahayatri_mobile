class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // For Windows
  // static const String baseUrl = "http://10.0.2.2:5000/api/";
  // For MAC
  // static const String baseUrl = "http://localhost:3000/api/v1/";
  static const String baseUrl = "http://192.168.1.94:5000/api/";

  // ====================== User Routes ======================
  static const String login = "users/login";
  static const String register = "users/register";
  static const String getAllVehicles = "admin/get_vehicles";
  static const String addFavourites = "users/create_favourite";

  static const String addFeedback = "users/create_feedback/";
  static const String notification = "admin/get_notification";
  static const String deleteNotification = "admin/delete_notification";
  static const String getFavourites = "users/get_favourite/";
  static const String deleteFavourite = "users/delete_favourite/";

  static const limitPage = 20;
}
