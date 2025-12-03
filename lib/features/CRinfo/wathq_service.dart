import 'package:dio/dio.dart';
import 'cr_info_model.dart';

class WathqService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.wathq.sa',
      headers: {
        'ApiKey': 'Gt2I30EQ6YaSAbe4vN9kcwlypG9cWp98',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Future<CrInfoModel> getCrInfo(String crNumber) async {
    try {
      final response = await dio.get('/commercial-registration/info/$crNumber');

      if (response.statusCode == 200 && response.data != null) {
        return CrInfoModelMapper.fromMap(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Invalid response from server',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server responded with error status code
        final statusCode = e.response?.statusCode;
        final errorMessage =
            e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'خطأ في الخادم (${statusCode ?? 'غير معروف'})';
        throw Exception(errorMessage);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('خطأ في الاتصال. يرجى التحقق من اتصال الإنترنت');
      } else {
        throw Exception('حدث خطأ غير متوقع: ${e.message}');
      }
    } catch (e) {
      throw Exception('خطأ في جلب البيانات: ${e.toString()}');
    }
  }
}
