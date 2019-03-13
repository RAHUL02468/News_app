import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';


class NewsList extends StatelessWidget{
  Widget build(context){

    final bloc = StoriesProvider.of(context);

    bloc.fetchTopIds();


    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }


  Widget buildList(StoriesBloc bloc){
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context,AsyncSnapshot<List<int>>snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }


        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context,int index){
              bloc.fetchItem(snapshot.data[index]);
              return NewsListTile(itemId: snapshot.data[index],);
            },
          ),
        );
      },
    );
  }
}



//practice for rendering items at the time of fetching
//Widget buildList(){
//  return ListView.builder(
//    itemCount: 1000,
//    itemBuilder: (context,int index){
//      return FutureBuilder(
//        future: getFuture(),
//        builder: (context,snapshot) {
//          if (snapshot.hasData == true) {
//            return new Container(child: Text('u can see me $index '),height: 80.0,);
//          }
//          else {
//            return new Container(
//              child: Text('u cant see me now sorry for that $index'),height: 80.0,);
//          }
//        },
//      );
//    },
//  );
//}
//getFuture(){
//  return Future.delayed(
//    Duration(seconds: 4),
//        ()=>'hi',
//  );
//}