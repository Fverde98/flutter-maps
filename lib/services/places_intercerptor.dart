import 'package:dio/dio.dart';
import 'package:maps_app/services/traffic_interceptor.dart';

class PlacesInteceptor extends Interceptor{
  final  accessToken = 'pk.eyJ1IjoiZnZlcmRlOTgiLCJhIjoiY2xmd3E0Z3dnMGp0NzNlbzMxemxyeGwxNSJ9.dVHKa1ape5W1Km-7tNI4CA';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
   options.queryParameters.addAll({
    'access_token': accessToken,
    'language': 'es',
    
   });
   super.onRequest(options, handler);
  }
}