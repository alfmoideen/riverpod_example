import 'package:multiple_result/multiple_result.dart';
import 'package:parking_app/core/exception/failure.dart';
import 'package:parking_app/feature/product/data/dto/response/product_response.dart';

abstract interface class ProductService {
  Future<Result<List<Product>, Failure>> getProducts();
}
