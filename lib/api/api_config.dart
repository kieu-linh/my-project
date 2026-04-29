class ApiConfig {
  static const baseUrl = "https://uneven-thwarting-tabby.ngrok-free.dev/";
  static const login = "api/auth/login";
  static const signup = "api/auth/register";
  static const borrows = "api/borrows";
  static const myBorrows = "api/borrows/me";
  static String returnBook(int id) => "api/borrows/$id/return";
}
