import 'package:demo_grahql_flutter/models/enitys/country.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';

class GrapHqlService {
  GraphQLClient _client;

  GrapHqlService() {
    var box = Hive.box("mybox");
    HttpLink link = HttpLink("https://countries.trevorblades.com/");
    _client = GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: HiveStore(box),
        ));
  }

  Future<List<Country>> loadData(String query) async {
    List<Country> listCountry = [];
    QueryOptions options = QueryOptions(document: gql(query),variables: <String,String>{
      "code": "AS",
    });
    final result = await _client.query(options);
    List<dynamic> listDynamic = result.data["continent"]['countries'];
    listDynamic.forEach((element) {
      listCountry.add(Country.fromJson(element));
    });
    return listCountry;
  }
}
