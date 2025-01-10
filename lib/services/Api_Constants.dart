class ApiConstants {
  static const String baseUrl = 'https://test.catalystegy.com/public/api';
  static const String usersEndpoint = '/users';
  // Method to generate a user-specific endpoint
  static String getUserByIdEndpoint(int id) {
    return '$baseUrl/users/$id'; // Returns full URL with dynamic ID as it's not constant 
  }
  

}
