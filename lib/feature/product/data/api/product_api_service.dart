// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/core/remote/network_service_provider.dart';
import 'package:parking_app/feature/product/data/dto/response/product_response.dart';
import 'package:retrofit/retrofit.dart';

part "product_api_service.g.dart";

final productApiServiceProvider = Provider<ProductApiService>((ref) {
  final dioService = ref.watch(networkServiceProvider);
  return ProductApiService(dioService);
});

@RestApi()
abstract class ProductApiService {
  factory ProductApiService(Dio dio) => _ProductApiService(dio);

  @GET('auth/products')
  Future<List<Product>> getProducts();
}
