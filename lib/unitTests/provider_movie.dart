import 'package:flutter_test/flutter_test.dart';
import '../provider/movies.dart';

void main() {
  group('Movies', () {
    test('updateMovie() updates the movie list', () {
      final movies = Movies();
      final newMovieList = [
        {'title': 'The Shawshank Redemption'},
        {'title': 'The Godfather'},
        {'title': 'The Dark Knight'},
      ];

      movies.updateMovie(newMovieList);

      expect(movies.movie, equals(newMovieList));
    });

    test('get movie returns a copy of the movie list', () {
      final movies = Movies();
      final initialMovieList = [
        {'title': 'The Matrix'},
        {'title': 'Inception'},
        {'title': 'Blade Runner'},
      ];

      movies.updateMovie(initialMovieList);
      final copiedMovieList = movies.movie;

      expect(copiedMovieList, equals(initialMovieList));
      expect(identical(copiedMovieList, initialMovieList), isFalse);
    });
  });
}
