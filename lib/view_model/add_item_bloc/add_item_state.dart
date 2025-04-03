import 'package:bloc_project/model/add_item_model.dart';
import 'package:equatable/equatable.dart';

abstract class AddItemState extends Equatable{

  @override
  List<Object> get props=>[];
}

 class AddItemInitial extends AddItemState{}
 class AddItemLoading extends AddItemState{}
 class AddItemLoaded extends AddItemState{
  final List<ItemModel> itemModel;
  AddItemLoaded(this.itemModel);
  @override
  List<Object> get props=>[itemModel];
}

 class AddItemErro extends AddItemState{
  final String error;
  AddItemErro(this.error);

  @override
  List<Object> get props=>[error];
 }