import 'package:bloc_project/view_model/item_bloc/item_bloc_logic.dart';
import 'package:bloc_project/view_model/item_bloc/item_event.dart';
import 'package:bloc_project/view_model/item_bloc/item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item_detail_screen.dart';


class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ItemBloc>().add(FetchItem());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Item List"),automaticallyImplyLeading: false,),
      body: BlocBuilder<ItemBloc,ItemState>(
        builder: (context, state) {
          if(state is ItemLoading){
             return Center(child: CircularProgressIndicator());
          }
          else if(state is ItemLoaded){
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.4),
              itemCount: state.itemList.length,
              itemBuilder: (context, index) {
                final listData = state.itemList[index];
                return GestureDetector(
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailScreen(title: listData.title, description: listData.body),));
                  },
                  child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        // color: Color(0xff090979),
                        gradient: LinearGradient(
                          colors: [Color(0xff020024), Color(0xff090979),Color(0xff00d4ff)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),
                          SizedBox(height: 10,),
                          Text(listData.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                          SizedBox(height: 20,),
                          Text('Description',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),
                          SizedBox(height: 10,),
                          Expanded(child: Text(listData.body,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white),overflow: TextOverflow.ellipsis,)),
                        ],
                      )
                  ),
                );
              },
            );
          }
          else if(state is ItemError){
            return Text(state.error);
          }
          return Container();
      },),
    );
  }
}
