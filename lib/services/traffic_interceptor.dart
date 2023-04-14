import 'package:dio/dio.dart';


class TrafficInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken ='pk.eyJ1IjoiZnZlcmRlOTgiLCJhIjoiY2xmd3E0Z3dnMGp0NzNlbzMxemxyeGwxNSJ9.dVHKa1ape5W1Km-7tNI4CA';
    // TODO: implement onRequest
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });
    super.onRequest(options, handler);
  }
}