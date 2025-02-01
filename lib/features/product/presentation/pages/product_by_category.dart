import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:kidame_gebiya/features/product/bloc/product_by_category/product_by_category_bloc.dart';
import 'package:kidame_gebiya/features/product/bloc/product_by_category/product_by_category_event.dart';
import 'package:kidame_gebiya/features/product/bloc/product_by_category/product_by_category_state.dart';
import 'package:kidame_gebiya/features/product/presentation/widgets/product_card.dart';

class ProductByCategory extends StatelessWidget {
  const ProductByCategory({super.key, required this.productCategory});
  final String productCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductByCategoryBloc()..add(FetchProductByCategory(productCategory: productCategory)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => context.pop(), 
            icon: const Icon(CupertinoIcons.chevron_back)),
          title: Text(productCategory, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          centerTitle: true,
        ),
        body: BlocBuilder<ProductByCategoryBloc, ProductByCategoryState>(
          builder: (context, state) {
            if(state is ProductByCategoryError){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error, textAlign: TextAlign.center,),
                  
                  const SizedBox(height: 20),
                  
                  IconButton(
                    onPressed: (){
                      context.read<ProductByCategoryBloc>().add(FetchProductByCategory(productCategory: productCategory));
                    }, 
                    icon: const Icon(Icons.refresh, size: 30,))
                ],
              );
            }
            
            if(state is ProductByCategoryLoading){
              return const Center(child: CupertinoActivityIndicator());
            }
            
            if(state is ProductByCategoryLoaded){
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
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
                          onTap: () => context.push('/homepage/product_detail', extra: state.products[index]),
                          child: ProductCard(currentProduct: state.products[index]));
                      },
                    ),
                  ),
                  
                ),
              );
            }
            
            return const SizedBox.shrink();       
          },
        )
      ),
    );
  }
}