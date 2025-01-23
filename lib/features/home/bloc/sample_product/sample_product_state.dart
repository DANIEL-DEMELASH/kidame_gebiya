import 'package:kidame_gebiya/features/product/data/models/product_model.dart';

abstract class SampleProductState {}

class SampleProductInitial extends SampleProductState {}

class SampleProductLoading extends SampleProductState {}

class SampleProductLoaded extends SampleProductState {
  final List<ProductModel> products;

  SampleProductLoaded(this.products);
}

class SampleProductError extends SampleProductState {
  final String error;

  SampleProductError(this.error);
}
