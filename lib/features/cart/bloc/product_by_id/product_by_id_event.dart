abstract class ProductByIdEvent {}

class FetchProductById extends ProductByIdEvent{
  final int productId;

  FetchProductById({required this.productId});
}