import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../screens/moviedetail.dart';

class SearchMovie extends StatelessWidget {
  final List trending;
  final List searchResults;
  const SearchMovie({
    Key? key,
    required this.trending,
    required this.searchResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Map<String,dynamic> trending;
    return Scaffold(
        body: ListView.builder(
            itemCount: trending.length,
            itemBuilder: (context, index) {
              final dynamic movie = searchResults[index];
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      print('ontp card');
                      if (trending[index]['title'] == null ||
                          trending[index]['title'] == '') {
                        trending[index]['title'] = '';
                      }

                      if (trending[index]['release_date'] == null ||
                          trending[index]['release_date'] == '') {
                        trending[index]['release_date'] = '';
                      }

                      Navigator.of(context).pushNamed(
                        MovieDetailScreen.routeName,
                        arguments: {
                          'movieId': trending[index]['id'],
                          'release_date': trending[index]['release_date'],
                          'title': trending[index]['title'],
                          'overview': trending[index]['overview'],
                          'picture': trending[index]['backdrop_path']
                        },
                      );
                    },
                    child: SizedBox(
                      height: 180,
                      width: 300,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                'https://image.tmdb.org/t/p/w500${trending[index]['poster_path']}',
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    trending[index]['title'] != null
                                        ? trending[index]['title']
                                        : '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
