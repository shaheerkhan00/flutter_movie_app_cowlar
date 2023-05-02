import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_app_cowlar/screens/moviesearch.dart';
import 'package:movie_app_cowlar/widgets/trendingmovies.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/movies.dart';
import '../api/api_key.dart';

class MovieListScreen extends StatefulWidget {
  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late Future<List<dynamic>> _movieDetailsFuture;

  @override
  void initState() {
    _movieDetailsFuture = _getMovieDetails();

    super.initState();
  }

  Future<List<dynamic>> _getMovieDetails() async {
    final dio = Dio();

    final url = 'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        var trendingResult = response.data['results'] as List<dynamic>;
        // ignore: use_build_context_synchronously
        Provider.of<Movies>(context, listen: false).updateMovie(trendingResult);
        return trendingResult;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> movies = Provider.of<Movies>(context).movie;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pushNamed(MovieSearchScreen.routeName);
            },
            icon: Icon(Icons.search),
          )
        ],
        title: Text(
          'Watch  ',
          style: GoogleFonts.poppins(
            color: Color(0xFF202C43),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final double deviceWidth = MediaQuery.of(context).size.width;
          final double deviceHeight = MediaQuery.of(context).size.height;
          final bool isPortrait = orientation == Orientation.portrait;
          final double posterWidth =
              isPortrait ? deviceWidth * 0.4 : deviceWidth * 0.25;

          return FutureBuilder(
            future: _movieDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Container(
                  height: deviceHeight,
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TrendingMovies(
                        trending: movies,
                        isPortrait: orientation == Orientation.portrait,
                      )),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
