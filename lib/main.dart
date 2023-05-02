import 'package:flutter/material.dart';
import 'package:movie_app_cowlar/screens/cinemaSeat.dart';
import 'package:movie_app_cowlar/screens/moviedetail.dart';
import 'package:movie_app_cowlar/screens/seatbook.dart';
import 'package:movie_app_cowlar/screens/tabscreen.dart';
import './screens/moviesearch.dart';
import 'package:provider/provider.dart';
import './provider/movies.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Movies()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          MovieDetailScreen.routeName: (ctx) => MovieDetailScreen(),
          SeatBookScreen.routeName: (ctx) => SeatBookScreen(),
          CinemaSeatBookScreen.routeName: (ctx) => CinemaSeatBookScreen(),
          MovieSearchScreen.routeName: (ctx) => MovieSearchScreen()
        },
        home: TabScreen(),
      ),
    );
  }
}
