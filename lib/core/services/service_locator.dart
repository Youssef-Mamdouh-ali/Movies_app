import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app_project/Features/authentication/data/data_source/auth_data_source.dart';
import 'package:movies_app_project/Features/authentication/data/data_source/remote_auth_data_source.dart';
import 'package:movies_app_project/Features/authentication/domain/repositories/auth_repository.dart';
import 'package:movies_app_project/Features/authentication/domain/use_cases/forget_password_use_case.dart';
import 'package:movies_app_project/Features/authentication/domain/use_cases/sign_in_use_case.dart';
import 'package:movies_app_project/Features/authentication/domain/use_cases/sign_up_use_case.dart';
import 'package:movies_app_project/Features/authentication/presentation/manager/auth_bloc.dart';

import '../../Features/authentication/data/repositories_imp/auth_repository_imp.dart';
import '../../Features/home/data/data_sorces/home_remote_data_source.dart';
import '../../Features/home/data/repositories/home_repositories.dart';
import '../../Features/home/domain/usecases/get_movies_by_genre_use_case.dart';
import '../../Features/home/domain/usecases/get_recent_movies_use_case.dart';
import '../../Features/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // 1. Data Source
  sl.registerLazySingleton<AuthDataSource>(() => RemoteAuthDataSource());

  // 2. Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(sl()));

  // 3. Use Case
  sl.registerLazySingleton(() => SignInUseCase(sl()));

  sl.registerLazySingleton(() => SignUpUseCase(sl()));

  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));

  // 4. Bloc
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl()));
}

Future<void> initDependencies() async {
  sl.registerLazySingleton<http.Client>(() => http.Client());

  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<GetRecentMoviesUseCase>(
    () => GetRecentMoviesUseCase(sl()),
  );
  sl.registerLazySingleton<GetMoviesByGenreUseCase>(
    () => GetMoviesByGenreUseCase(sl()),
  );

  sl.registerFactory<HomeBloc>(
    () => HomeBloc(getRecentMoviesUseCase: sl(), getMoviesByGenreUseCase: sl()),
  );
}
