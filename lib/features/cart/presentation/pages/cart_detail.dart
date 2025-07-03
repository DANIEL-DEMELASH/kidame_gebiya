import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:kidame_gebiya/app_constant.dart';
import 'package:kidame_gebiya/features/cart/bloc/product_by_id/product_by_id_bloc.dart';
import 'package:kidame_gebiya/features/cart/bloc/product_by_id/product_by_id_event.dart';
import 'package:kidame_gebiya/features/cart/bloc/product_by_id/product_by_id_state.dart';
import 'package:kidame_gebiya/features/cart/data/models/cart_model.dart';

import '../widgets/cart_product_card.dart';

class CartDetail extends StatelessWidget {
  const CartDetail({super.key, required this.cartModel});
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => context.pop(), 
          icon: const Icon(CupertinoIcons.chevron_back)),
        title: Text("Cart ${cartModel.id}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      
      body: ListView.builder(
        itemCount: cartModel.products.length,
        itemBuilder: (context, index){
          CartProduct product = cartModel.products[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: greyColor, width: .3),
            ),
            child: BlocProvider(
              create: (context) => ProductByIdBloc()..add(FetchProductById(productId: product.productId)),
              child: BlocBuilder<ProductByIdBloc, ProductByIdState>(
                builder: (context, state) { 
                  if(state is ProductByIdLoading){
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  
                  if(state is ProductByIdError){
                    return Center(child: Text(state.error));
                  }
                  
                  if(state is ProductByIdLoaded){
                    return CartProductCard(
                      product: state.product, 
                      cartProduct: product
                    );
                  }
                  
                  return const SizedBox.shrink();
                }
              ),
            ),
          );
      }),
      
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.zero
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value){
                      
                    }
                  ),
                  
                  const Text('Select All', style: TextStyle(color: darkGreyColor),),
                ],
              ),
              
              const Text('Total \$22.3', style: TextStyle(fontWeight: FontWeight.w500),),
              
              
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .35,
                child: TextButton(
                  onPressed: (){}, 
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12)
                  ),
                  child: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)),
              ),
            ],
          ),
        ),
      )
    );
  }
}
