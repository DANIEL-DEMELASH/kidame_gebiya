import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import 'package:kidame_gebiya/features/product/bloc/all_products/products_bloc.dart';
import 'package:kidame_gebiya/features/product/bloc/all_products/products_event.dart';
import 'package:kidame_gebiya/features/product/bloc/all_products/products_state.dart';
import 'package:kidame_gebiya/features/product/presentation/widgets/product_card.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:const Text('Explore Products', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          centerTitle: true,
        ),
        
        body: RefreshIndicator(
          onRefresh: () async{
            context.read<ProductBloc>().add(FetchAllProducts());
          },
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state){
              if(state is ProductError){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.error, textAlign: TextAlign.center,),
                    
                    const SizedBox(height: 20),
                    
                    IconButton(
                      onPressed: (){
                        context.read<ProductBloc>().add(FetchAllProducts());
                      }, 
                      icon: const Icon(Icons.refresh, size: 30,))
                  ],
                );
              }
              
              if(state is ProductLoading){
                return const Center(child: CupertinoActivityIndicator());
              }
              
              if(state is ProductLoaded){
                return SingleChildScrollView(
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 16,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => context.push('/homepage/product_detail', 
                          extra: state.products[index]),
                        child: ProductCard(currentProduct: state.products[index]));
                    },
                  ),
                );
              
              }
              
              return const SizedBox.shrink();
            }
          ),
        ),
      ),
    );
  }
}