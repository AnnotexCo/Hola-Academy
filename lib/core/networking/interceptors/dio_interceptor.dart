import 'package:dio/dio.dart';
import '../../local_db/save_token.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SaveTokenDB.getToken();
    // final role = await SaveTokenDB.getRole(); // Fetch user role (optional)

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Content-Type'] = 'application/json';

    // Optional: Log role for debugging
    // print("User Role: $role"); 

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log success responses for debugging (optional)
    // print("Response: ${response.statusCode}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Unauthorized - Auto Logout (Optional)
      await SaveTokenDB.deleteTokenAndRole();
      // print(" Unauthorized! Token removed.");
    }

    super.onError(err, handler);
  }
}
