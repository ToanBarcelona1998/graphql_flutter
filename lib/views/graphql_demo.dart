import 'package:demo_grahql_flutter/blocs/graphql_bloc.dart';
import 'package:demo_grahql_flutter/models/enitys/country.dart';
import 'package:flutter/material.dart';

class GrapHqlDemo extends StatefulWidget {
  @override
  _GrapHqlDemoState createState() => _GrapHqlDemoState();
}

class _GrapHqlDemoState extends State<GrapHqlDemo> {
  GrapHqlBloc _bloc;
  String query = """query{
 countries{
  name
  capital
  currency
} 
}""";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = GrapHqlBloc()..sinkData(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder<List<Country>>(
          stream: _bloc.stream,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child: Text("${snapshot.data[index].name}",overflow: TextOverflow.ellipsis,)),
                                Text("${snapshot.data[index].capital}",overflow: TextOverflow.ellipsis,),
                                Text(
                                  "${snapshot.data[index].currency}",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
