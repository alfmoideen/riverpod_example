import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/feature/product/application/product_service.dart';
import 'package:parking_app/feature/product/application/product_service_impl.dart';
import 'package:parking_app/feature/product/presentation/state/product_state.dart';
import 'package:parking_app/feature/product/presentation/ui/product_page.dart';

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
      state = state.copyWith(
        errorMessage: '',
        productStatus: ProductStatus.loading,
        products: [],
      );
      final productList = await productService.getProducts();
      productList.when(
        (success) {
          state = state.copyWith(
            errorMessage: '',
            productStatus: ProductStatus.success,
            products: success,
          );
        },
        (error) {
          state = state.copyWith(
            errorMessage: error.exception.toString(),
            productStatus: ProductStatus.failed,
            products: [],
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
        productStatus: ProductStatus.failed,
        products: [],
      );
    }
  }
}
