import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviedbapp/bloc/get_movies_bloc.dart';
import 'package:moviedbapp/model/movie.dart';
import 'package:moviedbapp/model/movie_detail_response.dart';
import 'package:moviedbapp/model/movie_response.dart';
import 'package:moviedbapp/style/theme.dart' as Style;

import 'detail_screen.dart';
class SearchPage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();
  final String apiKey = "4b8c5be3d22f6e4ece12b0cd111047d0";
  static String mainUrl = "https://api.themoviedb.org/3";
  var movieUrl = '$mainUrl/movie';
  final Dio _dio = Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();


  @override
  void initState() {
    super.initState();
    moviesBloc..getMovies();
  }


  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        StreamBuilder<MovieResponse>(
            stream: moviesBloc.subject.stream,
            builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
              if(snapshot.hasData) {
                if (snapshot.data.error != null && snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildMoviesListWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            }
        ),
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Error Occurred: $error")
        ],
      ),
    );
  }

  Widget _buildMoviesListWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if(movies.length == 0) {
      return Container(
        child: Text("No Movies"),
      );
    } else
      return Container(
        height: 270.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  right: 10.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movie: movies[index])
                    ));
                  },
                  child: Column(
                    children: <Widget>[
                      movies[index].poster == null ?
                      Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: BoxDecoration(
                            color: Style.Colors.secondColor,
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            shape: BoxShape.rectangle
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(EvaIcons.filmOutline, color: Colors.black, size: 50.0,),
                          ],
                        ),
                      ) :
                      Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w200" + movies[index].poster),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: 100.0,
                        child: Text(
                          movies[index].title,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.0
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(movies[index].rating.toString(), style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(
                            width: 5.0,
                          ),
                          RatingBar(
                            itemSize: 8.0,
                            initialRating: movies[index].rating/2,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              EvaIcons.star,
                              color: Colors.yellow,
                            ),
                            onRatingUpdate: (rating){
                              print(rating);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
      );
  }



  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {
      "api_key": apiKey,
      "language":"en-US"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id", queryParameters: params);
      return MovieDetailResponse.fromJson(response.data);
    } catch (error , stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return MovieDetailResponse.withError("$error");
    }
  }


}