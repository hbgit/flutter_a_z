// Import the test package and Counter class
import 'dart:convert';

import 'package:flutter_a_z/model/Task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test("Checking task model", () async {
    
    Task task = Task(
      id: "12q",
      description: "Read paper",
      priority: 7.0,
      status: false
    );

    String jsonString = """
    [
     {
      "id": "123abc",
      "description": "Read paper",
      "priority": 7.0,
      "status": false
     }
    ]
    """;

    //print(jsonString);
    print(json.decode(jsonString));

    List resultJson = task.getListTaskFromJsonString(jsonString);
    expect(resultJson.length, isNonZero);

    List getMapList = task.getMapListTask(resultJson);

    getMapList.forEach((element) {
      expect(element.id, "123abc");
      expect(element.description, "Read paper");
      expect(element.priority, 7.0);
      expect(element.priority, false);
    });    
    
  });  

}
