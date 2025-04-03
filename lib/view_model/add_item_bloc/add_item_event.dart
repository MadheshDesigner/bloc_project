import 'package:equatable/equatable.dart';

abstract class AddItemEvent extends Equatable{

  @override
  List<Object> get props=>[];
}

class FetchDataItem extends AddItemEvent{}