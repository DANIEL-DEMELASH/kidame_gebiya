class DioConfig {
  static const String baseUrl = 'https://fakestoreapi.com/';
  static const int connectTimeout = 5; // 5 seconds
  static const int receiveTimeout = 3; // 3 seconds
  static const int sendTimeout = 5; // 5 seconds
  
  static const String login = 'auth/login';
  static const String allProducts = 'products';
  static const String categories = 'products/categories';
  static const String productByCategory = 'products/category';
}