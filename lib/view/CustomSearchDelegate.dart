import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String>{
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      )
    ];    
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          close(context, "");
        },
      );    
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    print(query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //return Container();
    List<String> listOp = List();

    if(query.isNotEmpty){

      listOp = [
        "Android", "Games", "IOS", "Dev", "Upgrade"
      ].where((element) => element.toLowerCase().startsWith(
        query.toLowerCase()
        )
      ).toList();

      return ListView.builder(
        key: Key("search_list"),
        itemCount: listOp.length,
        itemBuilder: (context, index){
          return ListTile(
            onTap: (){
              close(context, listOp[index]);
            },
            title: Text(listOp[index]),
          );
        },
      );

    }else{
      return Container();
    }
  }

}