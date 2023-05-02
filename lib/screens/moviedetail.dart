import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app_cowlar/screens/seatbook.dart';
import './moviePlayer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import '../api/api_key.dart';

class MovieDetailScreen extends StatefulWidget {
  static const routeName = '/movie-detail';

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<Map<String, dynamic>> _movieDetailsFuture;
  late Future<Map<String, dynamic>> _movieImagesFuture;
  late Future<Map<String, dynamic>> _movieVideoFuture;
  late int _movieId = 934433;
  late String _title = '';
  late String _overview = '';
  late String _releaseDate = '';
  late String? _backDrop = '';
  String picUrl = '';
  late var trailerKey = '';
  late List genresR = [];

  @override
  void didChangeDependencies() {
    print('did');
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _movieId = arguments['movieId'];
    print(_movieId);
    _title = arguments['title'];
    print(_title);
    _releaseDate = arguments['release_date'];
    print(_releaseDate);
    _overview = arguments['overview'];
    print(_overview);
    _backDrop = arguments['picture'];
    print(_overview);
    picUrl = 'https://image.tmdb.org/t/p/w500$_backDrop';
    print(_movieId);
    _movieDetailsFuture = _getMovieDetails();
    _movieImagesFuture = _getMovieImages();
    _movieVideoFuture = _getMovieVideos();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _movieDetailsFuture = _getMovieDetails();
    super.initState();
  }

  Future<Map<String, dynamic>> _getMovieDetails() async {
    try {
      final response = await Dio().get(
          'https://api.themoviedb.org/3/movie/$_movieId',
          queryParameters: {'api_key': apiKey});
      if (response.statusCode == 200) {
        print('get movie details');
        print(response.data);
        final respImages = response.data;
        setState(() {
          genresR = respImages['genres'];
        });

        print(genresR);

        return response.data;
      } else {
        print('exception in move details');
        return response.data;
      }
    } catch (e) {
      // handle error
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> _getMovieImages() async {
    print(_movieId);
    print(Uri.parse(
        'https://api.themoviedb.org/3/movie/$_movieId/images?api_key=$apiKey'));
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$_movieId/images?api_key=$apiKey'));
    if (response.statusCode == 200) {
      print('get movie images');
      print(json.decode(response.body));

      return json.decode(response.body);
    } else {
      //throw Exception('Failed to load movie images');
      print('exception in movie player');
      return json.decode(response.body);
    }
  }

  Future<Map<String, dynamic>> _getMovieVideos() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$_movieId/videos?api_key=$apiKey&type=Trailer'));
    if (response.statusCode == 200) {
      print('get movie videos');
      print(json.decode(response.body));
      var resp = json.decode(response.body);
      final teaser = resp['results'].firstWhere(
        (result) => result['type'] == 'Trailer',
        orElse: () => '',
      );
      print('printing teaset');

      print(teaser);
      trailerKey = teaser != '' ? teaser['key'] : teaser['key'];

      return json.decode(response.body);
    } else {
      //throw Exception('Failed to load movie images');
      print('exception in movie player');
      return json.decode(response.body);
    }
  }

  @override
  // List<String> genres = ['Action', 'Thriller', 'Science', 'Fiction'];
  List<Color> colors = [
    Color(0xFF15D2BC),
    Color(0xFFE26CA5),
    Color(0xFF564CA3),
    Color(0xFFCD9D0F)
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: genresR.length == 0
          ? Center(child: CircularProgressIndicator())
          : LayoutBuilder(builder: (context, constraints) {
              final double maxHeight = constraints.maxHeight;
              final double maxWidth = constraints.maxWidth;
              final bool isPortrait = maxHeight > maxWidth;
              return SingleChildScrollView(
                  child: !isPortrait
                      ? Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: maxHeight,
                                  width: maxWidth / 2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(picUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 30, left: 10),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: SvgPicture.asset(
                                          'assets/icons/back.svg',
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      // centerTitle: true,
                                      Text(
                                        'Watch  ',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          4,
                                      left: MediaQuery.of(context).size.width /
                                          8.5),
                                  child: Column(
                                    children: [
                                      Text(
                                        _title,
                                        style: GoogleFonts.poppins(
                                            color: Color.fromARGB(
                                                255, 207, 211, 219),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Releasing at :$_releaseDate',
                                        style: GoogleFonts.poppins(
                                            color: Color.fromARGB(
                                                255, 231, 233, 236),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          print('Get tickets');
                                          Navigator.of(context).pushNamed(
                                              SeatBookScreen.routeName,
                                              arguments: {
                                                'title': _title,
                                                'releaseDate': _releaseDate
                                              });
                                        },
                                        child: Text('Get tickets'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF61C3F2),
                                          // Color code #61C3F2
                                          minimumSize: Size(
                                              243, 50), // Desired dimensions
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20), // Desired border radius
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        width: 243,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            print(trailerKey);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MoviePlayerPage(
                                                        videoKey: trailerKey
                                                            .toString()),
                                              ),
                                            );
                                            print('watch trailer');
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.play_arrow),
                                              Text('Watch Trailer'),
                                            ],
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            side: BorderSide(
                                                width: 2,
                                                color: Color(0xFF61C3F2)),
                                            primary: Colors
                                                .transparent, // Color code #61C3F2
                                            minimumSize: Size(
                                                243, 50), // Desired dimensions
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20), // Desired border radius
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Genres',
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xFF202C43),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      height: 30,
                                      width: (maxWidth / 2.5),
                                      child: SizedBox(
                                        height: 30,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: genresR.length <= 4
                                                ? genresR.length
                                                : 4,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: [
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    height: 30,

                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical:
                                                            5), // Set padding for text content
                                                    decoration: BoxDecoration(
                                                      color: colors[
                                                          index], // Set background color
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20), // Set border radius to create capsule shape
                                                    ),
                                                    child: Text(
                                                      genresR[index][
                                                          'name'], // Replace this with your text content
                                                      style: TextStyle(
                                                        color: Colors
                                                            .white, // Set text color
                                                        fontSize:
                                                            16, // Set text size
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 15,
                                          right: 15),
                                      child: Divider(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Overview',
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xFF202C43),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      width: maxWidth / 2.5,
                                      child: Text(
                                        _overview,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF8F8F8F),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: maxHeight / 2,
                                  width: isPortrait ? maxWidth : maxWidth / 2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(picUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  top: maxHeight / 2,
                                  left: isPortrait ? 0 : maxWidth / 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 30, left: 10),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: SvgPicture.asset(
                                          'assets/icons/back.svg',
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      // centerTitle: true,
                                      Text(
                                        'Watch  ',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          4),
                                  child: Column(
                                    children: [
                                      Text(
                                        _title,
                                        style: GoogleFonts.poppins(
                                            color: Color.fromARGB(
                                                255, 207, 211, 219),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Releasing at :$_releaseDate',
                                        style: GoogleFonts.poppins(
                                            color: Color.fromARGB(
                                                255, 231, 233, 236),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          print('Get tickets');
                                          Navigator.of(context).pushNamed(
                                              SeatBookScreen.routeName,
                                              arguments: {
                                                'title': _title,
                                                'releaseDate': _releaseDate
                                              });
                                        },
                                        child: Text('Get tickets'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF61C3F2),
                                          // Color code #61C3F2
                                          minimumSize: Size(
                                              243, 50), // Desired dimensions
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20), // Desired border radius
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        width: 243,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            print(trailerKey);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MoviePlayerPage(
                                                        videoKey: trailerKey
                                                            .toString()),
                                              ),
                                            );
                                            print('watch trailer');
                                          },
                                          child: Row(
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Icon(Icons.play_arrow),
                                              Text('Watch Trailer'),
                                            ],
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            side: const BorderSide(
                                                width: 2,
                                                color: Color(0xFF61C3F2)),
                                            primary: Colors
                                                .transparent, // Color code #61C3F2
                                            minimumSize: const Size(
                                                243, 50), // Desired dimensions
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20), // Desired border radius
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Genres',
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xFF202C43),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      height: 30,
                                      child: SizedBox(
                                        height: 30,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: genresR.length <= 4
                                                ? genresR.length
                                                : 4,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: [
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    height: 30,

                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical:
                                                            5), // Set padding for text content
                                                    decoration: BoxDecoration(
                                                      color: colors[
                                                          index], // Set background color
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20), // Set border radius to create capsule shape
                                                    ),
                                                    child: Text(
                                                      genresR[index][
                                                          'name'], // Replace this with your text content
                                                      style: TextStyle(
                                                        color: Colors
                                                            .white, // Set text color
                                                        fontSize:
                                                            16, // Set text size
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 15,
                                          right: 15),
                                      child: Divider(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Overview',
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xFF202C43),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      _overview,
                                      style: GoogleFonts.poppins(
                                          color: Color(0xFF8F8F8F),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ]),
                            ),
                          ],
                        ));
            }),
    );
  }
}
