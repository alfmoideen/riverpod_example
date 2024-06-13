import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/feature/product/application/product_service.dart';
import 'package:parking_app/feature/product/application/product_service_impl.dart';
import 'package:parking_app/feature/product/presentation/state/product_state.dart';

final productProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final productService = ref.watch(productServiceProvider);
  return ProductNotifier(productService, const ProductState());
});

class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier(this.productService, super.state);

  final ProductService productService;

  Future<void> getProducts() async {
    try {
      final productList = await productService.getProducts();
      log(productList.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
