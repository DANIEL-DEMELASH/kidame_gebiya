import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
import 'package:kidame_gebiya/app_constant.dart';
import 'package:kidame_gebiya/features/cart/bloc/product_by_id/product_by_id_bloc.dart';
import 'package:kidame_gebiya/features/cart/bloc/product_by_id/product_by_id_event.dart';
import 'package:kidame_gebiya/features/cart/bloc/product_by_id/product_by_id_state.dart';
import 'package:kidame_gebiya/features/cart/data/models/cart_model.dart';

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
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if(state is ProductByIdError){
                    return Center(child: Text(state.error));
                  }
                  
                  if(state is ProductByIdLoaded){
                    return ListTile(
                      contentPadding: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: false, 
                            onChanged: (value){
                          }),
                          
                          CachedNetworkImage(
                            imageUrl: state.product.image, fit: BoxFit.contain,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Placeholder(),
                          )
                        ],
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(state.product.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: darkGreyColor),),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("\$${state.product.price}", 
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                              
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: primaryColor)
                                    ),
                                    child: const Text('-', textAlign: TextAlign.center, style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),),
                                  ),
                                ),
                                
                                const SizedBox(width: 12),
                                
                                Text(product.quantity.toString()),
                                
                                const SizedBox(width: 12),
                                
                                GestureDetector(
                                  onTap: () {
                                    
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: primaryColor)
                                    ),
                                    child: const Text('+', textAlign: TextAlign.center, style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  
                  return const SizedBox.shrink();
                }
              ),
            ),
          );
      }),
      
      bottomSheet: Container(
        height: 60,
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
      )
    );
  }
}