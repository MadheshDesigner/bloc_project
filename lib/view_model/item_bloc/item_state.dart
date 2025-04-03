import 'package:bloc_project/model/item_list_model.dart';
import 'package:equatable/equatable.dart';

abstract  class ItemState extends Equatable{
  @override
  List<Object> get props =>[];
}

class ItemInitial extends ItemState{}

class  ItemLoading extends ItemState{}

class ItemLoaded extends ItemState{
 final List<ItemListModel> itemList;
 ItemLoaded(this.itemList);

 @override
 List<Object> get props =>[itemList];
}

class ItemError extends ItemState{
  final String error;
  ItemError(this.error);
  @override
  List<Object> get props =>[error];
}