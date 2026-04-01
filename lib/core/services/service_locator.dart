import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Features/authentication/data/data_source/auth_data_source.dart';
import '../../Features/authentication/data/data_source/remote_auth_data_source.dart';
import '../../Features/authentication/data/repositories_imp/auth_repository_imp.dart';
import '../../Features/authentication/domain/repositories/auth_repository.dart';
import '../../Features/authentication/domain/use_cases/forget_password_use_case.dart';
import '../../Features/authentication/domain/use_cases/sign_in_use_case.dart';
import '../../Features/authentication/domain/use_cases/sign_out_use_case.dart';
import '../../Features/authentication/domain/use_cases/sign_up_use_case.dart';
import '../../Features/authentication/presentation/manager/auth_bloc.dart';
import '../../Features/home/data/data_sorces/browse_source.dart';
import '../../Features/home/data/data_sorces/home_local_data_source.dart';
import '../../Features/home/data/data_sorces/home_remote_data_source.dart';
import '../../Features/home/data/model/movie_model.dart';
import '../../Features/home/data/repositories/home_repositories.dart';
import '../../Features/home/data/repository_imp/browse_repository_impl.dart';
import '../../Features/home/domain/repository/BrowseRepository.dart';
import '../../Features/home/domain/use_cases/browse_use_case.dart';
import '../../Features/home/domain/usecases/add_to_history_use_case.dart';
import '../../Features/home/domain/usecases/add_to_watch_list_use_case.dart';
import '../../Features/home/domain/usecases/get_history_use_case.dart';
import '../../Features/home/domain/usecases/get_movie_details_use_case.dart';
import '../../Features/home/domain/usecases/get_movie_suggestions_use_case.dart';
import '../../Features/home/domain/usecases/get_movies_by_genre_use_case.dart';
import '../../Features/home/domain/usecases/get_recent_movies_use_case.dart';
import '../../Features/home/domain/usecases/get_watch_list_use_case.dart';
import '../../Features/home/domain/usecases/remove_from_watch_list_use_case.dart';
import '../../Features/home/domain/usecases/search_movies_use_case.dart';
import '../../Features/home/presentation/bloc/home_bloc.dart';
import '../../Features/home/presentation/manger/layout_bloc.dart';
import '../../Features/language/data/data_sources/language_local_data_source.dart';
import '../../Features/language/data/repository_imp/language_repository_imp.dart';
import '../../Features/language/domain/repositories/language_repository.dart';
import '../../Features/language/domain/use_cases/change_language_use_case.dart';
import '../../Features/language/domain/use_cases/get_saved_language_use_case.dart';
import '../../Features/language/presentation/manager/language_bloc.dart';
import '../network_handler/api_manger/ApiManager.dart';

final sl = GetIt.instance;

void setupBrowseDependencies() {

  /// Dio
  sl.registerLazySingleton(() => Dio());

  /// 🔥 لازم تضيف ده
  sl.registerLazySingleton(() => ApiManager(sl()));

  /// DataSource
  sl.registerLazySingleton<BrowseRemoteDataSource>(
        () => BrowseRemoteDataSourceImpl(sl()),
  );

  /// Repository
  sl.registerLazySingleton<BrowseRepository>(
        () => BrowseRepositoryImpl(sl()),
  );

  /// UseCase
  sl.registerLazySingleton<GetMovies>(
        () => GetMovies(sl()),
  );

  /// Bloc
  sl.registerFactory<LayoutBloc>(
        () => LayoutBloc(sl()),
  );
}


void setupServiceLocator() {
  // 1. Data Source
  sl.registerLazySingleton<AuthDataSource>(() => RemoteAuthDataSource());

  // 2. Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(sl()));
  // 3. Use Case
  sl.registerLazySingleton(() => SignInUseCase(sl()));

  sl.registerLazySingleton(() => SignUpUseCase(sl()));

  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  // 4. Bloc
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()));
}

Future<void> initDependencies() async {

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(MovieModelAdapter());
  }


  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(CastModelAdapter());
  }
  final watchlistBox = await Hive.openBox<MovieModel>('watchlist_box');
  final historyBox = await Hive.openBox<MovieModel>('history_box');
  final authBox = await Hive.openBox('auth_box');
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);
  sl.registerLazySingleton<LanguageLocalDataSource>(() => LanguageLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<LanguageRepository>(() => LanguageRepositoryImpl(sl()));
  sl.registerLazySingleton(() => ChangeLanguageUseCase(sl()));
  sl.registerLazySingleton(() => GetSavedLanguageUseCase(sl()));

  sl.registerFactory(() => LanguageBloc(sl(), sl()));
  sl.registerLazySingleton<Box<MovieModel>>(
        () => watchlistBox,
    instanceName: 'watchlist',
  );
  sl.registerLazySingleton<Box<MovieModel>>(
        () => historyBox,
    instanceName: 'history',
  );
  sl.registerLazySingleton<Box>(() => authBox);
  sl.registerLazySingleton<http.Client>(() => http.Client());

  sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<MovieLocalDataSource>(
        () => MovieLocalDataSourceImpl(
      watchlistBox: sl<Box<MovieModel>>(instanceName: 'watchlist'),
      historyBox: sl<Box<MovieModel>>(instanceName: 'history'),
    ),
  );

  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  sl.registerLazySingleton<GetRecentMoviesUseCase>(
        () => GetRecentMoviesUseCase(sl()),
  );
  sl.registerLazySingleton<GetMoviesByGenreUseCase>(
        () => GetMoviesByGenreUseCase(sl()),
  );
  sl.registerLazySingleton<GetMovieDetailsUseCase>(
        () => GetMovieDetailsUseCase(sl()),
  );
  sl.registerLazySingleton(() => GetMovieSuggestionsUseCase(sl()));
  sl.registerLazySingleton(() => SearchMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetWatchListUseCase(sl()));
  sl.registerLazySingleton(() => AddToWatchListUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromWatchListUseCase(sl()));
  sl.registerLazySingleton(() => GetHistoryUseCase(sl()));
  sl.registerLazySingleton(() => AddToHistoryUseCase(sl()));
  sl.registerFactory<HomeBloc>(
        () => HomeBloc(
      getRecentMoviesUseCase: sl(),
      getMoviesByGenreUseCase: sl(),
      getMovieDetailsUseCase: sl(),
      getMovieSuggestionsUseCase: sl(),
      searchMoviesUseCase: sl(),
      getWatchListUseCase: sl(),
      addToWatchListUseCase: sl(),
      removeFromWatchListUseCase: sl(),
      getHistoryUseCase: sl(),
      addToHistoryUseCase: sl(),
    ),
  );
}