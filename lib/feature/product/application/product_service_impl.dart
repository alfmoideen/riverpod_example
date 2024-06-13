import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:parking_app/core/exception/failure.dart';
import 'package:parking_app/feature/product/application/product_service.dart';
import 'package:parking_app/feature/product/data/dto/response/product_response.dart';
import 'package:parking_app/feature/product/data/repository/product_repo_impl.dart';
import 'package:parking_app/feature/product/data/repository/product_repository.dart';

final productServiceProvider = Provider<ProductServiceImpl>((ref) {
  final productApiService = ref.watch(productRepositoryProvider);
  return ProductServiceImpl(productApiService);
});

class ProductServiceImpl implements ProductService {
  final ProductRepository _productRepository;
  ProductServiceImpl(this._productRepository);

  @override
  Future<Result<List<Product>, Failure>> getProducts() async {
    try {
      Result<List<Product>, Failure> result =
          await _productRepository.getProducts();
      if (result is Success<List<Product>, Failure>) {
        return Success(result.success);
      } else {
        return Error(Failure(message: result.toString()));
      }
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(Failure(exception: Exception(e), message: e.toString()));
    }
  }
}
