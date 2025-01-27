import 'package:kidame_gebiya/features/product/data/models/product_model.dart';

abstract class ProductByIdState {}

class ProductByIdInitial extends ProductByIdState{}
class ProductByIdLoading extends ProductByIdState{}
class ProductByIdLoaded extends ProductByIdState{
  final ProductModel product;

  ProductByIdLoaded({required this.product});
}
class ProductByIdError extends ProductByIdState{
  final String error;

  ProductByIdError({required this.error});
}