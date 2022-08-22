import 'package:dio/dio.dart';
import '../../constants/strings.dart';

class CharactersWebServices {
  late Dio dio;
CharactersWebServices(){

  BaseOptions options =  BaseOptions (
   baseUrl:baseUrl,
    receiveDataWhenStatusError: true,
    connectTimeout: 20*1000,//20 second
    receiveTimeout: 20*1000,//20 second
  );
  dio = Dio(options);
}

Future<List<dynamic>>getAllCharacters()async{
try{
  Response respons = await dio.get('characters');
  print(respons.data.toString());
  return respons.data;

  
}catch(e){print(e.toString());

return [];

}
}
  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    try {
      Response response = await dio.get('quote' , queryParameters: {'author' : charName});
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}