class Task {

  String id;  
  String description;
  bool status;  

  Task(
    {
      this.id,       
      this.description, 
      this.status
    }
  );

   /*
   factory Task.fromJson(Map<String, dynamic> json){
    return Task(
      id: json["id"]["videoId"],     
      description: json["snippet"]["description"],

    );
  }
  */

}