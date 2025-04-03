import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection{

  Future<Database> setDatabase()async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path,'my_db');
    var database = openDatabase(path,version: 1,onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version)async{
    var query = "CREATE TABLE tabledata(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,description TEXT);";
    await database.execute(query);
  }
}