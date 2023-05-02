import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_cowlar/screens/moviedetail.dart';
import '../widgets/trendingmovies.dart';

void main() {
  group('TrendingMovies', () {
    final trending = [
      {
        'id': 1,
        'title': 'Movie 1',
        'poster_path': '/poster_1.jpg',
        'release_date': '2022-05-01',
        'overview': 'Overview of Movie 1',
        'backdrop_path': '/backdrop_1.jpg',
      },
      {
        'id': 2,
        'title': 'Movie 2',
        'poster_path': '/poster_2.jpg',
        'release_date': '2022-05-02',
        'overview': 'Overview of Movie 2',
        'backdrop_path': '/backdrop_2.jpg',
      },
      {
        'id': 3,
        'title': 'Movie 3',
        'poster_path': '/poster_3.jpg',
        'release_date': '2022-05-03',
        'overview': 'Overview of Movie 3',
        'backdrop_path': '/backdrop_3.jpg',
      },
    ];

    testWidgets('Renders correct number of movies',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: TrendingMovies(trending: trending),
          routes: {
            MovieDetailScreen.routeName: (ctx) => Scaffold(),
          },
        ),
      );

      expect(find.byType(InkWell), findsNWidgets(trending.length));
    });

    testWidgets('Navigates to correct movie detail screen when tapped',
        (WidgetTester tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();

      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          home: TrendingMovies(trending: trending),
          routes: {
            MovieDetailScreen.routeName: (ctx) => Scaffold(),
          },
        ),
      );

      final firstMovieWidget = find.byType(InkWell).first;
      expect(firstMovieWidget, findsOneWidget);

      await tester.tap(firstMovieWidget);
      await tester.pumpAndSettle();

      expect(navigatorKey.currentState!.canPop(), isTrue);
    });
  });
}
