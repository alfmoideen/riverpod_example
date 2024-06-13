import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:parking_app/core/exception/dio_exception_mixin.dart';
import 'package:parking_app/core/exception/failure.dart';
import 'package:parking_app/feature/product/data/api/product_api_service.dart';
import 'package:parking_app/feature/product/data/dto/response/product_response.dart';
import 'package:parking_app/feature/product/data/repository/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  final productApiService = ref.watch(productApiServiceProvider);
  return ProductRepositoryImpl(productApiService);
});

class ProductRepositoryImpl
    with DioExceptionMixin
    implements ProductRepository {
  final ProductApiService _productApiService;

  ProductRepositoryImpl(this._productApiService);

  @override
  Future<Result<List<Product>, Failure>> getProducts() async {
    try {
      List<Product> productResponse = await _productApiService.getProducts();
      return Success(productResponse);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(Failure(exception: Exception(e), message: e.toString()));
    }
  }
}
