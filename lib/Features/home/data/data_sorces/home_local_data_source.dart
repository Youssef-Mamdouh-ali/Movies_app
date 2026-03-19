import 'package:hive/hive.dart';
import 'package:movies_app_project/Features/home/data/model/movie_model.dart';


abstract class MovieLocalDataSource {
  Future<void> addToWatchList(MovieModel movie);
  Future<void> removeFromWatchList(int movieId);
  Future<List<MovieModel>> getWatchList();

  Future<void> addToHistory(MovieModel movie);
  Future<List<MovieModel>> getHistory();
}


class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final Box<MovieModel> watchlistBox;
  final Box<MovieModel> historyBox;

  MovieLocalDataSourceImpl({
    required this.watchlistBox,
    required this.historyBox,
  });

  @override
  Future<void> addToHistory(MovieModel movie) async {


    final dynamic existingKey = historyBox.keys.firstWhere(
          (k) => historyBox.get(k)?.id == movie.id,
      orElse: () => null,
    );


    if (existingKey != null) {

      await historyBox.delete(existingKey);
    }


    if (historyBox.length >= 20) {
      await historyBox.deleteAt(0);
    }


    await historyBox.add(movie);

  }

  @override
  Future<List<MovieModel>> getHistory() async {

    return historyBox.values.toList().reversed.toList();
  }


  @override
  Future<void> addToWatchList(MovieModel movie) async {
    await watchlistBox.put(movie.id, movie);
  }

  @override
  Future<void> removeFromWatchList(int movieId) async {
    await watchlistBox.delete(movieId);
  }

  @override
  Future<List<MovieModel>> getWatchList() async {
    return watchlistBox.values.toList().reversed.toList();
  }
}