import 'package:kidame_gebiya/features/product/data/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error);
}
