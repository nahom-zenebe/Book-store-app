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
    return Scaffold(
      body: BlocBuilder<Cateogorybloc, Categorystate>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                itemCount: state.Category.length,
                itemBuilder: (context, index) {
                  final category = state.Category[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: ActionChip(
                      backgroundColor: Colors.green[800], // dark green
                      label: Text(
                        category.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 4,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        // Handle chip tap
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Selected category: ${category.name}')),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else if (state is CategoryError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
