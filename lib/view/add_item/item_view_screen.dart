import 'package:bloc_project/view_model/add_item_bloc/add_item_block_logic.dart';
import 'package:bloc_project/view_model/add_item_bloc/add_item_event.dart';
import 'package:bloc_project/view_model/add_item_bloc/add_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/database/database_repository.dart';
import '../../utils/common_toast.dart';
import 'package:provider/provider.dart';

import '../item/item_detail_screen.dart';
import 'add_item_screen.dart';
import 'edit_item_screen.dart';

class ItemViewScreen extends StatefulWidget {
  const ItemViewScreen({super.key});

  @override
  State<ItemViewScreen> createState() => _ItemViewScreenState();
}

class _ItemViewScreenState extends State<ItemViewScreen> {
  DatabaseRepository _repository = DatabaseRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AddItemBloc>().add(FetchDataItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Item View")),
      body: BlocBuilder<AddItemBloc,AddItemState>(
          builder: (context, state) {
            if(state is AddItemLoading){
              return Center(child: CircularProgressIndicator());
            }else if(state is AddItemLoaded){
              return state.itemModel.isNotEmpty?GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.6,
                ),
                itemCount: state.itemModel.length,
                itemBuilder: (context, index) {
                  final listData = state.itemModel[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ItemDetailScreen(
                            title: listData.title,
                            description: listData.description,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        // color: Color(0xff090979),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff020024),
                            Color(0xff090979),
                            Color(0xff00d4ff),
                          ],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Title',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => EditItemScreen(
                                            id: listData.id!,
                                            title: listData.title,
                                            description:
                                            listData.description,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  GestureDetector(
                                    onTap: () {
                                      deleteAccount(listData.id!);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            listData.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              listData.description,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ): Center(
                child: Text(
                  "No data available",
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
            else if(state is AddItemErro){
              return Text(state.error);
            }
            return Container();
          },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void deleteAccount(int id) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              "Delete Item",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: const Text("Are you sure want to delete this item?"),
            actions: [
              MaterialButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minWidth: 80,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    _repository.deleteItem(id);
                    context.read<AddItemBloc>().add(FetchDataItem());
                    CommonToast.SuccessToast("Item Deleted Successfully..");
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
