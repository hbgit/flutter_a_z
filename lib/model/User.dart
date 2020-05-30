class User {
  String name;
  String email;
  String password;

  User();

  Map<String, dynamic> toMap(){
    Map<String,dynamic> map = {
      "name:" : this.name,
      "email" : this.email
    };
    return map;
  }

}
