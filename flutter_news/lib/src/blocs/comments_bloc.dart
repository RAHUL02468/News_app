import '../models/item_models.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class CommentsBloc{
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int,Future<ItemModel>>>();

  //streams
  Observable<Map<int,Future<ItemModel>>> get itemWithComments=>_commentsOutput.stream;

  //sink
  Function(int) get fetchItemWithComments=>_commentsFetcher.sink.add;

  CommentsBloc(){
    _commentsFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
  }



  _commentsTransformer(){
    return ScanStreamTransformer<int,Map<int,Future<ItemModel>>>(
        (cache,int id,index){
          cache[id]=_repository.fetchItem(id);
          cache[id].then((ItemModel item){
            item.kids.forEach((kidId)=>fetchItemWithComments(kidId));
          });
          return cache;
        },
      <int,Future<ItemModel>>{}
    );
  }

  dispose(){
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}