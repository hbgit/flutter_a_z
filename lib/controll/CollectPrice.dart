import 'package:http/http.dart' as http;
import 'dart:convert'; //json
//import 'dart:async';

class CollectPrice{
  
  String price;
  int codStatus = 0;
  
  Future<bool> collectBitPrice() async {
    
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);

    // The request has succeeded. The information returned 
    // with the response is dependent on the method used 
    // in the request
    //print(response.statusCode.toString());
    if(response.statusCode == 200){
      codStatus = 200;
      //print("C1 " + codStatus.toString());
      
      Map<String, dynamic> retAnswer = json.decode(response.body);

      if(retAnswer["BRL"]["buy"].toString() != null){
        price = retAnswer["BRL"]["buy"].toString();
        //print(price);
        return true;
        //return _price;
      }else{
        return false;
      }


    }else{
      return false;
    }

  }

}