import 'package:bloc_project/data/api/api_service.dart';
import 'package:bloc_project/data/database/database_repository.dart';
import 'package:bloc_project/view/add_item/item_view_screen.dart';
import 'package:bloc_project/view/bottom_bar_screen.dart';
import 'package:bloc_project/view/item/item_list_screen.dart';
import 'package:bloc_project/view_model/add_item_bloc/add_item_block_logic.dart';
import 'package:bloc_project/view_model/item_bloc/item_bloc_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     providers: [
       BlocProvider(create: (context) => ItemBloc(ApiService())),
       BlocProvider(create: (context) => AddItemBloc(DatabaseRepository())),
     ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:BottomBarScreen() ,
      ),
    );
  }
}

