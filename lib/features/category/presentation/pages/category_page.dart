import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kidame_gebiya/app_constant.dart';
import 'package:kidame_gebiya/features/category/bloc/category_bloc.dart';
import 'package:kidame_gebiya/features/category/bloc/category_event.dart';
import 'package:kidame_gebiya/features/category/bloc/category_state.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => context.pop(), 
          icon: const Icon(CupertinoIcons.chevron_back)),
        title:const Text('Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      
      body: BlocBuilder<CategoryBloc, CategoryState>(
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
            return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: state.categories.map((category){
                return TextButton(
                  onPressed: () => context.push('/'),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: const BorderSide(
                      color: greyColor,
                      width: .5
                    )
                  ),
                  child: Text(category, 
                    style: const TextStyle(color: Colors.black),),
                );
              }).toList(),
            );
          }
          return const SizedBox();
        }
      ),
    );
  }
}