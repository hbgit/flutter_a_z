class Message{
  String idUser;
  String msg;
  String urlImg;
  String type;

  Message();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUser" : this.idUser,
      "msg"    : this.msg,
      "urlImg" : this.urlImg,
      "type"   : this.type
    };
    return map;
  }
}