import 'package:flutter/material.dart';
import 'package:flutter_repos/models/repo.dart';
import 'package:flutter_repos/services/network.dart';
import 'package:pagination/pagination.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var network = Network();

  Future<List<Repo>> fetchPage(int offset) async {
    List<Repo> reposList = List<Repo>();

    List repos = await network.getRepos(offset);
    
    for (var repo in repos) {
      reposList.add(Repo.fromJson(repo));
    }
    return reposList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: PaginationList<Repo>(
            pageFetch: fetchPage,
            onError: (dynamic error) => Center(
              child: Text('Something Went Wrong'),
            ),
            onEmpty: Center(
              child: Text('Empty List'),
            ),
            onLoading: Center(
              child: CircularProgressIndicator(),
            ),
            onPageLoading: Center(child: CircularProgressIndicator(),),
            itemBuilder: (BuildContext context, Repo repo) {
              return Container(
                margin: EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 5,
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(repo.name, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(repo.owner),
                    ],
                  ),
                ),
                alignment: Alignment.centerLeft,
              );
            },
          ),
        ));
  }
}
