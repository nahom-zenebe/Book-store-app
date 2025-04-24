import 'package:book_store_app/Features/Category/presentation/Categoryevent.dart';
import 'package:book_store_app/Features/Category/presentation/Categorystate.dart';
import 'package:book_store_app/Features/Category/presentation/Cateogorybloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Displaycategorypage extends StatefulWidget {
  const Displaycategorypage({super.key});

  @override
  State<Displaycategorypage> createState() => _DisplaycategorypageState();
}

class _DisplaycategorypageState extends State<Displaycategorypage> {
   @override
  void initState() {
    super.initState();
    BlocProvider.of<Cateogorybloc>(context).add(GetAllCategory());
  }


  @override
  Widget build(BuildContext context) {
    final categorybloc = BlocProvider.of<Cateogorybloc>(context);
    return Scaffold(
      body: Container(
        child: BlocBuilder<Cateogorybloc, Categorystate>(
            builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65),
                itemCount: state.Category.length,
                itemBuilder: (context, index) {
                  final category = state.Category[index];

                  return Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black
                    ),
                    child: Text(category.name,
                    style: TextStyle(
                      color: Colors.white
                    ),),
                  );
                });
                
          }
          else if (state is CategoryError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return Container();
        }),
      ),
    );
  }
}
