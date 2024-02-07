class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/";
  // static const String baseUrl = "http://172.26.2.84:3000/";
  // static const String baseUrl = "http://192.168.137.160:3000/";

  // ====================== User Routes ======================
  static const String signin = "users/signin";
  static const String signup = "users/signup";
  static const String getUsers = "users/getusers";
  static const String getUser = "users/getuser/";
  static const String editUser = "users/edituser/";
  static const String deleteStudent = "users/getUsers/";
  static const String imageUrl = "http://10.0.2.2:3000/users/profileimage";
  static const String uploadImage = "users/profileimage";
  static const profileImageUrl = 'http://10.0.2.2:3000/uploads/';

  // ====================== News Routes ======================
  static const String getNews = "news/";
  static const String deleteNews = "news/";
  static const String singleNews = "news/";
  static const newsImageUrl = 'http://10.0.2.2:3000/uploads/news/';

  // ====================== Vehicles Routes ======================
  static const String getVehicles = "vehicle/";
  static const String singleVehicle = "vehicle/";
  static const String vehicleReviews = "reviews/";
  static const String singleReview = "vehicle/:vehicle_id/reviews/:review_id";
  static const vehicleImageUrl = 'http://10.0.2.2:3000/uploads/vehicles/';
}
