import 'dart:io';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  await Hive.init(directory.path);
  await Hive.openBox("mybox");
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  var box=Hive.box("mybox");
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink("https://countries.trevorblades.com/");
    final ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink as Link,
      cache: GraphQLCache(store: HiveStore(box)),
    ));
    return GraphQLProvider(
        client: client,
        child: Scaffold(
          body: HomePage(),
        ),
      );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String query = """
          query {
    country(code: "VN"){
      name
    	code
      phone
    }
}
        """;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Query(
        options: QueryOptions(
          document: gql(query),
        ),
        builder: (QueryResult result, {
          VoidCallback refetch,
          FetchMore fetchMore,
        }){
          if(result.isLoading){
            return CircularProgressIndicator();
          }
          if(result.hasException){
            return Text(result.exception.toString());
          }
          Map map=result.data['country'];
          return ListTile(
            leading: CircleAvatar(
              child: Text(map['phone']),
            ),
            title: Text(map['name']),
            trailing: Text(map['code']),
          );
        },
      ),
    );
  }
}
