import 'package:book_store_app/Features/Book/data/Bookdatasource.dart';
import 'package:book_store_app/Features/Book/data/BookrepostoryImp.dart';
import 'package:book_store_app/Features/Book/presentation/Bookbloc.dart';
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
          BlocProvider(create: (context)=>BookBloc(Bookrepostoryimp(bookdatasource:Bookdatasource() )))

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
