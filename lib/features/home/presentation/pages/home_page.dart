import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:kidame_gebiya/features/category/bloc/category_bloc.dart';
import 'package:kidame_gebiya/features/category/bloc/category_event.dart';
import 'package:kidame_gebiya/features/category/bloc/category_state.dart';
import 'package:kidame_gebiya/features/home/bloc/sample_product/sample_product_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kidame_gebiya/features/home/bloc/sample_product/sample_product_bloc.dart';
import 'package:kidame_gebiya/features/home/bloc/sample_product/sample_product_state.dart';
import 'package:kidame_gebiya/app_constant.dart';
import 'package:kidame_gebiya/features/product/presentation/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Image.asset('assets/icon/icon.png'),
          ),
          title: RichText(
            text: const TextSpan(
              text: 'ቅዳሜ ',
              style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: primaryColor),
              children: [
                TextSpan(text: 'ገቢያ', style: TextStyle(color: Colors.black))
              ]
            )
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () async{
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.remove('isLoggedIn');
                if(context.mounted) {
                  context.go('/login');
                }
              }, child: const Text('Logout'))
          ],
        ),
        
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<SampleProductBloc>().add(FetchProducts());
            context.read<CategoryBloc>().add(FetchCategories());
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state){
                    if(state is CategoryError){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.error, textAlign: TextAlign.center,),
                          
                          const SizedBox(height: 20),
                          
                          IconButton(
                            onPressed: (){
                              context.read<CategoryBloc>().add(FetchCategories());
                            }, 
                            icon: const Icon(Icons.refresh, size: 30,))
                        ],
                      );
                    }
                    
                    if(state is CategoryLoading){
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    if(state is CategoryLoaded){
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                            color: primaryColor.withOpacity(.2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Wrap(
                                  direction: Axis.vertical,
                                  spacing: 12,
                                  children: [
                                    const Text('NEW COLLECTIONS', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                                    
                                    const Text('20% OFF', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                                    
                                    TextButton(
                                      onPressed: (){}, 
                                      style: TextButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        
                                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0)
                                        )
                                      ),
                                      child: const Text('SHOP NOW', style: TextStyle(color: Colors.white),))
                                  ],
                                ),
                                
                                Image.asset('assets/images/calvin_girl.png', width: 130,)
                              ],
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Shop By Category', style: TextStyle(fontWeight: FontWeight.w500),),
                                
                                TextButton(
                                  onPressed: (){
                                    
                                  }, 
                                  child: const Text('See All', style: TextStyle(color: darkGreyColor),))
                              ],
                            ),
                          ),
                          
                          Container(
                            height: 35,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.categories.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 12,
                                );
                              },
                              itemBuilder: (context, index){
                                return TextButton(
                                  onPressed: (){
                                    
                                  }, 
                                  style: TextButton.styleFrom(
                                    backgroundColor: primaryColor.withOpacity(.3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 16)
                                  ),
                                  child: Text(state.categories[index], 
                                    style: const TextStyle(color: Colors.black,  fontWeight: FontWeight.w500)
                                  )
                                );
                              }
                            ),
                          ),
                        ],
                      );
                    }
                    
                    return const SizedBox();
                  } 
                ),
                      
                BlocBuilder<SampleProductBloc, SampleProductState>(
                  builder: (context, state) {
                    if(state is SampleProductError){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.error, textAlign: TextAlign.center,),
                          
                          const SizedBox(height: 20),
                          
                          IconButton(
                            onPressed: (){
                              context.read<SampleProductBloc>().add(FetchProducts());
                            }, 
                            icon: const Icon(Icons.refresh, size: 30,))
                        ],
                      );
                    }
                    
                    if(state is SampleProductLoading){
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    if(state is SampleProductLoaded) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Curated For You', style: TextStyle(fontWeight: FontWeight.w500),),
                                
                                TextButton(
                                  onPressed: (){
                                    
                                  }, 
                                  child: const Text('See All', style: TextStyle(color: darkGreyColor),))
                              ],
                            ),
                          ),
                        
                          MasonryGridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 16,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => context.push('/homepage/product_detail'),
                                child: ProductCard(currentProduct: state.products[index]));
                            },
                          ),
                          
                          const SizedBox(height: 10)
                      ],
                      );
                    }
                    return Container();
                })
              ],
            ),
          ),
        )
      ),
    );
  }
}