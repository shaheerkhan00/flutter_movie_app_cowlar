import 'dart:convert';
import './moviedetail.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/api_key.dart';

List categories = [
  {
    'name': 'Comedy',
    'image': 'assets/icons/Rectangle 2235comedy.png',
  },
  {
    'name': 'Crime',
    'image': 'assets/icons/Rectangle 2236crme.png',
  },
  {
    'name': 'Family',
    'image': 'assets/icons/Rectangle 2237family.png',
  },
  {
    'name': 'Documentaries',
    'image': 'assets/icons/Rectangle 2238documentaries.png',
  },
  {
    'name': 'Dramas',
    'image': 'assets/icons/Rectangle 2239dramas.png',
  },
  {
    'name': 'Fantasy',
    'image': 'assets/icons/Rectangle 2240fantasy.png',
  },
  {
    'name': 'Holidays',
    'image': 'assets/icons/Rectangle 2241holidays.png',
  },
  {
    'name': 'Horror',
    'image': 'assets/icons/Rectangle 2242horror.png',
  },
  {
    'name': 'Sci-Fi',
    'image': 'assets/icons/Rectangle 2243scifi.png',
  },
  {
    'name': 'Thriller',
    'image': 'assets/icons/Rectangle 2244thriller.png',
  },
];

class MovieSearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  @override
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  void _searchMovies(String query) async {
    final String url = '$API_URL?api_key=$apiKey&query=$query';
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _searchResults = jsonDecode(response.body)['results'];
        print(_searchResults);
      });
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: null,
      //  AppBar(
      //   title: Text('Movie Search'),
      //   backgroundColor: Colors.white,
      // ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight * (50 / 813),
                bottom: deviceHeight * (10 / 813)),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: Colors.blue.shade300),
                ),
                hintText: 'Enter a movie name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    final String query = _searchController.text.trim();
                    _searchMovies(query);
                  },
                ),
              ),
            ),
          ),
          _searchController.text == ''
              ? Expanded(
                  child: GridView.count(
                      crossAxisCount: 2, // number of cards per row
                      children: List.generate(categories.length, (index) {
                        return Container(
                          height: deviceHeight * (100 / 813),
                          width: deviceWidth * (163 / 375),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _searchController.text =
                                      categories[index]['name'];
                                  final String query =
                                      _searchController.text.trim();
                                  _searchMovies(query);
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15),
                                      ),
                                      child: Image.asset(
                                        categories[index]['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        deviceHeight * (8 / 813)),
                                    child: Text(
                                      categories[index]['name'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      final dynamic movie = _searchResults[index];
                      return InkWell(
                        onTap: () {
                          print('ontp card');
                          if (movie['title'] == null || movie['title'] == '') {
                            movie['title'] = '';
                          }

                          if (movie['release_date'] == null ||
                              movie['release_date'] == '') {
                            movie['release_date'] = '';
                          }

                          Navigator.of(context).pushNamed(
                            MovieDetailScreen.routeName,
                            arguments: {
                              'movieId': movie['id'],
                              'release_date': movie['release_date'],
                              'title': movie['title'],
                              'overview': movie['overview'],
                              'picture': movie['backdrop_path']
                            },
                          );
                        },
                        child: ListTile(
                          title: Text(movie['title']),
                          subtitle: Text(movie['release_date']),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              color: Colors.black,
                              height: 100,
                              width: 130,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w185/${movie['poster_path']}',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
