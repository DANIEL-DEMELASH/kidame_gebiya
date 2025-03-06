class DioConfig {
  static const String baseUrl = 'https://fakestoreapi.com/';
  static const int connectTimeout = 7; // 7 seconds
  static const int receiveTimeout = 5; // 5 seconds
  static const int sendTimeout = 5; // 5 seconds
  
  static const String login = 'auth/login';
  static const String allProducts = 'products';
  static const String categories = 'products/categories';
  static const String productByCategory = 'products/category';
  static const String users = 'users';
  static const String userCarts = 'carts/user';
}