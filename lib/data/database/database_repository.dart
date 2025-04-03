import 'package:bloc_project/data/database/database_connection.dart';
import 'package:bloc_project/model/add_item_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepository{
  late DatabaseConnection _databaseConnection;
  DatabaseRepository(){
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  static const String tableName = "tabledata";

  Future<Database?> get database async{
    if(_database!=null){
      return _database;
    }else{
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  Future<int> insertItem(ItemModel item)async{
   final connection = await database;
   return await connection!.insert(tableName, item.toMap());
  }

  Future<List<ItemModel>> getItem()async{
    final connection = await database;
    final List<Map<String, dynamic>> data = await connection!.query(tableName);
    return List.generate(data.length, (index) {
      return ItemModel.fromMap(data[index]);
    },);
  }

  Future<int> updateItem(ItemModel item)async{
    final connection = await database;
    return await connection!.update(tableName, item.toMap(),where: 'id=?',whereArgs:[ item.id]);
  }

  Future<int> deleteItem(int id)async{
    final connection = await database;
    return await connection!.delete(tableName,where: 'id=?',whereArgs:[id]);
  }

}