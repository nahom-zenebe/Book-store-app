import 'package:book_store_app/Features/Auth/presentation/Authbloc.dart';
import 'package:book_store_app/Features/Book/data/Bookdatasource.dart';
import 'package:book_store_app/Features/Book/data/BookrepostoryImp.dart';
import 'package:book_store_app/Features/Book/presentation/Bookbloc.dart';
import 'package:book_store_app/Features/Book/presentation/Cartbloc.dart';
import 'package:book_store_app/Features/Category/data/Categorydatasource.dart';
import 'package:book_store_app/Features/Category/data/Categoryimplrepository.dart';
import 'package:book_store_app/Features/Category/domain/Categoryrepository.dart';
import 'package:book_store_app/Features/Category/presentation/Cateogorybloc.dart';
import 'package:book_store_app/pages/Landingpage.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>BookBloc(Bookrepostoryimp(bookdatasource:Bookdatasource() ))),
          BlocProvider(create: (context)=> Cartbloc()),
          BlocProvider(create: (context)=> AuthBloc()),
          BlocProvider(create: (context)=>Cateogorybloc(Categoryimplrepository(categorydatasource:Categorydatasource() )))

        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: Landingpage(),
        ));
  }
}
