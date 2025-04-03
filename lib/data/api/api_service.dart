import 'package:dio/dio.dart';

class ApiService{
  final Dio dio = Dio();
  
  Future<dynamic> getApiData()async{
    try{
      final response = await dio.get("https://jsonplaceholder.typicode.com/posts");
      if(response.statusCode==200){
       return  response.data;
      }else{
        return null;
      }
    }
    catch(e){
      print(e.toString());
    }
  }
}