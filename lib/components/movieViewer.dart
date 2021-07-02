import 'dart:convert';
import 'dart:developer' as developer;

import 'package:Praktikum/components/movieDetail.dart';
import 'package:Praktikum/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieViewer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MovieViewerState();
}

class _MovieViewerState extends State<MovieViewer> {

  List movieList;

  Widget movieViewer;

  void getData() async {
    var data = await getDiscoverMovies();

    setState(() {
      movieList = data['results'];

      List<Widget> movieCollections = [];

      movieList.toList().forEach((element) {
        print(element);
        movieCollections.add(
            Row(
              children: [
                new Padding(
                  padding: EdgeInsets.all(16.0),
                  child: new Container(
                    child: new Image(image: new NetworkImage(MOVIE_DB_IMAGE_URL + element["poster_path"]), fit: BoxFit.cover),
                    width: 175.0,
                    height: 175.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF454545),
                              offset: Offset(0.0, 4.0),
                              blurRadius: 12.0
                          )
                        ]
                    ),
                    padding: EdgeInsets.all(12.0),
                  ),
                ),

                new Expanded(
                    child: new Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: new Column(
                        children: [
                          new Text(element["original_title"], textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                          new Padding(padding: EdgeInsets.all(2.0)),
                          new Text(element["overview"], maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(
                              fontSize: 16.0
                          ),
                          ),
                          ElevatedButton(onPressed: () {
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) => (MovieDetail(movie: element))
                                ));
                          }, child: Text("Detail"))
                        ],
                      ),
                    )
                )
              ],
            )
        );
      });

      movieViewer = ListView(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
        children: movieCollections,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: movieViewer,
    );
  }
}

Future<Map> getDiscoverMovies() async {
  var discoverUrl = Uri.https(MOVIE_DB_BASE_URL, '/3/discover/movie', { 'api_key': API_KEY });

  http.Response response = await http.get(discoverUrl);
  return json.decode(response.body);
}
