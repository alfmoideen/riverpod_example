import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parking_app/feature/product/data/dto/response/product_response.dart';
import 'package:parking_app/feature/product/presentation/ui/product_page.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default(ProductStatus.idle) final ProductStatus productStatus,
    @Default('') final String errorMessage,
    @Default([]) final List<Product> products,
  }) = _ProductState;
}
