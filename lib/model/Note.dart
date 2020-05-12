
class Note{
  
  int id;
  String title;
  String desc;
  String date;

  Note(
    this.title,
    this.desc,
    this.date
  );

  Note.fromMap(Map map){
    this.id    = map["id"];
    this.title = map["title"];
    this.desc  = map["desc"];
    this.date  = map["date"];
  }

  Map toMap(){

    Map<String, dynamic> map = {
      "title" : this.title,
      "desc"  : this.desc,
      "date"  : this.date,
    };

    if(this.id != null){
      map["id"] = this.id;
    }

    return map;

  }

}