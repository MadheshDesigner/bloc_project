import 'package:bloc_project/data/database/database_repository.dart';
import 'package:bloc_project/model/add_item_model.dart';
import 'package:bloc_project/view_model/add_item_bloc/add_item_event.dart';
import 'package:bloc_project/view_model/add_item_bloc/add_item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemBloc extends Bloc<AddItemEvent,AddItemState>{
  final DatabaseRepository _repository;

  AddItemBloc(this._repository):super(AddItemInitial()){
    on<FetchDataItem>(_fetchDataItem);
  }

  Future<void> _fetchDataItem(AddItemEvent event, Emitter<AddItemState> emit)async{
    emit(AddItemLoading());
    Future.delayed(Duration(seconds: 1));
    try{
   List<ItemModel> _itemModel = await _repository.getItem();
   emit(AddItemLoaded(_itemModel));
    }
    catch(e){
      emit(AddItemErro(e.toString()));
    }
  }
}