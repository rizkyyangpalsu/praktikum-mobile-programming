import 'package:Praktikum/components/movieDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieViewer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MovieViewerState();
}

class _MovieViewerState extends State<MovieViewer> {

  final List<List<String>> movieList = [
    [
      "Avengers Assemble",
      "images/avengers-assemble.jpeg",
      "The further adventures of the Marvel Universe's mightiest general membership superhero team."
    ],
    [
      "Avengers: Infinity War",
      "images/avengers-infinity.jpeg",
      "The Avengers and their allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe."
    ],
    [
      "Avengers: Endgame",
      "images/avengers.jpeg",
      "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe."
    ],
  ];

  Widget movieViewer;

  @override
  void initState() {
    super.initState();

    List<Widget> movieCollections = [];

    movieList.toList().forEach((element) {
      movieCollections.add(
          Row(
            children: [
              new Padding(
                padding: EdgeInsets.all(16.0),
                child: new Container(
                  child: Image.asset(element[1].toString(), fit: BoxFit.cover),
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
                        new Text(element[0], textAlign: TextAlign.center, style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold
                        ),
                        ),
                        new Padding(padding: EdgeInsets.all(2.0)),
                        new Text(element[2], maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(
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

    movieViewer = Column(
      children: movieCollections,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: movieViewer,
    );
  }
}
