import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/feature/product/presentation/controller/product_controller.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(productProvider.notifier).getProducts();
    });
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final productLoadingStatus = ref.watch(
      productProvider.select(
        (value) => value.productStatus,
      ),
    );
    final products = ref.watch(productProvider.select(
      (value) => value.products,
    ));

    final errorMessage = ref.watch(
      productProvider.select((value) => value.errorMessage),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: productLoadingStatus == ProductStatus.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : productLoadingStatus == ProductStatus.success
              ? ListView(
                  shrinkWrap: true,
                  children: [
                    ...products.map(
                      (item) => Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                item.image,
                                height: 100,
                                width: 100,
                              ),
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : productLoadingStatus == ProductStatus.failed
                  ? Center(
                      child: Text(
                        errorMessage,
                      ),
                    )
                  : const SizedBox(),
    );
  }
}

enum ProductStatus {
  idle,
  loading,
  success,
  failed,
}
