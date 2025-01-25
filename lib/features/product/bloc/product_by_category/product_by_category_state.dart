import 'package:kidame_gebiya/features/product/data/models/product_model.dart';

abstract class ProductByCategoryState {}

class ProductByCategoryInitial extends ProductByCategoryState {}

class ProductByCategoryLoading extends ProductByCategoryState {}

class ProductByCategoryLoaded extends ProductByCategoryState {
  final List<ProductModel> products;

  ProductByCategoryLoaded(this.products);
}

class ProductByCategoryError extends ProductByCategoryState {
  final String error;

  ProductByCategoryError(this.error);
}
