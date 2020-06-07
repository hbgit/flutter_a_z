import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  
  String idFrom;
  String idTo;  
  String name;
  String msg;
  String pathPhoto;
  String type; // text or img

  Chat();
 
  /*
  + chat
    + Jhon
      + last chat
        - idFrom
        - idTo
  */

  save() async {
    Firestore db = Firestore.instance;
    await db.collection("chat")
            .document(this.idFrom)
            .collection("lastchat")
            .document(this.idTo)
            .setData(this.toMap());
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idFrom": this.idFrom,
      "idTo"  : this.idTo,
      "name"  : this.name,
      "msg"   : this.msg,
      "pathPhoto" : this.pathPhoto,
      "type"  : this.type
    };

    return map;
  }

}
