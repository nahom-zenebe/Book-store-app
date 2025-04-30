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
              return SizedBox(
                height: 80, // Fixed height for the horizontal scroll
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(10),
                  itemCount: state.Category.length,
                  itemBuilder: (context, index) {
                    final category = state.Category[index];
                    return Container(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      width: 150, // Fixed width for each item
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(index),
                        border: Border.all(
                          color: Colors.black,
                          width: 2
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          category.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is CategoryError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }


  Color _getCategoryColor(int index) {
    final colors = [
      Colors.white,
      
    ];
    return colors[index % colors.length];
  }
}