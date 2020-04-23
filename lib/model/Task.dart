import 'dart:convert';

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

  List getListTaskFromJsonString(String jsonString){

    List tasksData = json.decode(jsonString);
    List tasksObj = [];

    tasksData.forEach((element) {
      Task tmpTask = Task(
        id: element["id"],
        description: element["description"],
        status: element["status"],
      );

      tasksObj.add(tmpTask);

    });

    return tasksObj;

  }

  List getMapListTask (List task){
    List mapTask = [];
    Map<String, dynamic> tmpTask = Map();
    
    task.forEach((element) {
      tmpTask["id"] = element.id;
      tmpTask["description"] = element.description;
      tmpTask["status"] = element.status;

      mapTask.add(tmpTask);
    });

    return mapTask;    
  }

   /*
   factory Task.fromJson(Map<String, dynamic> json){
    return Task(
      id: json["id"]["videoId"],     
      description: json["snippet"]["description"],

    );
  }
  */

}