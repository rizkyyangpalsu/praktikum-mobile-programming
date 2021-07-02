import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../config.dart';

class MovieDetail extends StatefulWidget {

  final LinkedHashMap<String, dynamic> movie;

  MovieDetail({ Key key, @required this.movie }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    print(widget.movie);
    return Scaffold(
      body: new Stack(fit: StackFit.expand, children: [
        new Image(image: new NetworkImage(MOVIE_DB_IMAGE_URL + widget.movie["backdrop_path"]), fit: BoxFit.cover),
        new BackdropFilter(
          filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: new Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        new SingleChildScrollView(
          child: new Container(
            margin: const EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 24.0)),
                new Container(
                  alignment: Alignment.center,
                  child: new Container(
                    width: 400.0,
                    height: 400.0,
                  ),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(10.0),
                    image: new DecorationImage(
                      image: new NetworkImage(MOVIE_DB_IMAGE_URL + widget.movie["poster_path"]),
                      fit: BoxFit.cover
                    ),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black,
                        blurRadius: 20.0,
                        offset: new Offset(0.0, 10.0)
                      )
                    ]),
                ),
                new Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 0.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Text(
                            widget.movie["original_title"],
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontFamily: 'Arvo'),
                          )),

                    ]),
                ),
                new Text(widget.movie["overview"],style: new TextStyle(color: Colors.white, fontFamily: 'Arvo')),
                new Padding(padding: const EdgeInsets.all(10.0)),
              ],
            ),
          ),
        )
      ]),
    );
  }
}