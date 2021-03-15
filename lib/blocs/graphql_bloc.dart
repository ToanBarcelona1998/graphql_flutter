import 'package:demo_grahql_flutter/models/enitys/country.dart';
import 'package:demo_grahql_flutter/models/services/graphql_service.dart';
import 'package:rxdart/rxdart.dart';

class GrapHqlBloc{
  PublishSubject<List<Country>> _publishSubject=PublishSubject();
  Stream get stream=>_publishSubject.stream;

  sinkData(String query) async{
    _publishSubject.sink.add(await GrapHqlService().loadData(query));
  }
}