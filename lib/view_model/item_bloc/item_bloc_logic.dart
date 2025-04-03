import 'package:bloc_project/data/api/api_service.dart';
import 'package:bloc_project/model/item_list_model.dart';
import 'package:bloc_project/view_model/item_bloc/item_event.dart';
import 'package:bloc_project/view_model/item_bloc/item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemBloc extends Bloc<ItemEvent,ItemState>{
  ApiService apiService;
  final List<ItemListModel> _itemList = [];
 ItemBloc(this.apiService):super(ItemInitial()){
   on<FetchItem>((event,emit)async{
     emit(ItemLoading());
     try{
       final response = await apiService.getApiData();
       response.forEach((data){
         _itemList.add(ItemListModel.fromJson(data));
       });
       emit(ItemLoaded(_itemList));
     }
     catch(e){
     emit(ItemError(e.toString()));
     }
   });
 }
}