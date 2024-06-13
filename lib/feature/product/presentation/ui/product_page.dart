import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/feature/product/presentation/controller/product_controller.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.read(productProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
    );
  }
}

enum ProductStatus {
  idle,
  loading,
  loginSuccess,
  loginFailed,
}
